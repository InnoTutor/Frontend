// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responded_tutors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespondedTutors _$RespondedTutorsFromJson(Map<String, dynamic> json) {
  return RespondedTutors(
    (json['newTutorsList'] as List)
        ?.map((e) =>
            e == null ? null : Enrollment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['acceptedTutorsList'] as List)
        ?.map((e) =>
            e == null ? null : Enrollment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RespondedTutorsToJson(RespondedTutors instance) =>
    <String, dynamic>{
      'newTutorsList': instance.newTutorsList,
      'acceptedTutorsList': instance.acceptedTutorsList,
    };
