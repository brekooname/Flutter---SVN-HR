// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_inbox_attachments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalInboxAttachmentsResponse _$ApprovalInboxAttachmentsResponseFromJson(
    Map<String, dynamic> json) {
  return ApprovalInboxAttachmentsResponse()
    ..attachment_rowId = json['attachment_rowId'] as String
    ..attachment_name = json['attachment_name'] as String;
}

Map<String, dynamic> _$ApprovalInboxAttachmentsResponseToJson(
        ApprovalInboxAttachmentsResponse instance) =>
    <String, dynamic>{
      'attachment_rowId': instance.attachment_rowId,
      'attachment_name': instance.attachment_name,
    };
