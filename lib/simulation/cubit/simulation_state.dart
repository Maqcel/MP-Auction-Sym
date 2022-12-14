import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_state.freezed.dart';

@freezed
class SimulationState with _$SimulationState {
  const factory SimulationState.init() = SimulationStateInit;
}
