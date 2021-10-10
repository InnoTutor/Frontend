import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'enrollment.g.dart';

@JsonSerializable()
class Enrollment{
  Enrollment(this.enrollmentId, this.enrollerId, this.cardId, this.sessionFormat, this.sessionType);
  int enrollmentId;
  int enrollerId;
  int cardId;
  List<String> sessionFormat;
  List<String> sessionType;

  factory Enrollment.fromJson(Map<String, dynamic> json) => _$EnrollmentFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollmentToJson(this);
}
