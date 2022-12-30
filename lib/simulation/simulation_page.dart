import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/domain/model/server_representation.dart';
import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/simulation/cubit/simulation_cubit.dart';
import 'package:auction_sym/simulation/cubit/simulation_state.dart';
import 'package:auction_sym/simulation/widgets/add_client_button.dart';
import 'package:auction_sym/simulation/widgets/auction_server_display.dart';
import 'package:auction_sym/simulation/widgets/clients_gird_display.dart';
import 'package:auction_sym/simulation/widgets/sidebar_content.dart';
import 'package:auction_sym/style/dimens.dart';
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

  bool _buildWhen(SimulationState previous, SimulationState current) =>
      current is SimulationStateSimulationState;

  Widget _builder(BuildContext context, SimulationState state) =>
      state.maybeWhen(
        simulationState: (
          servers,
          clients,
          selectedClient,
        ) {
          bool shouldShowSideContent =
              MediaQuery.of(context).size.width >= 900 &&
                  MediaQuery.of(context).size.height >= 250;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MacosTheme.of(context).canvasColor,
              centerTitle: true,
              title: Text(
                context.localization.titleBarText,
                style: MacosTheme.of(context).typography.title1,
              ),
              actions: [
                AddClientButton(
                    onPressed: context.read<SimulationCubit>().addNewClient),
                const SizedBox(width: Dimens.m),
              ],
            ),
            backgroundColor: MacosTheme.of(context).canvasColor,
            body: LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  Row(
                    children: [
                      if (shouldShowSideContent)
                        _sideBuilder(
                          context,
                          constraints,
                          selectedClient,
                        ),
                      _mainBuilder(
                        context,
                        shouldShowSideContent,
                        constraints,
                        servers,
                        clients,
                        selectedClient,
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
    Client? selectedClient,
  ) =>
      SidebarContent(
        constraints: constraints,
        client: selectedClient,
      );

  Widget _mainBuilder(
    BuildContext context,
    bool shouldShowSideContent,
    BoxConstraints constraints,
    List<ServerRepresentation> servers,
    List<Client> clients,
    Client? selectedClient,
  ) =>
      SizedBox(
        width: constraints.maxWidth * (shouldShowSideContent ? 0.8 : 1.0),
        height: constraints.maxHeight,
        child: Column(
          children: [
            AuctionServerDisplay(
              isOnlyContent: !shouldShowSideContent,
              constraints: constraints,
              servers: servers,
            ),
            ClientGridDisplay(
              constraints: constraints,
              servers: servers,
              clients: clients,
              selectedClient: selectedClient,
              onTilePressed:
                  context.read<SimulationCubit>().changeSelectedClient,
            ),
          ],
        ),
      );

  void _listener(BuildContext context, SimulationState state) =>
      state.maybeWhen(
        orElse: () => null,
      );
}
