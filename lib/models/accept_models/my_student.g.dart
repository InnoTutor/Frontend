// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyStudent _$MyStudentFromJson(Map<String, dynamic> json) {
  return MyStudent(
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
    json['cardRating'] as double,
    json['cardCountVoted'] as int,
    json['cardDescription'] as String,
    json['hidden'] as bool,
    json['enrollmentDescription'] as String,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
  )
    ..height = json['height'] as int;
}

Map<String, dynamic> _$MyStudentToJson(MyStudent instance) =>
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
      'cardRating' : instance.cardRating,
      'cardCountVoted' : instance.cardCountVoted,
      'cardDescription' : instance.cardDescription,
      'hidden' : instance.hidden,
      'enrollmentDescription' : instance.enrollmentDescription,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
      'height' : instance.height
    };
