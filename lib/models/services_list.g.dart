// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesList _$ServicesListFromJson(Map<String, dynamic> json) {
  return ServicesList(
    (json['cvCardsList'] as List)
        ?.map((e) =>
            e == null ? null : CvCard.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ServicesListToJson(ServicesList instance) =>
    <String, dynamic>{
      'cvCardsList': instance.cvCardsList,
    };
