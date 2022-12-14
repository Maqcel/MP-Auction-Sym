import 'package:auction_sym/simulation/cubit/simulation_cubit.dart';
import 'package:auction_sym/simulation/cubit/simulation_state.dart';
import 'package:auction_sym/simulation/widgets/page_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';

class SimulationPage extends StatefulWidget {
  const SimulationPage({super.key});

  @override
  State<SimulationPage> createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<SimulationCubit, SimulationState>(
        buildWhen: _buildWhen,
        builder: _builder,
        listener: _listener,
      );

  bool _buildWhen(SimulationState previous, SimulationState current) => true;

  Widget _builder(BuildContext context, SimulationState state) =>
      state.maybeWhen(
        init: () => const MacosWindow(
          titleBar: PageTitleBar(),
          child: Center(
            child: FlutterLogo(),
          ),
        ),
        orElse: () => const SizedBox.shrink(),
      );

  void _listener(BuildContext context, SimulationState state) =>
      state.maybeWhen(
        orElse: () => null,
      );
}
