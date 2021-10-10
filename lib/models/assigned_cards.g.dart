// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_cards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedCards _$AssignedCardsFromJson(Map<String, dynamic> json) {
  return AssignedCards(
    (json['waitingList'] as List)
        ?.map((e) =>
            e == null ? null : Enrollment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['acceptedList'] as List)
        ?.map((e) =>
            e == null ? null : Enrollment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssignedCardsToJson(AssignedCards instance) =>
    <String, dynamic>{
      'waitingList': instance.waitingList,
      'acceptedList': instance.acceptedList,
    };
