import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class ClientTile extends StatelessWidget with ExtensionMixin {
  final Client _client;
  final bool _isSelected;
  final bool _isSending;
  final BoxConstraints _constraints;
  final Function(Client) _onTilePressed;

  const ClientTile({
    super.key,
    required Client client,
    required bool isSelected,
    required bool isSending,
    required BoxConstraints constraints,
    required Function(Client) onTilePressed,
  })  : _client = client,
        _isSelected = isSelected,
        _isSending = isSending,
        _constraints = constraints,
        _onTilePressed = onTilePressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: _constraints.maxHeight * 0.05,
          horizontal: _constraints.maxWidth * 0.02,
        ),
        child: GestureDetector(
          onTap: () => _onTilePressed(_client),
          child: Container(
            decoration: _isSelected
                ? _decorationSelected(context)
                : _decorationNotSelected(context, _isSending),
            constraints: BoxConstraints(
              maxHeight: _constraints.maxHeight * 0.2,
              maxWidth: _constraints.maxWidth * 0.25,
              minHeight: _constraints.maxHeight * 0.1,
              minWidth: _constraints.maxWidth * 0.15,
            ),
            padding: const EdgeInsets.all(Dimens.m),
            child: LayoutBuilder(
              builder: (context, constraints) => _clientContent(
                context,
                constraints,
              ),
            ),
          ),
        ),
      );

  BoxDecoration _decorationSelected(BuildContext context) => BoxDecoration(
        color: MacosTheme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade900,
            offset: const Offset(Dimens.s / 2, Dimens.s / 2),
            blurRadius: Dimens.s / 2,
          ),
          const BoxShadow(
            color: Colors.red,
            offset: Offset(-Dimens.s / 2, -Dimens.s / 2),
            blurRadius: Dimens.s / 2,
          ),
        ],
      );

  BoxDecoration _decorationNotSelected(
    BuildContext context,
    bool colorShift,
  ) =>
      BoxDecoration(
        color: MacosTheme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: !colorShift
                ? Colors.black54
                : MacosTheme.of(context).primaryColor.withOpacity(0.8),
            offset: const Offset(Dimens.s / 2, Dimens.s / 2),
            blurRadius: Dimens.s / 2,
          ),
          BoxShadow(
            color: !colorShift
                ? MacosTheme.of(context).dividerColor
                : MacosTheme.of(context).primaryColor.withOpacity(0.5),
            offset: const Offset(-Dimens.s / 2, -Dimens.s / 2),
            blurRadius: Dimens.s / 2,
          ),
        ],
      );

  Widget _clientContent(
    BuildContext context,
    BoxConstraints constraints,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _timeAndNameRow(
            context,
            constraints,
          ),
          _filesRow(
            context,
            constraints,
          )
        ],
      );

  Widget _timeAndNameRow(
    BuildContext context,
    BoxConstraints constraints,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: Dimens.l,
            width: Dimens.l,
            decoration: _decorationNotSelected(context, false),
            child: Icon(
              Icons.timer_rounded,
              size: Dimens.m,
              color: _client.waitingTimer.timerColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxHeight / 10,
              vertical: constraints.maxWidth / 15,
            ),
            decoration: _decorationNotSelected(context, false),
            child: Text(
              context.localization.clientTileIdText(_client.id),
              style: MacosTheme.of(context).typography.body,
            ),
          )
        ],
      );

  Widget _filesRow(
    BuildContext context,
    BoxConstraints constraints,
  ) =>
      Container(
        decoration: _decorationNotSelected(context, false),
        padding: const EdgeInsets.all(Dimens.s),
        child: Row(
          children: _client.files
              .map((file) => Container(
                    height: Dimens.l,
                    width: (constraints.maxWidth - Dimens.s * 2) /
                        _client.files.length,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: MacosTheme.of(context).canvasColor),
                      color: file.isSend
                          ? MacosTheme.of(context).dividerColor
                          : Colors.green.shade600,
                    ),
                  ))
              .toList(),
        ),
      );
}
