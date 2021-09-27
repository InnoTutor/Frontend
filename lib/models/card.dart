import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'card.g.dart';

@JsonSerializable()
class Card {
  Card(this.creator, this.subject, this.formatSession,this.formatType,this.description);

  User creator;
  String subject;
  String formatSession;
  String formatType;
  String description;

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
