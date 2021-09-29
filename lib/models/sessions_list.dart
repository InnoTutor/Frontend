import "package:json_annotation/json_annotation.dart";

import 'session.dart';

part 'sessions_list.g.dart';


@JsonSerializable()
class SessionsList {
  SessionsList(this.studyingSessionsList, this.teachingSessionsList);

  List<Session>studyingSessionsList;
  List<Session>teachingSessionsList;


  factory SessionsList.fromJson(Map<String, dynamic> json) => _$SessionsListFromJson(json);

  Map<String, dynamic> toJson() => _$SessionsListToJson(this);
}