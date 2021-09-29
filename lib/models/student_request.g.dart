// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentRequest _$StudentRequestFromJson(Map<String, dynamic> json) {
  return StudentRequest(
    json['studentId'] as String,
    json['cardId'] as String,
    json['description'] as String,
    json['subjectId'] as String,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$StudentRequestToJson(StudentRequest instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'cardId': instance.cardId,
      'description': instance.description,
      'subjectId': instance.subjectId,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
    };
