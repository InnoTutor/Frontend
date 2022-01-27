import 'package:inno_tutor/models/accept_models/accept_model.dart';
import "package:json_annotation/json_annotation.dart";

part 'my_student.g.dart';

@JsonSerializable()
class MyStudent extends AcceptModel{
  MyStudent(this.enrollmentId,
    this.studentId,
    this.studentName,
    this.studentSurname,
    this.studentEmail,
    this.studentContacts,
    this.studentDescription,
    this.studentPicture,
    this.cardId,
    this.subject,
    this.cardRating,
    this.cardCountVoted,
    this.cardDescription,
    this.hidden,
    this.enrollmentDescription,
    this.sessionFormat,
    this.sessionType) : super(
      enrollmentId: enrollmentId,
      userId: studentId,
      name: studentName,
      surname: studentSurname,
      email: studentEmail,
      contacts: studentContacts,
      userDescription: studentDescription,
      userPicture: studentPicture,
      cardId: cardId,
      subject: subject,
      cardRating: cardRating,
      cardCountVoted: cardCountVoted,
      cardDescription: cardDescription,
      hidden: hidden,
      enrollmentDescription: enrollmentDescription,
      sessionFormat: sessionFormat,
      sessionType: sessionType
    );

  int enrollmentId;
  int studentId;
  String studentName;
  String studentSurname;
  String studentEmail;
  String studentContacts;
  String studentDescription;
  String studentPicture;
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

  factory MyStudent.fromJson(Map<String, dynamic> json) => _$MyStudentFromJson(json);

  Map<String, dynamic> toJson() => _$MyStudentToJson(this);
}
