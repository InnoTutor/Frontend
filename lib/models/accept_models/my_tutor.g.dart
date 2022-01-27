// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTutor _$MyTutorFromJson(Map<String, dynamic> json) {
  return MyTutor(
    json['enrollmentId'] as int,
    json['tutorId'] as int,
    json['tutorName'] as String,
    json['tutorSurname'] as String,
    json['tutorEmail'] as String,
    json['tutorContacts'] as String,
    json['tutorDescription'] as String,
    json['tutorPicture'] as String,
    json['cardId'] as int,
    json['subject'] as String,
    json['cardDescription'] as String,
    json['hidden'] as bool,
    json['enrollmentDescription'] as String,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
  )
    ..height = json['height'] as int;
}

Map<String, dynamic> _$MyTutorToJson(MyTutor instance) =>
  <String, dynamic>{
    'enrollmentId': instance.enrollmentId,
    'tutorId' : instance.tutorId,
    'tutorName' : instance.tutorName,
    'tutorSurname' : instance.tutorSurname,
    'tutorEmail' : instance.tutorEmail,
    'tutorContacts' : instance.tutorContacts,
    'tutorDescription' : instance.tutorDescription,
    'tutorPicture' : instance.tutorPicture,
    'cardId' : instance.cardId,
    'subject' : instance.subject,
    'description' : instance.cardDescription,
    'hidden' : instance.hidden,
    'enrollmentDescription' : instance.enrollmentDescription,
    'sessionFormat': instance.sessionFormat,
    'sessionType': instance.sessionType,
    'height' : instance.height
  };
