// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tutor _$TutorFromJson(Map<String, dynamic> json) {
  return Tutor(
    json['tutorId'] as int,
    json['tutorName'] as String,
    json['tutorSurname'] as String,
    json['cardId'] as int,
    (json['rating'] as num)?.toDouble(),
    json['countVoted'] as int,
    json['description'] as String,
    json['subject'] as String,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
    json['requested'] as bool
  )..height = json['height'] as int;
}

Map<String, dynamic> _$TutorToJson(Tutor instance) => <String, dynamic>{
      'tutorId': instance.tutorId,
      'tutorName' : instance.tutorName,
      'tutorSurname' : instance.tutorSurname,
      'cardId': instance.cardId,
      'rating': instance.rating,
      'countVoted': instance.countVoted,
      'description': instance.description,
      'subject': instance.subject,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
      'requested' : instance.requested,
      'height': instance.height,
    };
