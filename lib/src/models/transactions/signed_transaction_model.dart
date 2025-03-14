import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../../crypto/crypto.dart';
import '../models.dart';
import '../../utils/encoders/msgpack_encoder.dart';
import '../../utils/message_packable.dart';
import '../../utils/serializers/address_serializer.dart';
import '../../utils/serializers/byte_array_serializer.dart';
import '../../utils/serializers/transaction_serializer.dart';
import '../../utils/transformers/address_transformer.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signed_transaction_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.kebab)
class SignedTransaction extends Equatable implements MessagePackable {
  /// The signature of the transaction
  @JsonKey(name: 'sig')
  @NullableByteArraySerializer()
  final Uint8List? signature;

  /// The raw data of the transaction
  @JsonKey(name: 'txn')
  @TransactionSerializer()
  final RawTransaction transaction;

  /// Optional auth address when
  @JsonKey(name: 'sgnr')
  @AddressSerializer()
  Address? authAddress;

  /// The logic signature
  @JsonKey(name: 'lsig')
  final LogicSignature? logicSignature;

  /// The logic signature
  @JsonKey(name: 'msig', includeFromJson: false, includeToJson: false)
  final MultiSignature? multiSignature;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? _transactionId;

  SignedTransaction({
    required this.transaction,
    this.signature,
    this.logicSignature,
    this.multiSignature,
    String? transactionId,
  }) : _transactionId = transactionId;

  /// Export the transaction to a file.
  ///
  /// This creates a new File with the given filePath and streams the encoded
  /// transaction to it.
  Future<File> export(String filePath) async {
    final encodedTransaction = Encoder.encodeMessagePack(toMessagePack());
    return File(filePath).writeAsBytes(encodedTransaction);
  }

  /// Get the transaction id.
  String get transactionId => _transactionId ?? transaction.id;

  /// Get the base64-encoded representation of the transaction..
  String toBase64() => base64Encode(Encoder.encodeMessagePack(toMessagePack()));

  /// Get the bytes of this signed transaction.
  Uint8List toBytes() =>
      Uint8List.fromList(Encoder.encodeMessagePack(toMessagePack()));

  factory SignedTransaction.fromJson(Map<String, dynamic> json) =>
      _$SignedTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$SignedTransactionToJson(this);

  @override
  Map<String, dynamic> toMessagePack() {
    return {
      'sgnr': const AddressTransformer().toMessagePack(authAddress),
      'sig': signature,
      'txn': transaction.toMessagePack(),
      'lsig': logicSignature?.toMessagePack(),
      'msig': multiSignature?.toMessagePack(),
    };
  }

  @override
  List<Object?> get props => [
        authAddress,
        signature,
        transaction,
        logicSignature,
        multiSignature,
      ];
}
