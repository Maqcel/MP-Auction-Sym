import 'dart:math';

import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macos_ui/macos_ui.dart';

class SidebarContent extends StatelessWidget with ExtensionMixin {
  final BoxConstraints _constraints;
  final Client _client;

  const SidebarContent({
    super.key,
    required BoxConstraints constraints,
    required Client client,
  })  : _constraints = constraints,
        _client = client;

  // TODO: Remove Mocks
  @override
  Widget build(BuildContext context) => Container(
        decoration: _decoration(context),
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        width: _constraints.maxWidth * 0.2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.m),
          child: Column(
            children: [
              const SizedBox(height: Dimens.s),
              _sidebarTile(
                context,
                const Icon(
                  Icons.timer_rounded,
                  color: Colors.white70,
                ),
                context.localization.timeWaitingInQueText(
                  NumberFormat('00').format(DateTime.now().minute),
                  NumberFormat('00').format(DateTime.now().second),
                ),
              ),
              const SizedBox(height: Dimens.s),
              _sidebarTile(
                context,
                const Icon(
                  Icons.folder_copy_rounded,
                  color: Colors.white70,
                ),
                context.localization.clientFilesAmountText(Random().nextInt(5)),
              ),
              const SizedBox(height: Dimens.s),
              _sidebarTile(
                context,
                const Icon(
                  Icons.storage_rounded,
                  color: Colors.white70,
                ),
                context.localization
                    .clientFilesSizeText(Random().nextInt(321) + 100),
              ),
            ],
          ),
        ),
      );

  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
        color: MacosTheme.of(context).canvasColor,
        border: const Border(right: BorderSide(width: 0)),
        boxShadow: [
          BoxShadow(
            color: MacosTheme.of(context).dividerColor,
            offset: const Offset(Dimens.zero, Dimens.s),
            blurRadius: Dimens.s,
          ),
        ],
      );

  Widget _sidebarTile(
    BuildContext context,
    Widget icon,
    String value,
  ) =>
      Card(
        color: MacosTheme.of(context).dividerColor,
        elevation: Dimens.s,
        child: ListTile(
          leading: icon,
          title: Center(
            child: Text(
              value,
              style: MacosTheme.of(context).typography.title2,
            ),
          ),
        ),
      );
}
