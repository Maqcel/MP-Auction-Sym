part of 'extension_mixin.dart';

extension TimerColorExtension on Stopwatch {
  Color get timerColor {
    if (elapsed.inSeconds < 10) {
      return Colors.green;
    } else if (elapsed.inSeconds < 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
