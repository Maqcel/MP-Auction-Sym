import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/simulation/cubit/simulation_cubit.dart';
import 'package:auction_sym/simulation/cubit/simulation_state.dart';
import 'package:auction_sym/simulation/widgets/auction_server_display.dart';
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
        init: () {
          bool shouldShowSideContent =
              MediaQuery.of(context).size.width >= 900 &&
                  MediaQuery.of(context).size.height >= 250;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MacosTheme.of(context).canvasColor,
              title: Text(
                context.localization.titleBarText,
                style: MacosTheme.of(context).typography.title1,
              ),
            ),
            backgroundColor: MacosTheme.of(context).canvasColor,
            body: LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  Row(
                    children: [
                      if (shouldShowSideContent)
                        _sideBuilder(context, constraints),
                      _mainBuilder(
                        context,
                        shouldShowSideContent,
                        constraints,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        orElse: () => const SizedBox.shrink(),
      );

  Widget _sideBuilder(
    BuildContext context,
    BoxConstraints constraints,
  ) =>
      SidebarContent(
        constraints: constraints,
        client: const Client(id: ''),
      );

  Widget _mainBuilder(
    BuildContext context,
    bool shouldShowSideContent,
    BoxConstraints constraints,
  ) =>
      SizedBox(
        width: constraints.maxWidth * (shouldShowSideContent ? 0.8 : 1.0),
        height: constraints.maxHeight,
        child: Column(
          children: [
            AuctionServerDisplay(
              isOnlyContent: !shouldShowSideContent,
              constraints: constraints,
            ),
          ],
        ),
      );

  void _listener(BuildContext context, SimulationState state) =>
      state.maybeWhen(
        orElse: () => null,
      );
}
