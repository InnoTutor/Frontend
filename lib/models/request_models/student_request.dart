
import 'package:inno_tutor/models/request_models/request_model.dart';
import "package:json_annotation/json_annotation.dart";

part 'student_request.g.dart';

@JsonSerializable()
class StudentRequest extends RequestModel{
  StudentRequest(
    this.studentId, 
    this.studentName, 
    this.studentSurname, 
    this.cardId, 
    this.description,
    this.subject,
    this.sessionFormat,
    this.sessionType,
    this.offered) : super(
      id : studentId,
      name: studentName,
      surname: studentSurname,
      cardId: cardId,
      description : description,
      subject : subject,
      sessionFormat : sessionFormat,
      sessionType : sessionType,
      requested: offered
    );

  int studentId;
  String studentName;
  String studentSurname;
  int cardId;
  String description;

  String subject;
  List<String> sessionFormat;
  List<String> sessionType;
  bool offered;
  factory StudentRequest.fromJson(Map<String, dynamic> json) => _$StudentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StudentRequestToJson(this);
}
