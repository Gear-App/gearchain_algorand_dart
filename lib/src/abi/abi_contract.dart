import 'dart:convert';
import 'dart:io';

import 'abi_method.dart';
import 'network_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'abi_contract.g.dart';

@JsonSerializable(fieldRename: FieldRename.kebab, explicitToJson: true)
class AbiContract {
  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'desc', defaultValue: '')
  final String description;

  @JsonKey(name: 'networks')
  final Map<String, NetworkInfo> networks;

  @JsonKey(name: 'methods')
  final List<AbiMethod> methods;

  AbiContract({
    required this.name,
    required this.description,
    required this.networks,
    required this.methods,
  });

  NetworkInfo? getNetworkInfo(String genesisHash) => networks[genesisHash];

  factory AbiContract.fromJson(Map<String, dynamic> json) =>
      _$AbiContractFromJson(json);

  Map<String, dynamic> toJson() => _$AbiContractToJson(this);

  factory AbiContract.fromFile(String path) {
    final contractSrc = File(path).readAsStringSync();
    final data = jsonDecode(contractSrc) as Map<String, dynamic>;
    return AbiContract.fromJson(data);
  }
}
