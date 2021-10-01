import 'package:flutter/material.dart';
import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'card.g.dart';

@JsonSerializable()
class Card{
  Card(this.cardId, this.creatorId, this.subject, this.rating, this.description , this.sessionFormat, this.sessionType, this.isReserved, this.peopleVoted);
  int cardId;
  int creatorId;
  String subject;
  double rating;
  List<String> sessionFormat;
  List<String> sessionType;
  String description;
  bool isReserved = false;
  int peopleVoted = 0;

  bool editable = false;
  int height = 100;
  Icon currentIcon = Icon(Icons.create_rounded, color: Colors.white);

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
