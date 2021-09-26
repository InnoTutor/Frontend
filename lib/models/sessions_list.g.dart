// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionsList _$SessionsListFromJson(Map<String, dynamic> json) {
  return SessionsList(
    (json['studySessions'] as List)
        ?.map((e) =>
            e == null ? null : Session.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['teachingSessions'] as List)
        ?.map((e) =>
            e == null ? null : Session.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SessionsListToJson(SessionsList instance) =>
    <String, dynamic>{
      'studySessions': instance.studySessions,
      'teachingSessions': instance.teachingSessions,
    };
