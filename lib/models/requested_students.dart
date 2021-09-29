import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'requested_students.g.dart';

@JsonSerializable()
class RequestedStudents {
  RequestedStudents(this.newStudentsList, this.acceptedStudentsList);

  List<Enrollment>newStudentsList;
  List<Enrollment>acceptedStudentsList;

  factory RequestedStudents.fromJson(Map<String, dynamic> json) => _$RequestedStudentsFromJson(json);

  Map<String, dynamic> toJson() => _$RequestedStudentsToJson(this);
}
