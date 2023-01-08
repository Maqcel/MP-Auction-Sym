import 'dart:math';

import 'package:auction_sym/data/model/function_params.dart';
import 'package:auction_sym/domain/model/client.dart';
import 'package:auction_sym/domain/service/auction_service.dart';
import 'package:flutter/foundation.dart';

class AuctionServiceImpl extends AuctionService {
  @override
  Future<Client> getAuctionWinner(List<Client> waitingClients) async {
    List<Future<double>> futureClientPriority = waitingClients
        .map((client) => compute(
              _getClientPriority,
              FunctionParams(
                // to MS
                waitingTime: client.getWaitingTime * 1000,
                filesCount: client.files
                    .takeWhile((file) => !file.isSend)
                    .toList()
                    .length,
                fileSize: client.files.first.size,
                clientCount: waitingClients.length,
              ),
            ))
        .toList();

    List<double> clientPriority = await Future.wait(futureClientPriority);

    return waitingClients
        .elementAt(clientPriority.indexOf(clientPriority.reduce(min)));
  }
}

/// Isolate methods needs to be implemented globally
double _getClientPriority(FunctionParams params) =>
    log(1 + params.waitingTime) +
    3 /
        sqrt(
          params.filesCount * params.fileSize + 1,
        ) -
    10 / (params.clientCount + 1);
