
import "package:json_annotation/json_annotation.dart";

part 'student_request.g.dart';

@JsonSerializable()
class StudentRequest {
  StudentRequest(this.studentId, this.cardId, this.description,this.subjectId,this.sessionFormat,this.sessionType);

  String studentId;
  String cardId;
  String description;
  String subjectId;
  List<String> sessionFormat;
  List<String> sessionType;


  factory StudentRequest.fromJson(Map<String, dynamic> json) => _$StudentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StudentRequestToJson(this);
}
