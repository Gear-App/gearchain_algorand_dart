import 'algod/transformers/algod_transformer.dart';
import 'paginated_result.dart';
import '../exceptions/algorand_exception.dart';
import 'package:dio/dio.dart';

class AlgorandApi {
  Future<T> execute<T>(
    Future<dynamic> Function() callback, {
    AlgodTransformer<dynamic, T>? transformer,
  }) async {
    try {
      final response = await callback();
      if (transformer != null) {
        return transformer.transform(response);
      }

      if (response is! T) {
        throw AlgorandException(message: 'Response does not match');
      }

      return response;
    } on DioException catch (ex) {
      throw AlgorandException.fromDioException(ex);
    }
  }

  Future<List<T>> paginate<T>(
    Future<PaginatedResult<T>> Function(String? nextToken) callback,
  ) async {
    final items = <T>[];
    String? nextToken;
    do {
      try {
        final response = await callback(nextToken);

        items.addAll(response.items);
        nextToken = response.nextToken;
      } on DioException catch (ex) {
        throw AlgorandException.fromDioException(ex);
      }
    } while (nextToken != null);

    return items;
  }
}
