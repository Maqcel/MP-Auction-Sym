import 'dart:math';

import 'package:auction_sym/domain/model/simulation_file.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Client extends Equatable {
  final UniqueKey id;
  final List<SimulationFile> files;
  final Stopwatch waitingTimer;

  /// Can't be const because of [Stopwatch]
  // ignore: prefer_const_constructors_in_immutables
  Client({
    required this.id,
    required this.files,
    required this.waitingTimer,
  });

  factory Client.createClient() => Client(
        id: UniqueKey(),
        files: List.generate(
          Random().nextInt(6) + 1,
          (_) => SimulationFile(size: Random().nextInt(1000) + 24),
        )..sort((a, b) => a.size.compareTo(b.size)),
        waitingTimer: Stopwatch()..start(),
      );

  int get getWaitingTime => waitingTimer.elapsed.inSeconds;

  @override
  List<Object> get props => [
        id,
        files,
        waitingTimer,
      ];
}
