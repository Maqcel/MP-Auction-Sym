import 'dart:isolate';

import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/domain/model/server_representation.dart';
import 'package:equatable/equatable.dart';

class SimulationServer extends Equatable {
  final ReceivePort receivePort;
  final Stream<dynamic> broadcastStream;
  final SendPort communicationPort;

  const SimulationServer({
    required this.receivePort,
    required this.broadcastStream,
    required this.communicationPort,
  });

  /// Dart doesn't support async constructors
  /// Hence this static method
  static Future<SimulationServer> createServer() async {
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(
      _serverWork,
      receivePort.sendPort,
    );

    final Stream<dynamic> broadcastStream = receivePort.asBroadcastStream();

    /// In order to have two way communication with Isolate (server)
    /// in _serverWork method first thing that we do is to send port to communicate
    final SendPort communicationPort = await broadcastStream.first;

    return SimulationServer(
      receivePort: receivePort,
      broadcastStream: broadcastStream,
      communicationPort: communicationPort,
    );
  }

  void startClientOccupation(Client client) => communicationPort.send(client);

  @override
  List<Object?> get props => [
        receivePort,
        broadcastStream,
        communicationPort,
      ];
}

/// Isolate methods needs to be implemented globally
Future<void> _serverWork(SendPort sendPort) async {
  final ReceivePort receivePort = ReceivePort();

  sendPort.send(receivePort.sendPort);

  final Stream<Client> clients =
      receivePort.takeWhile((content) => content is Client).cast<Client>();

  await clients.forEach((client) async {
    for (var i = 0; i < 10;) {
      sendPort.send(ServerRepresentation(
        occupiedBy: client,
        progress: ++i * 10,
      ));
      await Future.delayed(const Duration(milliseconds: 250));
    }
    sendPort.send(const ServerRepresentation());
  });
}
