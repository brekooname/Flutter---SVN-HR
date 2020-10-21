// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_approval_object_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetApprovalObjectBaseResponse _$GetApprovalObjectBaseResponseFromJson(
    Map<String, dynamic> json) {
  return GetApprovalObjectBaseResponse()
    ..err_MSG = json['err_MSG'] as String
    ..approvalInboxObject = GetApprovalObjectResponse.fromJson(
        json['approvalInboxObject'] as Map<String, dynamic>)
    ..response = json['response'] as String;
}

Map<String, dynamic> _$GetApprovalObjectBaseResponseToJson(
        GetApprovalObjectBaseResponse instance) =>
    <String, dynamic>{
      'err_MSG': instance.err_MSG,
      'approvalInboxObject': instance.approvalInboxObject,
      'response': instance.response,
    };
