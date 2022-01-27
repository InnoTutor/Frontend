import 'package:inno_tutor/models/accept_models/accept_model.dart';
import "package:json_annotation/json_annotation.dart";


@JsonSerializable()
class RespondedUsersModel {
  RespondedUsersModel({this.newUsers, this.acceptedUsers});

  List<AcceptModel>newUsers;
  List<AcceptModel>acceptedUsers;
}
