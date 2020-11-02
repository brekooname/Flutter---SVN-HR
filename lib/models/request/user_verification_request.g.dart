// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_verification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVerificationRequest _$UserVerificationRequestFromJson(
    Map<String, dynamic> json) {
  return UserVerificationRequest()
    ..userLat = json['userLat'] as String
    ..userLang = json['userLang'] as String
    ..userMacAddress = json['userMacAddress'] as String
    ..userNetworkBSSID = json['userNetworkBSSID'] as String;
}

Map<String, dynamic> _$UserVerificationRequestToJson(
        UserVerificationRequest instance) =>
    <String, dynamic>{
      'userLat': instance.userLat,
      'userLang': instance.userLang,
      'userMacAddress': instance.userMacAddress,
      'userNetworkBSSID': instance.userNetworkBSSID,
    };
