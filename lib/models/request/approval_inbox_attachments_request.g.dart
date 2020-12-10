// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_inbox_attachments_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalInboxAttachmentsRequest _$ApprovalInboxAttachmentsRequestFromJson(
    Map<String, dynamic> json) {
  return ApprovalInboxAttachmentsRequest(
    token_id: json['token_id'] as String,
    approval_inbox_row_id: json['approval_inbox_row_id'] as String,
  );
}

Map<String, dynamic> _$ApprovalInboxAttachmentsRequestToJson(
        ApprovalInboxAttachmentsRequest instance) =>
    <String, dynamic>{
      'token_id': instance.token_id,
      'approval_inbox_row_id': instance.approval_inbox_row_id,
    };
