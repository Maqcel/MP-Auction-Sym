import 'package:auction_sym/domain/model/client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_state.freezed.dart';

@freezed
class SimulationState with _$SimulationState {
  const factory SimulationState.simulationState({
    @Default([]) List<Client> clients,
    Client? selectedClient,
  }) = SimulationStateInit;
}
