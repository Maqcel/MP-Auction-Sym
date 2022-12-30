import 'package:auction_sym/domain/model/server_representation.dart';
import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class ServerTile extends StatelessWidget with ExtensionMixin {
  final bool _isOnlyContent;
  final BoxConstraints _constraints;
  final ServerRepresentation _server;

  const ServerTile({
    super.key,
    required bool isOnlyContent,
    required BoxConstraints constraints,
    required ServerRepresentation server,
  })  : _isOnlyContent = isOnlyContent,
        _constraints = constraints,
        _server = server;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: _constraints.maxHeight * 0.05,
          horizontal: _constraints.maxWidth * 0.02,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.m,
            horizontal: Dimens.s,
          ),
          decoration: _decoration(context),
          constraints: BoxConstraints(
            maxHeight: _constraints.maxHeight * 0.2,
            maxWidth: _constraints.maxWidth * (_isOnlyContent ? 0.15 : 0.1),
            minHeight: _constraints.maxHeight * 0.1,
            minWidth: _constraints.maxWidth * (_isOnlyContent ? 0.1 : 0.05),
          ),
          child: _server.occupiedBy != null
              ? _uploadingContent(context)
              : _waitingForContent(context),
        ),
      );

  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
        color: MacosTheme.of(context).canvasColor,
        boxShadow: [
          const BoxShadow(
            color: Colors.black54,
            offset: Offset(Dimens.s / 2, Dimens.s / 2),
            blurRadius: Dimens.s / 2,
          ),
          BoxShadow(
            color: MacosTheme.of(context).dividerColor,
            offset: const Offset(-Dimens.s / 2, -Dimens.s / 2),
            blurRadius: Dimens.s / 2,
          ),
        ],
      );

  Widget _uploadingContent(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              context.localization
                  .auctionServerUploadingClientText(_server.occupiedBy!.id),
              style: MacosTheme.of(context).typography.body,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // TODO: Create smoother animation
            ProgressBar(value: _server.progress.toDouble()),
          ],
        ),
      );

  Widget _waitingForContent(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.localization.auctionServerNoClientText,
              style: MacosTheme.of(context).typography.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.m),
            Icon(
              Icons.upload_outlined,
              size: _constraints.maxWidth * 0.025,
              color: Colors.green,
            ),
          ],
        ),
      );
}
