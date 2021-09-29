// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tutor _$TutorFromJson(Map<String, dynamic> json) {
  return Tutor(
    json['tutorId'] as String,
    json['cardId'] as String,
    (json['rating'] as num)?.toDouble(),
    json['description'] as String,
    json['subjectId'] as String,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$TutorToJson(Tutor instance) => <String, dynamic>{
      'tutorId': instance.tutorId,
      'cardId': instance.cardId,
      'rating': instance.rating,
      'description': instance.description,
      'subjectId': instance.subjectId,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
    };
