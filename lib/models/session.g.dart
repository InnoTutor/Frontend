// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    json['sessionId'] as int,
    json['tutorId'] as int,
    (json['studentIDsList'] as List)?.map((e) => e as int)?.toList(),
    json['subject'] as String,
    json['date'] as String,
    json['startTime'] as String,
    json['endTime'] as String,
    json['sessionFormat'] as String,
    json['sessionType'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'sessionId': instance.sessionId,
      'tutorId': instance.tutorId,
      'studentIDsList': instance.studentIDsList,
      'subject': instance.subject,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
      'description': instance.description,
    };
