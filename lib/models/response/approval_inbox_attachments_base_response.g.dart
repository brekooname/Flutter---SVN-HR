// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_inbox_attachments_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalInboxAttachmentsBaseResponse
    _$ApprovalInboxAttachmentsBaseResponseFromJson(Map<String, dynamic> json) {
  return ApprovalInboxAttachmentsBaseResponse()
    ..response = json['response'] as String
    ..listOfAttachments = (json['listOfAttachments'] as List)
        .map((e) => ApprovalInboxAttachmentsResponse.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$ApprovalInboxAttachmentsBaseResponseToJson(
        ApprovalInboxAttachmentsBaseResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'listOfAttachments': instance.listOfAttachments,
      'err_MSG': instance.err_MSG,
    };
