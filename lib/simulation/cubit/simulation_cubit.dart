import 'package:flutter_bloc/flutter_bloc.dart';

import 'simulation_state.dart';

class SimulationCubit extends Cubit<SimulationState> {
  SimulationCubit() : super(const SimulationState.init());
}
