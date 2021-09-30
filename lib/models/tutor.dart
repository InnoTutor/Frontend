
import "package:json_annotation/json_annotation.dart";

part 'tutor.g.dart';

@JsonSerializable()
class Tutor{
  Tutor(this.tutorId, this.cardId, this.rating, this.description,this.subject,this.sessionFormat,this.sessionType);

  String tutorId;
  String cardId;
  double rating;
  String description;
  String subject;
  List<String> sessionFormat;
  List<String> sessionType;


  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);

  Map<String, dynamic> toJson() => _$TutorToJson(this);
}