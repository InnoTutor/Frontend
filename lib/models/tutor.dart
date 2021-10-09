
import "package:json_annotation/json_annotation.dart";

part 'tutor.g.dart';

@JsonSerializable()
class Tutor{
  Tutor(this.tutorId, this.cardId, this.rating, this.countVoted, this.description,this.subject,this.sessionFormat,this.sessionType);

  int tutorId;
  int cardId;
  double rating;
  int countVoted;
  String description;
  String subject;
  List<String> sessionFormat;
  List<String> sessionType;
  int height = 100;


  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);

  void initializeCard(){
      this.height = 100;
  }

  Map<String, dynamic> toJson() => _$TutorToJson(this);
}
