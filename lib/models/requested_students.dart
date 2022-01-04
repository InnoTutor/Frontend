import 'package:inno_tutor/models/my_student.dart';
import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'requested_students.g.dart';

@JsonSerializable()
class MyStudentsModel {
  MyStudentsModel(this.newStudents, this.acceptedStudents);

  List<MyStudent>newStudents;
  List<MyStudent>acceptedStudents;

  factory MyStudentsModel.fromJson(Map<String, dynamic> json) => _$MyStudentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyStudentsModelToJson(this);
}
