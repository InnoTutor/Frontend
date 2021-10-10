// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Enrollment _$EnrollmentFromJson(Map<String, dynamic> json) {
  return Enrollment(
    json['enrollmentId'] as int,
    json['enrollerId'] as int,
    json['cardId'] as int,
    (json['sessionFormat'] as List)?.map((e) => e as String)?.toList(),
    (json['sessionType'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$EnrollmentToJson(Enrollment instance) =>
    <String, dynamic>{
      'enrollmentId': instance.enrollmentId,
      'enrollerId' : instance.enrollerId,
      'cardId': instance.cardId,
      'sessionFormat': instance.sessionFormat,
      'sessionType': instance.sessionType,
    };
