import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'enrollment.g.dart';

@JsonSerializable()
class Enrollment{
  Enrollment(this.enrollmentId,
    this.studentId,
    this.studentName,
    this.studentSurname,
    this.studentEmail,
    this.studentContacts,
    this.studentDescription,
    this.studentPicture,
    this.cardId,
    this.subject,
    this.rating,
    this.countVoted,
    this.description,
    this.hidden,
    this.sessionFormat,
    this.sessionType);

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
  double rating;
  int countVoted;
  String description;
  bool hidden;
  List<String> sessionFormat;
  List<String> sessionType;
  int height = 100;

  factory Enrollment.fromJson(Map<String, dynamic> json) => _$EnrollmentFromJson(json);

  void setHeight(int height){
    this.height = height;
  }

  Map<String, dynamic> toJson() => _$EnrollmentToJson(this);
}
