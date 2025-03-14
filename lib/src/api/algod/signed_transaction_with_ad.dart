import 'algod_transaction.dart';
import 'apply_data.dart';

class SignedTransactionWithAD {
  final AlgodTransaction txn;
  final ApplyData? applyData;

  SignedTransactionWithAD({
    required this.txn,
    this.applyData,
  });
}
