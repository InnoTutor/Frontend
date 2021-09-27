// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    json['tutor'] == null
        ? null
        : User.fromJson(json['tutor'] as Map<String, dynamic>),
    (json['studentsList'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['formatSession'] as String,
    json['formatType'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'tutor': instance.tutor,
      'studentsList': instance.studentsList,
      'formatSession': instance.formatSession,
      'formatType': instance.formatType,
      'description': instance.description,
    };
