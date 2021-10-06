
import "package:json_annotation/json_annotation.dart";

part 'subject.g.dart';

@JsonSerializable()
class Subject {
  Subject(this.subjectId, this.name);

  int subjectId;
  String name;

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
