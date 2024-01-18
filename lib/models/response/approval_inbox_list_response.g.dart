// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_inbox_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalInboxListResponse _$ApprovalInboxListResponseFromJson(
    Map<String, dynamic> json) {
  return ApprovalInboxListResponse()
    ..request_response = json['request_response'] as String? ?? 'default_request_response'
    ..request_response_code = json['request_response_code'] as String? ?? 'default_request_response_code'
    ..title_name = json['title_name'] as String? ?? 'default_title_name'
    ..core_emp_name = json['core_emp_name'] as String? ?? 'default_core_emp_name'
    ..core_emp = json['core_emp'] as String? ?? 'default_core_emp'
    ..response_notes = json['response_notes'] as String? ?? 'default_response_notes'
    ..request_viewed = json['request_viewed'] as String? ?? 'default_request_viewed'
    ..approval_desc = json['approval_desc'] as String? ?? 'default_approval_desc'
    ..row_id = json['row_id'] as String? ?? 'default_row_id'
    ..updateddate = json['updateddate'] as String? ?? 'default_updateddate'
    ..incharge_usr = json['incharge_usr'] as String? ?? 'default_incharge_usr'
    ..approval_request_date = json['approval_request_date'] as String? ?? 'default_approval_request_date'
    ..object_row_id = json['object_row_id'] as String? ?? 'default_object_row_id'
    ..object_type = json['object_type'] as String? ?? 'default_object_type'
    ..createddate = json['createddate'] as String? ?? 'default_createddate'
    ..createdby = json['createdby'] as String? ?? 'default_createdby'
    ..updatedby = json['updatedby'] as String? ?? 'default_updatedby'
    ..request_response_displayValue =
        json['request_response_displayValue'] as String? ?? 'default_request_response_displayValue';
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
