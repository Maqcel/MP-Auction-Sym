import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/domain/model/server_representation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_state.freezed.dart';

@freezed
class SimulationState with _$SimulationState {
  const factory SimulationState.simulationStart() =
      SimulationStateSimulationStart;

  const factory SimulationState.simulationState({
    @Default([]) List<ServerRepresentation> servers,
    @Default([]) List<Client> clients,
    Client? selectedClient,
  }) = SimulationStateSimulationState;
}
