import "package:json_annotation/json_annotation.dart";

import 'user.dart';

part 'session.g.dart';


@JsonSerializable()
class Session {
  Session(this.tutor, this.studentsList, this.description);

  User tutor;
  List<User>studentsList;
  //todo
  //date, start and end time, formattype , and formatsession
  String description;


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}