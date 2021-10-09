// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['userId'] as int,
    json['name'] as String,
    json['email'] as String,
    json['picture'] as String,
  )
    ..surname = json['surname'] as String
    ..contacts = json['contacts'] as String
    ..description = json['description'] as String
    ..sessions = json['sessions'] == null
        ? null
        : SessionsList.fromJson(json['sessions'] as Map<String, dynamic>)
    ..servicesList = (json['servicesList'] as List)
        ?.map(
            (e) => e == null ? null : Card.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..myStudentsList = json['myStudentsList'] == null
        ? null
        : RequestedStudents.fromJson(
            json['myStudentsList'] as Map<String, dynamic>)
    ..requestsList = (json['requestsList'] as List)
        ?.map(
            (e) => e == null ? null : Card.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..token = json['token'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'contacts': instance.contacts,
      'description': instance.description,
      'sessions': instance.sessions,
      'servicesList': instance.servicesList,
      'myStudentsList': instance.myStudentsList,
      'requestsList': instance.requestsList,
      'token': instance.token,
      'picture': instance.picture,
    };
