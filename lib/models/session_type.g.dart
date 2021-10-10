// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionType _$SessionTypeFromJson(Map<String, dynamic> json) {
  return SessionType(
    json['sessionTypeId'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$SessionTypeToJson(SessionType instance) =>
    <String, dynamic>{
      'sessionTypeId': instance.sessionTypeId,
      'name': instance.name,
    };
