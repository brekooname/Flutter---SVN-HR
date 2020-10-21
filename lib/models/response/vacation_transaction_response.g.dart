// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacationTransactionResponse _$VacationTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return VacationTransactionResponse()
    ..vacation_location = json['vacation_location'] as String
    ..createddate = json['createddate'] as String
    ..row_id = json['row_id'] as String
    ..actual_end = json['actual_end'] as String
    ..approve_date = json['approve_date'] as String
    ..remark = json['remark'] as String
    ..request_date = json['request_date'] as String
    ..holiday_days = json['holiday_days'] as int
    ..updatedate = json['updatedate'] as String
    ..vacation_id = json['vacation_id'] as String
    ..vacation_Name = json['vacation_Name'] as String
    ..trans_reason = json['trans_reason'] as String
    ..trans_reason_code = json['trans_reason_code'] as String
    ..trans_reason_displayValue = json['trans_reason_displayValue'] as String
    ..actual_start = json['actual_start'] as String
    ..employee_id = json['employee_id'] as String
    ..paid_days = json['paid_days'] as int
    ..unpaid_days = json['unpaid_days'] as int
    ..linked_vacation_id = json['linked_vacation_id'] as String
    ..trans_period = json['trans_period'] as int
    ..planned_flg = json['planned_flg'] as String
    ..request_status = json['request_status'] as String
    ..request_status_code = json['request_status_code'] as String
    ..request_status_displayValue =
        json['request_status_displayValue'] as String
    ..subsititude_emp = json['subsititude_emp'] as String
    ..createdby = json['createdby'] as String
    ..req_channel_displayValue = json['req_channel_displayValue'] as String
    ..req_channel_code = json['req_channel_code'] as String
    ..req_channel = json['req_channel'] as String
    ..end_date = json['end_date'] as String
    ..permission_method = json['permission_method'] as String
    ..trans_status_displayValue = json['trans_status_displayValue'] as String
    ..trans_status_code = json['trans_status_code'] as String
    ..trans_status = json['trans_status'] as String
    ..updatedby = json['updatedby'] as String
    ..previous_balance = (json['previous_balance'] as num).toDouble()
    ..new_balance = (json['new_balance'] as num).toDouble()
    ..actual_period = json['actual_period'] as int
    ..start_date = json['start_date'] as String
    ..vacation_location_code = json['vacation_location_code'] as String
    ..vacation_location_displayValue =
        json['vacation_location_displayValue'] as String;
}

Map<String, dynamic> _$VacationTransactionResponseToJson(
        VacationTransactionResponse instance) =>
    <String, dynamic>{
      'vacation_location': instance.vacation_location,
      'createddate': instance.createddate,
      'row_id': instance.row_id,
      'actual_end': instance.actual_end,
      'approve_date': instance.approve_date,
      'remark': instance.remark,
      'request_date': instance.request_date,
      'holiday_days': instance.holiday_days,
      'updatedate': instance.updatedate,
      'vacation_id': instance.vacation_id,
      'vacation_Name': instance.vacation_Name,
      'trans_reason': instance.trans_reason,
      'trans_reason_code': instance.trans_reason_code,
      'trans_reason_displayValue': instance.trans_reason_displayValue,
      'actual_start': instance.actual_start,
      'employee_id': instance.employee_id,
      'paid_days': instance.paid_days,
      'unpaid_days': instance.unpaid_days,
      'linked_vacation_id': instance.linked_vacation_id,
      'trans_period': instance.trans_period,
      'planned_flg': instance.planned_flg,
      'request_status': instance.request_status,
      'request_status_code': instance.request_status_code,
      'request_status_displayValue': instance.request_status_displayValue,
      'subsititude_emp': instance.subsititude_emp,
      'createdby': instance.createdby,
      'req_channel_displayValue': instance.req_channel_displayValue,
      'req_channel_code': instance.req_channel_code,
      'req_channel': instance.req_channel,
      'end_date': instance.end_date,
      'permission_method': instance.permission_method,
      'trans_status_displayValue': instance.trans_status_displayValue,
      'trans_status_code': instance.trans_status_code,
      'trans_status': instance.trans_status,
      'updatedby': instance.updatedby,
      'previous_balance': instance.previous_balance,
      'new_balance': instance.new_balance,
      'actual_period': instance.actual_period,
      'start_date': instance.start_date,
      'vacation_location_code': instance.vacation_location_code,
      'vacation_location_displayValue': instance.vacation_location_displayValue,
    };
