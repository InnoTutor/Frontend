// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['name'] as String,
    json['surname'] as String,
    json['email'] as String,
  )
    ..password = json['password'] as String
    ..sessions = json['sessions'] == null
        ? null
        : SessionsList.fromJson(json['sessions'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'id': instance.id,
      'surname': instance.surname,
      'password': instance.password,
      'sessions': instance.sessions,
    };
