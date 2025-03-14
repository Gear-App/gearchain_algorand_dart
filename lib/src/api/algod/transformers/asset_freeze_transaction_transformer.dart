import '../../../../algorand_dart.dart';
import 'algod_transformer.dart';

class AssetFreezeTransactionTransformer
    extends AlgodTransformer<RawTransaction, AssetFreezeTransactionResponse?> {
  const AssetFreezeTransactionTransformer();

  @override
  AssetFreezeTransactionResponse? transform(RawTransaction input) {
    if (input is! AssetFreezeTransaction) {
      return null;
    }

    return AssetFreezeTransactionResponse(
      address: input.freezeAddress?.encodedAddress ?? '',
      assetId: input.assetId ?? 0,
      newFreezeStatus: input.freeze ?? false,
    );
  }
}
