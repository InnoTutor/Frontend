import 'package:flutter/material.dart';
import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'card.g.dart';

@JsonSerializable()
class Card{
  Card(this.cardId, this.creatorId, this.subject, this.rating, this.description , this.sessionFormat, this.sessionType, this.hidden, this.countVoted);
  int cardId;
  int creatorId;
  String subject;
  double rating;
  List<String> sessionFormat;
  List<String> sessionType;
  String description;
  int countVoted = 0;
  bool hidden = false;
  bool editable = false;
  int height = 100;
  int currentIcon = 0;
  

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  void setEditable(bool edit){
    if (edit){
      this.editable = true;
      this.hidden = false;
      this.currentIcon = 0;
    } else {
      this.hidden = false;
      this.editable = false;
      this.currentIcon = 1;
    }
  }
  void initializeCard(){
      this.editable = false;
      this.hidden = false;
      this.currentIcon = 0;
      this.height = 100;
      this.rating=0;

  }

  void setHeight(int height){
    this.height = height;
  }

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
