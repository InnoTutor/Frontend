// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_students.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestedStudents _$RequestedStudentsFromJson(Map<String, dynamic> json) {
  return RequestedStudents(
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

Map<String, dynamic> _$RequestedStudentsToJson(RequestedStudents instance) =>
    <String, dynamic>{
      'newStudentsList': instance.newStudentsList,
      'acceptedStudentsList': instance.acceptedStudentsList,
    };
