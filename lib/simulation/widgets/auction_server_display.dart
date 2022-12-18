import 'package:auction_sym/simulation/widgets/server_tile.dart';
import 'package:flutter/material.dart';

class AuctionServerDisplay extends StatelessWidget {
  final bool _isOnlyContent;
  final BoxConstraints _constraints;

  const AuctionServerDisplay({
    super.key,
    required bool isOnlyContent,
    required BoxConstraints constraints,
  })  : _isOnlyContent = isOnlyContent,
        _constraints = constraints;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) => ServerTile(
            isOnlyContent: _isOnlyContent,
            constraints: _constraints,
          ),
        ),
      );
}
