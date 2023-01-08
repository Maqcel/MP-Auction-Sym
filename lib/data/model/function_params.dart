import 'package:equatable/equatable.dart';

class FunctionParams extends Equatable {
  // ? T
  final int waitingTime;
  // ? C
  final int filesCount;
  // ? S
  final int fileSize;
  // ? Q
  final int clientCount;

  const FunctionParams({
    required this.waitingTime,
    required this.filesCount,
    required this.fileSize,
    required this.clientCount,
  });

  @override
  List<Object> get props => [
        waitingTime,
        filesCount,
        fileSize,
        clientCount,
      ];
}
