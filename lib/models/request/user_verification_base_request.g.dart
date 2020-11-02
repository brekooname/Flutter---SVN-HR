// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_verification_base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVerificationBaseRequest _$UserVerificationBaseRequestFromJson(
    Map<String, dynamic> json) {
  return UserVerificationBaseRequest(
    tokenId: json['tokenId'] as String,
    userVerificationRequest: UserVerificationRequest.fromJson(
        json['userVerificationRequest'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserVerificationBaseRequestToJson(
        UserVerificationBaseRequest instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'userVerificationRequest': instance.userVerificationRequest,
    };
