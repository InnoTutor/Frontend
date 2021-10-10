// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_students.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyStudentsModel _$MyStudentsModelFromJson(Map<String, dynamic> json) {
  return MyStudentsModel(
    (json['newStudents'] as List)
        ?.map((e) =>
            e == null ? null : Enrollment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['acceptedStudents'] as List)
        ?.map((e) =>
            e == null ? null : Enrollment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyStudentsModelToJson(MyStudentsModel instance) =>
    <String, dynamic>{
      'newStudents': instance.newStudents,
      'acceptedStudents': instance.acceptedStudents,
    };
