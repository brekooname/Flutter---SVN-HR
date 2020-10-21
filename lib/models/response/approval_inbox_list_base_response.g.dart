// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_inbox_list_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalInboxListBaseResponse _$ApprovalInboxListBaseResponseFromJson(
    Map<String, dynamic> json) {
  return ApprovalInboxListBaseResponse()
    ..response = json['response'] as String
    ..listOfApprovals = (json['listOfApprovals'] as List)
        .map((e) =>
            ApprovalInboxListResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$ApprovalInboxListBaseResponseToJson(
        ApprovalInboxListBaseResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'listOfApprovals': instance.listOfApprovals,
      'err_MSG': instance.err_MSG,
    };
