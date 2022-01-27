
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AcceptModel{
  AcceptModel({
    this.enrollmentId,
    this.userId,
    this.name,
    this.surname,
    this.email,
    this.contacts,
    this.userDescription,
    this.userPicture,
    this.cardId,
    this.subject,
    this.cardRating,
    this.cardCountVoted,
    this.cardDescription,
    this.hidden,
    this.enrollmentDescription,

    this.sessionFormat,
    this.sessionType,
  });

  int enrollmentId;
  int userId;
  String name;
  String surname;
  String email;
  String contacts;
  String userDescription;
  String userPicture;
  int cardId;
  String description;
  String subject;
  double cardRating;
  int cardCountVoted;
  String cardDescription;
  bool hidden;
  String enrollmentDescription;
  List<String> sessionFormat;
  List<String> sessionType;
  bool requested;

  int height = 100;
  void setHeight(int height){
    this.height = height;
  }
}