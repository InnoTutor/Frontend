// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CvCard _$CvCardFromJson(Map<String, dynamic> json) {
  return CvCard(
    (json['newStudents'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['acceptedStudents'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['rating'] as int,
  );
}

Map<String, dynamic> _$CvCardToJson(CvCard instance) => <String, dynamic>{
      'newStudents': instance.newStudents,
      'acceptedStudents': instance.acceptedStudents,
      'rating': instance.rating,
    };
