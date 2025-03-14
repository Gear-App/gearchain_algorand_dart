import 'box_descriptor.dart';
import '../../utils/serializers/bigint_serializer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'box_names_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.kebab)
class BoxNamesResponse {
  @JsonKey(name: 'application-id')
  @BigIntSerializer()
  final BigInt applicationId;

  @JsonKey(name: 'boxes', defaultValue: [])
  final List<BoxDescriptor> boxes;

  @JsonKey(name: 'next-token')
  final String? nextToken;

  BoxNamesResponse({
    required this.applicationId,
    required this.boxes,
    required this.nextToken,
  });

  factory BoxNamesResponse.fromJson(Map<String, dynamic> json) =>
      _$BoxNamesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BoxNamesResponseToJson(this);
}
