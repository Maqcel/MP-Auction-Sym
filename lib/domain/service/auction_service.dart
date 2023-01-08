import 'package:auction_sym/domain/model/client.dart';

abstract class AuctionService {
  Future<Client> getAuctionWinner(List<Client> waitingClients);
}
