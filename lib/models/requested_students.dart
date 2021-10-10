import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'requested_students.g.dart';

@JsonSerializable()
class MyStudentsModel {
  MyStudentsModel(this.newStudentsList, this.acceptedStudentsList);

  List<Enrollment>newStudentsList;
  List<Enrollment>acceptedStudentsList;

  factory MyStudentsModel.fromJson(Map<String, dynamic> json) => _$MyStudentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyStudentsModelToJson(this);
}
