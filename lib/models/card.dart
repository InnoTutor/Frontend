import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'card.g.dart';

@JsonSerializable()
class Card{
  Card(this.cardId, this.subject, this.rating, this.description , this.sessionFormat,this.sessionType);
  int cardId;
  String subject;
  double rating;
  List<String> sessionFormat;
  List<String> sessionType;
  String description;

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
