// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) {
  return Card(
    json['creator'] == null
        ? null
        : User.fromJson(json['creator'] as Map<String, dynamic>),
    json['subject'] as String,
    json['formatSession'] as String,
    json['formatType'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'creator': instance.creator,
      'subject': instance.subject,
      'formatSession': instance.formatSession,
      'formatType': instance.formatType,
      'description': instance.description,
    };
