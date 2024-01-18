// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_inbox_list_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalInboxListBaseResponse _$ApprovalInboxListBaseResponseFromJson(
    Map<String, dynamic> json) {
  return ApprovalInboxListBaseResponse()
    ..response = json['response'] as String? ?? 'default_response'
    ..listOfApprovals = (json['listOfApprovals'] as List<dynamic>?)
        ?.map((e) =>
        ApprovalInboxListResponse.fromJson(e as Map<String, dynamic>))
        .toList() ?? []
    ..err_MSG = json['err_MSG'] as String? ?? 'default_err_msg';
}

Map<String, dynamic> _$ApprovalInboxListBaseResponseToJson(
        ApprovalInboxListBaseResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'listOfApprovals': instance.listOfApprovals,
      'err_MSG': instance.err_MSG,
    };
