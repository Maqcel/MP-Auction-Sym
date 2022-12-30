import 'package:auction_sym/domain/service/generator_service.dart';

class GeneratorServiceImpl extends GeneratorService {
  int counter = 0;
  @override
  String generateClientId() => '#${++counter}';
}
