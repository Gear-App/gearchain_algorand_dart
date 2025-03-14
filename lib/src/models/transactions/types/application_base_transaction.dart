import 'dart:typed_data';

import '../../../api/box/box.dart';
import '../../models.dart';
import '../builders/transaction_builders.dart';

/// TODO Deprecate and use the new [ApplicationTransaction] which contains
/// TODO all the fields from create & update.
class ApplicationBaseTransaction extends RawTransaction {
  /// ApplicationID is the application being interacted with,
  /// or 0 if creating a new application.
  int? applicationId;

  /// Defines what additional actions occur with the transaction.
  /// See the OnComplete section of the TEAL spec for details.
  final OnCompletion? onCompletion;

  /// Transaction specific arguments accessed from the application's
  /// approval-program and clear-state-program.
  List<Uint8List>? arguments;

  /// List of accounts in addition to the sender that may be accessed from the
  /// application's approval-program and clear-state-program.
  List<Address>? accounts;

  /// Lists the applications in addition to the application-id whose global
  /// states may be accessed by this application's approval-program and
  /// clear-state-program. The access is read-only.
  List<int>? foreignApps;

  /// Lists the assets whose AssetParams may be accessed by this application's
  /// approval-program and clear-state-program. The access is read-only.
  List<int>? foreignAssets;

  /// The boxes that should be made available for the runtime of the program.
  List<AppBoxReference>? appBoxReferences;

  ApplicationBaseTransaction.builder(
    ApplicationBaseTransactionBuilder builder,
  )   : applicationId = builder.applicationId,
        onCompletion = builder.onCompletion,
        arguments = builder.arguments,
        accounts = builder.accounts,
        foreignApps = builder.foreignApps,
        foreignAssets = builder.foreignAssets,
        appBoxReferences = builder.appBoxReferences,
        super(
          type: builder.type.value,
          fee: builder.fee,
          firstValid: builder.firstValid,
          genesisHash: builder.genesisHash,
          lastValid: builder.lastValid,
          sender: builder.sender,
          genesisId: builder.genesisId,
          group: builder.group,
          lease: builder.lease,
          note: builder.note,
          rekeyTo: builder.rekeyTo,
        );

  @override
  Map<String, dynamic> toMessagePack() {
    final fields = super.toMessagePack();
    fields['apid'] = applicationId;
    fields['apan'] = onCompletion?.value;
    fields['apaa'] = arguments;
    fields['apat'] = accounts?.map((account) => account.publicKey).toList();
    fields['apfa'] = foreignApps;
    fields['apas'] = foreignAssets;
    fields['apbx'] = appBoxReferences
        ?.map(
          (abr) =>
              BoxReference.fromAppBoxReference(abr, foreignApps, applicationId)
                  .toMessagePack(),
        )
        .toList();

    return fields;
  }
}
