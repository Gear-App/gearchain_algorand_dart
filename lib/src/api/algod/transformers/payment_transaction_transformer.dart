import '../../../../algorand_dart.dart';
import 'algod_transformer.dart';

class PaymentTransactionTransformer
    extends AlgodTransformer<RawTransaction, PaymentTransactionResponse?> {
  const PaymentTransactionTransformer();

  @override
  PaymentTransactionResponse? transform(RawTransaction input) {
    if (input is! PaymentTransaction) {
      return null;
    }

    return PaymentTransactionResponse(
      amount: input.amount ?? BigInt.zero,
      closeAmount: input.closeAmount,
      receiver: input.receiver?.encodedAddress ?? '',
      closeRemainderTo: input.closeRemainderTo?.encodedAddress,
    );
  }
}
