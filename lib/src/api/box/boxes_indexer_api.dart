import '../api.dart';
import 'box_indexer_service.dart';
import 'package:dio/dio.dart';

class BoxesIndexerApi {
  final AlgorandApi _api;
  final BoxIndexerService _service;

  BoxesIndexerApi({
    required AlgorandApi api,
    required BoxIndexerService service,
  })  : _api = api,
        _service = service;

  /// Get box information for a given application.
  ///
  /// Given an application ID and box name, it returns the box name and value
  /// (each base64 encoded).
  /// Box names must be in the goal app call arg encoding form 'encoding:value'.
  /// For ints, use the form 'int:1234'.
  /// For raw bytes, use the form 'b64:A=='.
  /// For printable strings, use the form 'str:hello'.
  /// For addresses, use the form 'addr:XYZ...'.
  ///
  /// Throws an [AlgorandException] if there is an HTTP error.
  /// Returns the block in the given round number.
  Future<BoxResponse> getBoxByApplicationId(
    int applicationId,
    String name, {
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _api.execute<BoxResponse>(
      () => _service.getBoxByApplicationId(
        applicationId: applicationId,
        name: name,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// Get all box names for a given application.
  ///
  /// Given an application ID, return all Box names.
  /// No particular ordering is guaranteed.
  /// Request fails when client or server-side configured limits prevent
  /// returning all Box names.
  ///
  /// Throws an [AlgorandException] if there is an HTTP error.
  /// Returns the block in the given round number.
  Future<List<BoxDescriptor>> getBoxNamesByApplicationId(
    int applicationId, {
    int? limit,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _api.paginate<BoxDescriptor>((nextToken) async {
      final response = await _service.getBoxNamesByApplicationId(
        applicationId: applicationId,
        limit: limit,
        next: nextToken,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return PaginatedResult(
        nextToken: response.nextToken,
        items: response.boxes,
      );
    });
  }
}
