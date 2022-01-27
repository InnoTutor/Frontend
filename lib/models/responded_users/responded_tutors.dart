import 'package:inno_tutor/models/accept_models/my_student.dart';
import 'package:inno_tutor/models/accept_models/my_tutor.dart';
import 'package:inno_tutor/models/responded_users/responded_users_model.dart';
import "package:json_annotation/json_annotation.dart";

part 'responded_tutors.g.dart';

@JsonSerializable()
class MyTutorsModel extends RespondedUsersModel{
  MyTutorsModel(
    this.newTutors, 
    this.acceptedTutors
  ) : super(
    newUsers: newTutors,
    acceptedUsers: acceptedTutors,
  );

  List<MyTutor> newTutors;
  List<MyTutor> acceptedTutors;

  factory MyTutorsModel.fromJson(Map<String, dynamic> json) => _$RespondedTutorsFromJson(json);

  Map<String, dynamic> toJson() => _$RespondedTutorsToJson(this);
}
