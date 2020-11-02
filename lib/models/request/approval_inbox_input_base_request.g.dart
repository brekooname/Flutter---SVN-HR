// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_inbox_input_base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalInboxInputBaseRequest _$ApprovalInboxInputBaseRequestFromJson(
    Map<String, dynamic> json) {
  return ApprovalInboxInputBaseRequest(
    tokenId: json['tokenId'] as String,
    approvalObject: ApprovalInboxInputRequest.fromJson(
        json['approvalObject'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ApprovalInboxInputBaseRequestToJson(
        ApprovalInboxInputBaseRequest instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'approvalObject': instance.approvalObject,
    };
