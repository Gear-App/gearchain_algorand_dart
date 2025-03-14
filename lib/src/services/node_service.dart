import '../models/models.dart';
import 'api_service.dart';
import 'package:dio/dio.dart';

part 'node_service_impl.dart';

//@RestApi()
abstract class NodeService extends ApiService {
  factory NodeService(Dio dio, {String baseUrl}) = _NodeService;

  //@GET("/genesis")
  Future<String> genesis();

  //@GET("/health")
  Future<void> health();

  //@GET("/v2/status")
  Future<NodeStatus> status();

  //@GET("/v2/status/wait-for-block-after/{roundId}")
  Future<NodeStatus> statusAfterRound(/*@Path('roundId')*/ int roundId);

  //@GET("/v2/ledger/supply")
  Future<LedgerSupply> supply();
}
