import 'dart:async';
import 'dart:math';

import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macos_ui/macos_ui.dart';

class SidebarContent extends StatefulWidget with ExtensionMixin {
  final BoxConstraints constraints;
  final Client? client;

  const SidebarContent({
    super.key,
    required this.constraints,
    required this.client,
  });

  @override
  State<SidebarContent> createState() => _SidebarContentState();
}

class _SidebarContentState extends State<SidebarContent> {
  late final Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();

    _refreshTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _refreshScreen(),
    );
  }

  void _refreshScreen() => setState(() {});

  @override
  Widget build(BuildContext context) => Container(
        decoration: _decoration(context),
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        width: widget.constraints.maxWidth * 0.2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.client == null
                ? _sideBarEmpty(context)
                : [
                    const SizedBox(height: Dimens.s),
                    _sidebarTile(
                      context,
                      const Icon(
                        Icons.timer_rounded,
                        color: Colors.white70,
                      ),
                      context.localization.timeWaitingInQueText(
                        NumberFormat('00')
                            .format(widget.client!.getWaitingTime ~/ 3600),
                        NumberFormat('00')
                            .format(widget.client!.getWaitingTime ~/ 60),
                        NumberFormat('00')
                            .format(widget.client!.getWaitingTime % 60),
                      ),
                    ),
                    const SizedBox(height: Dimens.s),
                    _sidebarTile(
                      context,
                      const Icon(
                        Icons.folder_copy_rounded,
                        color: Colors.white70,
                      ),
                      context.localization
                          .clientFilesAmountText(widget.client!.files.length),
                    ),
                    const SizedBox(height: Dimens.s),
                    Padding(
                      padding: const EdgeInsets.only(left: Dimens.s),
                      child: Text(
                        context.localization.sideBarFilesHeaderText,
                        style: MacosTheme.of(context).typography.title2,
                      ),
                    ),
                    const SizedBox(height: Dimens.s),
                    ...widget.client!.files
                        .map(
                          (file) => _sidebarTile(
                            context,
                            const Icon(
                              Icons.storage_rounded,
                              color: Colors.white70,
                            ),
                            context.localization.clientFilesSizeText(file.size),
                          ),
                        )
                        .toList(),
                  ],
          ),
        ),
      );

  List<Widget> _sideBarEmpty(BuildContext context) => [
        const Spacer(),
        Text(
          context.localization.sideBarClientNotSelected,
          style: MacosTheme.of(context).typography.title2,
        ),
        const Spacer(),
      ];

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
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}
