import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final String id;

  const Client({required this.id});

  @override
  List<Object> get props => [id];
}
