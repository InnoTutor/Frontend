import 'package:inno_tutor/models/requested_students.dart';
import 'package:inno_tutor/models/sessions_list.dart';
import "package:json_annotation/json_annotation.dart";

import 'card.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(this.userId, this.name, this.email, this.picture);

  int userId;
  String name;
  String surname;
  String email;
  String contacts;
  String description;
  String picture;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
