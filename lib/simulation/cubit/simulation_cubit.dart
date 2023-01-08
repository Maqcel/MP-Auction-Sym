import 'dart:async';

import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/domain/model/server_representation.dart';
import 'package:auction_sym/domain/model/simulation_server.dart';
import 'package:auction_sym/domain/service/auction_service.dart';
import 'package:auction_sym/domain/service/generator_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'simulation_state.dart';

class SimulationCubit extends Cubit<SimulationState> {
  final GeneratorService _generatorService;
  final AuctionService _auctionService;

  SimulationCubit(
    this._generatorService,
    this._auctionService,
  ) : super(const SimulationState.simulationStart());

  late final List<SimulationServer> _simulationServers;
  late final List<StreamSubscription?> _serversSubscriptions;

  Future<void> startSimulation() async {
    const int amountOfServers = 5;

    _simulationServers = await Future.wait(
      List<Future<SimulationServer>>.generate(
        amountOfServers,
        (_) => SimulationServer.createServer(),
      ),
    );

    _serversSubscriptions = _simulationServers
        .mapIndexed((index, server) => server.broadcastStream.listen(
              (event) => handleServerEvents(
                index,
                event,
              ),
            ))
        .toList();

    emit(
      SimulationState.simulationState(
          servers: List.generate(
        _simulationServers.length,
        (_) => const ServerRepresentation(isAuctionRunning: false),
      )),
    );
  }

  Future<void> handleServerEvents(
    int serverIndex,
    ServerRepresentation event,
  ) async {
    SimulationStateSimulationState simulationState =
        state as SimulationStateSimulationState;

    if (event.progress == 100) {
      _emitServerAuctionStatus(
        true,
        serverIndex,
        simulationState,
      );

      _handleClientAfterAuction(event.occupiedBy!);

      // State was updated in _handleClientAfterAuction
      simulationState = state as SimulationStateSimulationState;

      // Wait for new clients
      if (simulationState.clients.isEmpty) {
        _emitServerAuctionStatus(
          false,
          serverIndex,
          simulationState,
        );
        return;
      }

      await _handleNewAuction(serverIndex);
    } else {
      emit(simulationState.copyWith(
        servers: List.from(simulationState.servers)
          ..removeAt(serverIndex)
          ..insert(serverIndex, event),
      ));
    }
  }

  void _emitServerAuctionStatus(
    bool isAuctionRunning,
    int serverIndex,
    SimulationStateSimulationState simulationState,
  ) =>
      emit(simulationState.copyWith(
        servers: List.from(simulationState.servers)
          ..removeAt(serverIndex)
          ..insert(
            serverIndex,
            ServerRepresentation(isAuctionRunning: isAuctionRunning),
          ),
      ));

  void _handleClientAfterAuction(Client client) {
    final SimulationStateSimulationState simulationState =
        state as SimulationStateSimulationState;

    Client updatedClient = client.markFileAsSend();
    if (updatedClient.files.firstWhereOrNull((element) => !element.isSend) ==
        null) {
      emit(simulationState.copyWith(
        clients: List.from(simulationState.clients)
          ..removeWhere((element) => element.id == client.id),
        selectedClient: simulationState.selectedClient != null
            ? simulationState.selectedClient!.id == client.id
                ? null
                : simulationState.selectedClient
            : null,
      ));
    } else {
      int clientIndex = simulationState.clients.indexOf(simulationState.clients
          .firstWhere((element) => element.id == client.id));

      List<Client> updatedClientsList = List.from(simulationState.clients)
        ..removeAt(clientIndex)
        ..insert(clientIndex, updatedClient);

      emit(simulationState.copyWith(
        clients: updatedClientsList,
        selectedClient: simulationState.selectedClient != null
            ? simulationState.selectedClient!.id == client.id
                ? updatedClient
                : simulationState.selectedClient
            : null,
      ));
    }
  }

  Future<void> _handleNewAuction(int serverIndex) async {
    final SimulationStateSimulationState simulationState =
        state as SimulationStateSimulationState;

    List<String> sendingIds = [];

    simulationState.servers.forEach((server) {
      if (server.occupiedBy != null) {
        sendingIds.add(server.occupiedBy!.id);
      }
    });

    // All clients currently sending no need for auction
    List<Client> clientsForAuction = List.from(simulationState.clients)
      ..removeWhere((client) => sendingIds.contains(client.id));

    if (clientsForAuction.isEmpty) {
      _emitServerAuctionStatus(
        false,
        serverIndex,
        simulationState,
      );
      return;
    }

    Client auctionWinner =
        await _auctionService.getAuctionWinner(clientsForAuction);

    _simulationServers[serverIndex].startClientOccupation(auctionWinner);
  }

  void addNewClient() {
    final Client newClient =
        Client.createClient(id: _generatorService.generateClientId());
    SimulationStateSimulationState currentState =
        state as SimulationStateSimulationState;
    emit(currentState.copyWith(
        clients: List.from(currentState.clients)..add(newClient)));

    currentState = state as SimulationStateSimulationState;

    ServerRepresentation? serverRepresentation = currentState.servers
        .firstWhereOrNull(
            (server) => server.occupiedBy == null && !server.isAuctionRunning);

    if (serverRepresentation == null) return;

    return _simulationServers[
            currentState.servers.indexOf(serverRepresentation)]
        .startClientOccupation(newClient);
  }

  void changeSelectedClient(Client pickedClient) =>
      emit((state as SimulationStateSimulationState)
          .copyWith(selectedClient: pickedClient));

  @override
  Future<void> close() {
    _serversSubscriptions.forEach((subscription) => subscription?.cancel());
    return super.close();
  }
}
