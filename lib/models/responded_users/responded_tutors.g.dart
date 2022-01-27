// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responded_tutors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTutorsModel _$RespondedTutorsFromJson(Map<String, dynamic> json) {
  return MyTutorsModel(
    (json['newTutors'] as List)
        ?.map((e) =>
            e == null ? null : MyTutor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['acceptedTutors'] as List)
        ?.map((e) =>
            e == null ? null : MyTutor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RespondedTutorsToJson(MyTutorsModel instance) =>
    <String, dynamic>{
      'newTutors': instance.newTutors,
      'acceptedTutors': instance.acceptedTutors,
    };
