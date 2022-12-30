import 'package:auction_sym/domain/model/client.dart';
import 'package:equatable/equatable.dart';

class ServerRepresentation extends Equatable {
  final Client? occupiedBy;
  final int progress;

  const ServerRepresentation({
    this.occupiedBy,
    this.progress = 0,
  });

  @override
  List<Object?> get props => [
        occupiedBy,
        progress,
      ];
}
