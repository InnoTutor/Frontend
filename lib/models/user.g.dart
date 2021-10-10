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
    ..description = json['description'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'contacts': instance.contacts,
      'description': instance.description,
      'picture': instance.picture,
    };
