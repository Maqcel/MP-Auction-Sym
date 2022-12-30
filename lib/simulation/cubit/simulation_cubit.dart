import 'dart:async';
import 'dart:math';

import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/domain/model/server_representation.dart';
import 'package:auction_sym/domain/model/simulation_server.dart';
import 'package:auction_sym/domain/service/generator_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'simulation_state.dart';

class SimulationCubit extends Cubit<SimulationState> {
  final GeneratorService _generatorService;

  SimulationCubit(this._generatorService)
      : super(const SimulationState.simulationStart());

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
        (_) => const ServerRepresentation(),
      )),
    );
  }

  void handleServerEvents(
    int serverIndex,
    ServerRepresentation event,
  ) =>
      emit((state as SimulationStateSimulationState).copyWith(
        servers: List.from((state as SimulationStateSimulationState).servers)
          ..removeAt(serverIndex)
          ..insert(serverIndex, event),
      ));

  void addNewClient() {
    final Client newClient =
        Client.createClient(id: _generatorService.generateClientId());
    final SimulationStateSimulationState currentState =
        state as SimulationStateSimulationState;
    emit(currentState.copyWith(
        clients: List.from(currentState.clients)..add(newClient)));

    // TODO: Remove temporary functionality test
    /// This is just to test how Isolates work
    if (currentState.servers
            .firstWhereOrNull((element) => element.occupiedBy == null) ==
        null) return;

    int serverIndex;
    do {
      serverIndex = Random().nextInt(5);
    } while (currentState.servers[serverIndex].occupiedBy != null);
    _simulationServers[serverIndex].startClientOccupation(newClient);
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
