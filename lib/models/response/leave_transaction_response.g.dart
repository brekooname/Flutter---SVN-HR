// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTransactionResponse _$LeaveTransactionResponseFromJson(Map<String, dynamic> json) {
  return LeaveTransactionResponse()
    ..request_status = json['request_status'] as String? ?? ""
    ..end_time = json['end_time'] as int? ?? 0
    ..approver_id = json['approver_id'] as String? ?? ""
    ..approve_date = json['approve_date'] as String? ?? ""
    ..leave_displayValue = json['leave_displayValue'] as String? ?? ""
    ..leave_code = json['leave_code'] as String? ?? ""
    ..leave_id = json['leave_id'] as String? ?? ""
    ..updatedate = json['updatedate'] as String? ?? ""
    ..createdby = json['createdby'] as String? ?? ""
    ..remark = json['remark'] as String? ?? ""
    ..request_status_code = json['request_status_code'] as String? ?? ""
    ..request_status_displayValue = json['request_status_displayValue'] as String? ?? ""
    ..row_id = json['row_id'] as String? ?? ""
    ..start_time = json['start_time'] as int? ?? 0
    ..request_date = json['request_date'] as String? ?? ""
    ..approver_note = json['approver_note'] as String? ?? ""
    ..end_date = json['end_date'] as String? ?? ""
    ..start_date = json['start_date'] as String? ?? ""
    ..employee_id = json['employee_id'] as String? ?? ""
    ..trans_type = json['trans_type'] as String? ?? ""
    ..trans_status_code = json['trans_status_code'] as String? ?? ""
    ..trans_status_displayValue = json['trans_status_displayValue'] as String? ?? ""
    ..trans_status = json['trans_status'] as String? ?? ""
    ..createddate = json['createddate'] as String? ?? ""
    ..permission_method = json['permission_method'] as String? ?? ""
    ..end_time_String = json['end_time_String'] as String? ?? ""
    ..start_time_String = json['start_time_String'] as String? ?? ""
    ..approvalList = (json['approvalList'] as List<dynamic>?)
        ?.map((e) => ApprovalList.fromJson(e as Map<String, dynamic>))
        .toList() ?? [];
}


Map<String, dynamic> _$LeaveTransactionResponseToJson(
        LeaveTransactionResponse instance) =>
    <String, dynamic>{
      'request_status': instance.request_status,
      'end_time': instance.end_time,
      'approver_id': instance.approver_id,
      'approve_date': instance.approve_date,
      'leave_displayValue': instance.leave_displayValue,
      'leave_code': instance.leave_code,
      'leave_id': instance.leave_id,
      'updatedate': instance.updatedate,
      'createdby': instance.createdby,
      'remark': instance.remark,
      'request_status_code': instance.request_status_code,
      'request_status_displayValue': instance.request_status_displayValue,
      'row_id': instance.row_id,
      'start_time': instance.start_time,
      'request_date': instance.request_date,
      'approver_note': instance.approver_note,
      'end_date': instance.end_date,
      'start_date': instance.start_date,
      'employee_id': instance.employee_id,
      'trans_type': instance.trans_type,
      'trans_status_code': instance.trans_status_code,
      'trans_status_displayValue': instance.trans_status_displayValue,
      'trans_status': instance.trans_status,
      'createddate': instance.createddate,
      'permission_method': instance.permission_method,
      'end_time_String': instance.end_time_String,
      'start_time_String': instance.start_time_String,
      'approvalList': instance.approvalList.map((e) => e.toJson()).toList(),
    };
