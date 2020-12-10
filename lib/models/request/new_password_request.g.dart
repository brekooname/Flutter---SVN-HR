// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewPasswordRequest _$NewPasswordRequestFromJson(Map<String, dynamic> json) {
  return NewPasswordRequest(
    tokenID: json['tokenID'] as String,
    oldPassword: json['oldPassword'] as String,
    newPassword: json['newPassword'] as String,
    repatedPassword: json['repatedPassword'] as String,
  );
}

Map<String, dynamic> _$NewPasswordRequestToJson(NewPasswordRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'repatedPassword': instance.repatedPassword,
    };
