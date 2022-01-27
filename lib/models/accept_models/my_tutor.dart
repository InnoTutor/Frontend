import 'package:inno_tutor/models/accept_models/accept_model.dart';
import "package:json_annotation/json_annotation.dart";

part 'my_tutor.g.dart';

@JsonSerializable()
class MyTutor extends AcceptModel{
  MyTutor(this.enrollmentId,
    this.tutorId,
    this.tutorName,
    this.tutorSurname,
    this.tutorEmail,
    this.tutorContacts,
    this.tutorDescription,
    this.tutorPicture,
    this.cardId,
    this.subject,
    this.cardDescription,
    this.hidden,
    this.enrollmentDescription,
    this.sessionFormat,
    this.sessionType) : super(
      enrollmentId: enrollmentId,
      userId: tutorId,
      name: tutorName,
      surname: tutorSurname,
      email: tutorEmail,
      contacts: tutorContacts,
      userDescription: tutorDescription,
      userPicture: tutorPicture,
      cardId: cardId,
      subject: subject,
      cardDescription: cardDescription,
      hidden: hidden,
      enrollmentDescription: enrollmentDescription,
      sessionFormat: sessionFormat,
      sessionType: sessionType
    );

  int enrollmentId;
  int tutorId;
  String tutorName;
  String tutorSurname;
  String tutorEmail;
  String tutorContacts;
  String tutorDescription;
  String tutorPicture;
  int cardId; 
  String subject;
  double cardRating;
  int cardCountVoted;
  String cardDescription;
  bool hidden;
  String enrollmentDescription;
  List<String> sessionFormat;
  List<String> sessionType;
  int height = 100;

  factory MyTutor.fromJson(Map<String, dynamic> json) => _$MyTutorFromJson(json);

  Map<String, dynamic> toJson() => _$MyTutorToJson(this);
}
