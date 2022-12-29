import 'package:auction_sym/domain/model/client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'simulation_state.dart';

class SimulationCubit extends Cubit<SimulationState> {
  SimulationCubit() : super(const SimulationState.simulationState());

  void addNewClient() => emit(state.copyWith(
      clients: List.from(state.clients)..add(Client.createClient())));

  void changeSelectedClient(Client pickedClient) =>
      emit(state.copyWith(selectedClient: pickedClient));
}
