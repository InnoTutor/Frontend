import "package:json_annotation/json_annotation.dart";

part 'enrollment.g.dart';

@JsonSerializable()
class Enrollment{
  Enrollment(this.cardId,
    this.description,
    this.sessionFormat,
    this.sessionType);

  int cardId;
  String description;
  List<String> sessionFormat;
  List<String> sessionType;

  factory Enrollment.fromJson(Map<String, dynamic> json) => _$EnrollmentFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollmentToJson(this);
}
