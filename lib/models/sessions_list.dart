import "package:json_annotation/json_annotation.dart";

import 'session.dart';

part 'sessions_list.g.dart';


@JsonSerializable()
class SessionsList {
  SessionsList(this.studySesssions, this.teachingSesssions);

  List<Session>studySesssions;
  List<Session>teachingSesssions;


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SessionsList.fromJson(Map<String, dynamic> json) => _$SessionsListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SessionsListToJson(this);
}