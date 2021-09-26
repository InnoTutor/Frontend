// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestCard _$RequestCardFromJson(Map<String, dynamic> json) {
  return RequestCard(
    (json['respondedTutors'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['tutor'] == null
        ? null
        : User.fromJson(json['tutor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RequestCardToJson(RequestCard instance) =>
    <String, dynamic>{
      'respondedTutors': instance.respondedTutors,
      'tutor': instance.tutor,
    };
