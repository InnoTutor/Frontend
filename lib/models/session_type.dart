
import "package:json_annotation/json_annotation.dart";

part 'session_type.g.dart';

@JsonSerializable()
class SessionType {
  SessionType(this.sessionTypeId, this.name);

  int sessionTypeId;
  String name;

  factory SessionType.fromJson(Map<String, dynamic> json) => _$SessionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SessionTypeToJson(this);
}
