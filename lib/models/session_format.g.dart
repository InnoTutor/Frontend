// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionFormat _$SessionFormatFromJson(Map<String, dynamic> json) {
  return SessionFormat(
    json['sessionFormatId'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$SessionFormatToJson(SessionFormat instance) =>
    <String, dynamic>{
      'sessionFormatId': instance.sessionFormatId,
      'name': instance.name,
    };
