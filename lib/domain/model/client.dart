import 'dart:math';

import 'package:auction_sym/domain/model/simulation_file.dart';
import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final String id;
  final List<SimulationFile> files;
  final Stopwatch waitingTimer;

  /// Can't be const because of [Stopwatch]
  // ignore: prefer_const_constructors_in_immutables
  Client({
    required this.id,
    required this.files,
    required this.waitingTimer,
  });

  factory Client.createClient({required String id}) => Client(
        id: id,
        files: List.generate(
          Random().nextInt(6) + 1,
          (_) => SimulationFile(size: Random().nextInt(1000) + 24),
        )..sort((a, b) => a.size.compareTo(b.size)),
        waitingTimer: Stopwatch()..start(),
      );

  Client markFileAsSend() {
    List<SimulationFile> newFiles = List.from(files);
    newFiles
      ..add(newFiles.first.markAsSend())
      ..removeAt(0);
    return Client(id: id, files: newFiles, waitingTimer: waitingTimer);
  }

  int get getWaitingTime => waitingTimer.elapsed.inSeconds;

  @override
  List<Object> get props => [
        id,
        files,
        waitingTimer,
      ];
}
