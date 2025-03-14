import 'dart:typed_data';

import '../api/responses.dart';
import '../models/models.dart';
import 'api_service.dart';
import 'package:dio/dio.dart' as dio;

part 'transaction_service_impl.dart';

//@RestApi()
abstract class TransactionService extends ApiService {
  factory TransactionService(dio.Dio dio, {String baseUrl}) =
      _TransactionService;

  //@GET("/v2/transactions/params")
  Future<TransactionParams> getSuggestedTransactionParams();

  //@POST("/v2/transactions")
  //@Headers(<String, dynamic>{"Content-Type": "application/x-binary"})
  Future<TransactionIdResponse> sendTransaction(/*@Body()*/ Uint8List data);

  //@GET("/v2/accounts/{address}/transactions/pending")
  Future<PendingTransactionsResponse> getPendingTransactionsByAddress(
    /*@Path('address')*/ String address, {
    /*@Query('max')*/ int max = 0,
  });

  //@GET("/v2/transactions/pending")
  Future<PendingTransactionsResponse> getPendingTransactions({
    /*@Query('max')*/ int max = 0,
  });

  //@GET("/v2/transactions/pending/{transactionId}")
  Future<PendingTransaction> getPendingTransactionById(
    /*@Path('transactionId')*/ String transactionId,
  );
}
