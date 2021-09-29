// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    json['sessionId'] as int,
    json['tutorId'] as int,
    (json['studentsList'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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
      'studentsList': instance.studentsList,
      'subject': instance.subject,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
      'description': instance.description,
    };
