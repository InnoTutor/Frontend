// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Enrollment _$EnrollmentFromJson(Map<String, dynamic> json) {
  return Enrollment(
    json['enrollmentId'] as int,
    json['studentId'] as int,
    json['studentName'] as String,
    json['studentSurname'] as String,
    json['studentEmail'] as String,
    json['studentContacts'] as String,
    json['studentDescription'] as String,
    json['studentPicture'] as String,
    json['cardId'] as int,
    json['subject'] as String,
    json['rating'] as double,
    json['countVoted'] as int,
    json['description'] as String,
    json['hidden'] as bool,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
  )
    ..height = json['height'] as int;
}

Map<String, dynamic> _$EnrollmentToJson(Enrollment instance) =>
    <String, dynamic>{
      'enrollmentId': instance.enrollmentId,
      'studentId' : instance.studentId,
      'studentName' : instance.studentName,
      'studentSurname' : instance.studentSurname,
      'studentEmail' : instance.studentEmail,
      'studentContacts' : instance.studentContacts,
      'studentDescription' : instance.studentDescription,
      'studentPicture' : instance.studentPicture,
      'cardId' : instance.cardId,
      'subject' : instance.subject,
      'rating' : instance.rating,
      'countVoted' : instance.countVoted,
      'description' : instance.description,
      'hidden' : instance.hidden,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
      'height' : instance.height
    };
