import 'dart:typed_data';

import '../api/responses.dart';
import 'api_service.dart';
import 'package:dio/dio.dart' as dio;

part 'application_service_impl.dart';

//@RestApi()
abstract class ApplicationService extends ApiService {
  factory ApplicationService(dio.Dio dio, {String baseUrl}) =
      _ApplicationService;

  //@POST("/v2/teal/compile")
  //@Headers(<String, dynamic>{"Content-Type": "application/x-binary"})
  //Note stream not needed!?
  Future<TealCompilation> compileTEAL(/*@Body()*/ String sourceCode);

  //@POST("/v2/teal/dryrun")
  //@Headers(<String, dynamic>{"Content-Type": "application/x-binary"})
  Future<DryRunResponse> dryrun(/*@Body()*/ Uint8List request);

  //@GET("/v2/applications")
  Future<SearchApplicationsResponse> searchApplications(
    Map<String, dynamic> queryParameters,
  );
}
