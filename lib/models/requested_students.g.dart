// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_students.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyStudentsModel _$MyStudentsModelFromJson(Map<String, dynamic> json) {
  return MyStudentsModel(
    (json['newStudentsList'] as List)
        ?.map((e) =>
            e == null ? null : Enrollment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['acceptedStudentsList'] as List)
        ?.map((e) =>
            e == null ? null : Enrollment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyStudentsModelToJson(MyStudentsModel instance) =>
    <String, dynamic>{
      'newStudentsList': instance.newStudentsList,
      'acceptedStudentsList': instance.acceptedStudentsList,
    };
