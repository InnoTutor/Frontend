import 'package:inno_tutor/models/my_student.dart';
import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'responded_tutors.g.dart';

@JsonSerializable()
class RespondedTutors {
  RespondedTutors(this.newTutorsList, this.acceptedTutorsList);

  List<MyStudent> newTutorsList;
  List<MyStudent> acceptedTutorsList;

  factory RespondedTutors.fromJson(Map<String, dynamic> json) => _$RespondedTutorsFromJson(json);

  Map<String, dynamic> toJson() => _$RespondedTutorsToJson(this);
}
