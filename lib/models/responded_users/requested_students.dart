import 'package:inno_tutor/models/accept_models/my_student.dart';
import 'package:inno_tutor/models/responded_users/responded_users_model.dart';
import "package:json_annotation/json_annotation.dart";


part 'requested_students.g.dart';

@JsonSerializable()
class MyStudentsModel extends RespondedUsersModel{
  MyStudentsModel(
    this.newStudents, 
    this.acceptedStudents
  ) : super(
    newUsers: newStudents,
    acceptedUsers: acceptedStudents 
  );

  List<MyStudent>newStudents;
  List<MyStudent>acceptedStudents;

  factory MyStudentsModel.fromJson(Map<String, dynamic> json) => _$MyStudentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyStudentsModelToJson(this);
}
