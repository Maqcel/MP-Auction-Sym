import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/domain/model/server_representation.dart';
import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/simulation/widgets/client_tile.dart';
import 'package:auction_sym/style/dimens.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class ClientGridDisplay extends StatelessWidget with ExtensionMixin {
  final BoxConstraints _constraints;
  final List<ServerRepresentation> _servers;
  final List<Client> _clients;
  final Client? _selectedClient;
  final Function(Client) _onTilePressed;

  const ClientGridDisplay({
    super.key,
    required BoxConstraints constraints,
    required List<ServerRepresentation> servers,
    required List<Client> clients,
    required Client? selectedClient,
    required Function(Client) onTilePressed,
  })  : _constraints = constraints,
        _servers = servers,
        _clients = clients,
        _selectedClient = selectedClient,
        _onTilePressed = onTilePressed;

  @override
  Widget build(BuildContext context) => Expanded(
        child: GridView.count(
          crossAxisCount: _generateNumberOfColumns(),
          children: _clients.isEmpty
              ? _clientsEmpty(context)
              : _clients
                  .map(
                    (client) => ClientTile(
                      client: client,
                      isSelected: client.id == _selectedClient?.id,
                      isSending: _servers.firstWhereOrNull(
                              (server) => server.occupiedBy?.id == client.id) !=
                          null,
                      constraints: _constraints,
                      onTilePressed: _onTilePressed,
                    ),
                  )
                  .toList(),
        ),
      );

  List<Widget> _clientsEmpty(BuildContext context) => [
        Padding(
          padding: const EdgeInsets.only(left: Dimens.l),
          child: Text(
            context.localization.clientsEmptyText,
            style: MacosTheme.of(context).typography.title1,
          ),
        )
      ];

  int _generateNumberOfColumns() {
    if (_constraints.maxWidth >= 1100) {
      return 4;
    } else if (_constraints.maxWidth >= 700) {
      return 3;
    } else {
      return 2;
    }
  }
}
