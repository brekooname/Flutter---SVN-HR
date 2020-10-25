// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_object_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalObjectBaseResponse _$ApprovalObjectBaseResponseFromJson(
    Map<String, dynamic> json) {
  return ApprovalObjectBaseResponse()
    ..err_MSG = json['err_MSG'] as String
    ..approvalInboxObject = ApprovalObjectResponse.fromJson(
        json['approvalInboxObject'] as Map<String, dynamic>)
    ..response = json['response'] as String;
}

Map<String, dynamic> _$ApprovalObjectBaseResponseToJson(
        ApprovalObjectBaseResponse instance) =>
    <String, dynamic>{
      'err_MSG': instance.err_MSG,
      'approvalInboxObject': instance.approvalInboxObject,
      'response': instance.response,
    };
