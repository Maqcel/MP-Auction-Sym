import 'package:auction_sym/extensions/extension_mixin.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class PageTitleBar extends TitleBar with ExtensionMixin {
  const PageTitleBar({super.key});

  @override
  Widget build(BuildContext context) => TitleBar(
        centerTitle: true,
        title: Text(
          context.localization.titleBarText,
        ),
      );
}
