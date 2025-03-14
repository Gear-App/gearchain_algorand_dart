import 'dart:typed_data';

import '../../models/models.dart';
import 'message_pack_converter.dart';

class AddressTransformer implements MessagePackConverter<Address?, Uint8List?> {
  const AddressTransformer();

  @override
  Address? fromMessagePack(Uint8List? json) =>
      Address(publicKey: Uint8List(32));

  @override
  Uint8List? toMessagePack(Address? address) => address?.publicKey;
}
