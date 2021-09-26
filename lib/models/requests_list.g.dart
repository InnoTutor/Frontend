// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestsList _$RequestsListFromJson(Map<String, dynamic> json) {
  return RequestsList(
    (json['helpCardsLists'] as List)
        ?.map((e) =>
            e == null ? null : RequestCard.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['cvCardsList'] as List)
        ?.map((e) =>
            e == null ? null : CvCard.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RequestsListToJson(RequestsList instance) =>
    <String, dynamic>{
      'helpCardsLists': instance.helpCardsLists,
      'cvCardsList': instance.cvCardsList,
    };
