part of 'extension_mixin.dart';

extension BuildContextExtension on BuildContext {
  Strings get localization => Strings.of(this);
}
