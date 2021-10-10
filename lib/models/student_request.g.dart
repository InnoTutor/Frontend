// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentRequest _$StudentRequestFromJson(Map<String, dynamic> json) {
  return StudentRequest(
    json['studentId'] as int,
    json['cardId'] as int,
    json['description'] as String,
    json['subject'] as String,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$StudentRequestToJson(StudentRequest instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'cardId': instance.cardId,
      'description': instance.description,
      'subject': instance.subject,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
    };
