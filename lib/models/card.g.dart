// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) {
  return Card(
    json['cardId'] as int,
    json['subject'] as String,
    (json['rating'] as num)?.toDouble(),
    json['description'] as String,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'cardId': instance.cardId,
      'subject': instance.subject,
      'rating': instance.rating,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
      'description': instance.description,
    };
