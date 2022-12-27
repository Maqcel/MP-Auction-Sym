import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:auction_sym/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class AddClientButton extends StatelessWidget with ExtensionMixin {
  final Function() _onPressed;

  const AddClientButton({
    super.key,
    required Function() onPressed,
  }) : _onPressed = onPressed;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            decoration: _decoration(context),
            child: Material(
              color: MacosTheme.of(context).canvasColor,
              child: InkWell(
                splashColor: MacosTheme.of(context).dividerColor,
                onTap: () => _onPressed(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimens.s,
                    horizontal: Dimens.m,
                  ),
                  child: Text(
                    context.localization.titleBarActionButtonText,
                    style: MacosTheme.of(context).typography.body,
                  ),
                ),
              ),
            ),
          ),
        ],
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
}
