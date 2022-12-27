import 'dart:math';

import 'package:auction_sym/simulation/widgets/client_tile.dart';
import 'package:flutter/material.dart';

class ClientGridDisplay extends StatelessWidget {
  final BoxConstraints _constraints;

  const ClientGridDisplay({
    super.key,
    required BoxConstraints constraints,
  }) : _constraints = constraints;

  // TODO: Remove mocks
  @override
  Widget build(BuildContext context) => Expanded(
        child: GridView.count(
          crossAxisCount: _generateNumberOfColumns(),
          children: List.generate(
            10,
            (index) => ClientTile(
              isSelected: index == 2,
              isSending: Random().nextBool(),
              constraints: _constraints,
            ),
          ),
        ),
      );

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
