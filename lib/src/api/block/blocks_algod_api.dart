import 'dart:typed_data';

import '../algod/transformers/block_transformer.dart';
import '../api.dart';
import 'block_algod_service.dart';
import '../../utils/encoders/msgpack_encoder.dart';
import 'package:dio/dio.dart';

class BlocksAlgodApi {
  final AlgorandApi _api;
  final BlockAlgodService _service;

  BlocksAlgodApi({
    required AlgorandApi api,
    required BlockAlgodService service,
  })  : _api = api,
        _service = service;

  /// Lookup a block it the given round number.
  ///
  /// Throws an [AlgorandException] if there is an HTTP error.
  /// Returns the block in the given round number.
  Future<Block> getBlockByRound(
    BigInt round, {
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _api.execute<Block>(
      () async {
        final response = await _service.getBlockByRound(
          round: round,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );

        final data = Encoder.decodeMessagePack(Uint8List.fromList(response));
        final block =
            AlgodBlock.fromJson(data['block'] as Map<String, dynamic>);

        return block;
      },
      transformer: BlockTransformer(),
    );
  }
}
