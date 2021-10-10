// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) {
  return Card(
    json['cardId'] as int,
    json['creatorId'] as int,
    json['subject'] as String,
    (json['rating'] as num)?.toDouble(),
    json['description'] as String,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
    json['hidden'] as bool,
    json['countVoted'] as int,
  )
    ..editable = json['editable'] as bool
    ..height = json['height'] as int
    ..currentIcon = json['currentIcon'] as int;
}

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'cardId': instance.cardId,
      'creatorId': instance.creatorId,
      'subject': instance.subject,
      'rating': instance.rating,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
      'description': instance.description,
      'countVoted': instance.countVoted,
      'hidden': instance.hidden,
      'editable': instance.editable,
      'height': instance.height,
      'currentIcon': instance.currentIcon,
    };
