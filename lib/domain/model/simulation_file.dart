import 'package:equatable/equatable.dart';

class SimulationFile extends Equatable {
  final int size;
  final bool isSend;

  const SimulationFile({
    required this.size,
    this.isSend = false,
  });

  SimulationFile markAsSend() => SimulationFile(
        size: size,
        isSend: true,
      );

  @override
  List<Object> get props => [
        size,
        isSend,
      ];
}
