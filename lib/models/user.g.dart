// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['name'] as String,
    json['email'] as String,
    json['imageUrl'] as String,
  )
    ..surname = json['surname'] as String
    ..password = json['password'] as String
    ..sessions = json['sessions'] == null
        ? null
        : SessionsList.fromJson(json['sessions'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'imageUrl':instance.imageUrl,
      'password': instance.password,
      'sessions': instance.sessions,
    };
