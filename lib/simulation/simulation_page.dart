import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/simulation/cubit/simulation_cubit.dart';
import 'package:auction_sym/simulation/cubit/simulation_state.dart';
import 'package:auction_sym/simulation/widgets/sidebar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';

class SimulationPage extends StatefulWidget with ExtensionMixin {
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
        init: () => MacosWindow(
          sidebar: Sidebar(
            builder: (context, scrollController) => SidebarContent(
              client: const Client(id: ''),
              scrollController: scrollController,
            ),
            minWidth: MediaQuery.of(context).size.width * 0.2,
          ),
          child: MacosScaffold(
              toolBar: ToolBar(
            centerTitle: true,
            title: Text(
              context.localization.titleBarText,
            ),
          )),
        ),
        orElse: () => const SizedBox.shrink(),
      );

  void _listener(BuildContext context, SimulationState state) =>
      state.maybeWhen(
        orElse: () => null,
      );
}
