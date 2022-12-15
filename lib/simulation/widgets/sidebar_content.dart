import 'dart:math';

import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macos_ui/macos_ui.dart';

class SidebarContent extends StatelessWidget with ExtensionMixin {
  final Client _client;
  final ScrollController _scrollController;

  const SidebarContent({
    super.key,
    required Client client,
    required ScrollController scrollController,
  })  : _client = client,
        _scrollController = scrollController;

  // TODO: Remove mocks
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.m),
          child: Column(
            children: [
              _sidebarTile(
                context,
                const MacosIcon(
                  CupertinoIcons.timer,
                  color: Colors.white,
                ),
                context.localization.timeWaitingInQueText(
                  NumberFormat('00').format(DateTime.now().minute),
                  NumberFormat('00').format(DateTime.now().second),
                ),
              ),
              const SizedBox(height: Dimens.s),
              _sidebarTile(
                context,
                const MacosIcon(
                  CupertinoIcons.folder_circle,
                  color: Colors.white,
                ),
                context.localization.clientFilesAmountText(Random().nextInt(5)),
              ),
              const SizedBox(height: Dimens.s),
              _sidebarTile(
                context,
                const MacosIcon(
                  CupertinoIcons.arrow_up_bin,
                  color: Colors.white,
                ),
                context.localization
                    .clientFilesSizeText(Random().nextInt(321) + 100),
              ),
            ],
          ),
        ),
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
