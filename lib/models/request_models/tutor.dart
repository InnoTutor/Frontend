
import 'package:inno_tutor/models/request_models/request_model.dart';
import "package:json_annotation/json_annotation.dart";

part 'tutor.g.dart';

@JsonSerializable()
class Tutor extends RequestModel{
  Tutor(this.tutorId, 
    this.tutorName,
    this.tutorSurname,
    this.cardId, 
    this.rating, 
    this.countVoted, 
    this.description,
    this.subject,
    this.sessionFormat,
    this.sessionType,
    this.requested) : super(
      id : tutorId,
      name : tutorName,
      surname: tutorSurname,
      cardId : cardId,
      description: description,
      subject : subject,
      sessionFormat : sessionFormat,
      sessionType : sessionType,
      requested : requested
    );

  int tutorId;
  String tutorName;
  String tutorSurname;
  int cardId;
  double rating;
  int countVoted;
  String description;
  String subject;
  List<String> sessionFormat;
  List<String> sessionType;
  bool requested;
  int height = 100;


  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);
  Map<String, dynamic> toJson() => _$TutorToJson(this);
}
