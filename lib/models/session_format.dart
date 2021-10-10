
import "package:json_annotation/json_annotation.dart";

part 'session_format.g.dart';

@JsonSerializable()
class SessionFormat {
  SessionFormat(this.sessionFormatId, this.name);

  int sessionFormatId;
  String name;

  factory SessionFormat.fromJson(Map<String, dynamic> json) => _$SessionFormatFromJson(json);

  Map<String, dynamic> toJson() => _$SessionFormatToJson(this);
}
