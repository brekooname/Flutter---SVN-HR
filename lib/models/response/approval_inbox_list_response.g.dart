// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_inbox_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalInboxListResponse _$ApprovalInboxListResponseFromJson(
    Map<String, dynamic> json) {
  return ApprovalInboxListResponse()
    ..request_response = json['request_response'] as String
    ..request_response_code = json['request_response_code'] as String
    ..title_name = json['title_name'] as String
    ..core_emp_name = json['core_emp_name'] as String
    ..core_emp = json['core_emp'] as String
    ..response_notes = json['response_notes'] as String
    ..request_viewed = json['request_viewed'] as String
    ..approval_desc = json['approval_desc'] as String
    ..row_id = json['row_id'] as String
    ..updateddate = json['updateddate'] as String
    ..incharge_usr = json['incharge_usr'] as String
    ..approval_request_date = json['approval_request_date'] as String
    ..object_row_id = json['object_row_id'] as String
    ..object_type = json['object_type'] as String
    ..createddate = json['createddate'] as String
    ..createdby = json['createdby'] as String
    ..updatedby = json['updatedby'] as String
    ..request_response_displayValue =
        json['request_response_displayValue'] as String;
}

Map<String, dynamic> _$ApprovalInboxListResponseToJson(
        ApprovalInboxListResponse instance) =>
    <String, dynamic>{
      'request_response': instance.request_response,
      'request_response_code': instance.request_response_code,
      'title_name': instance.title_name,
      'core_emp_name': instance.core_emp_name,
      'core_emp': instance.core_emp,
      'response_notes': instance.response_notes,
      'request_viewed': instance.request_viewed,
      'approval_desc': instance.approval_desc,
      'row_id': instance.row_id,
      'updateddate': instance.updateddate,
      'incharge_usr': instance.incharge_usr,
      'approval_request_date': instance.approval_request_date,
      'object_row_id': instance.object_row_id,
      'object_type': instance.object_type,
      'createddate': instance.createddate,
      'createdby': instance.createdby,
      'updatedby': instance.updatedby,
      'request_response_displayValue': instance.request_response_displayValue,
    };
