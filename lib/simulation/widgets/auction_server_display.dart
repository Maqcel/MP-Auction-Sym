import 'package:auction_sym/domain/model/server_representation.dart';
import 'package:auction_sym/simulation/widgets/server_tile.dart';
import 'package:flutter/material.dart';

class AuctionServerDisplay extends StatelessWidget {
  final bool _isOnlyContent;
  final BoxConstraints _constraints;
  final List<ServerRepresentation> _servers;

  const AuctionServerDisplay({
    super.key,
    required bool isOnlyContent,
    required BoxConstraints constraints,
    required List<ServerRepresentation> servers,
  })  : _isOnlyContent = isOnlyContent,
        _constraints = constraints,
        _servers = servers;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _servers
            .map(
              (server) => ServerTile(
                isOnlyContent: _isOnlyContent,
                constraints: _constraints,
                server: server,
              ),
            )
            .toList(),
      );
}
