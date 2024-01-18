// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String? ?? 'default_username',
    password: json['password'] as String? ?? 'default_password',
    netsuitFlag: json['netsuitFlag'] as bool? ?? false,
  );
}


Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'netsuitFlag': instance.netsuitFlag,
    };
