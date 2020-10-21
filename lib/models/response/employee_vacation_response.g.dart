// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_vacation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeVacationResponse _$EmployeeVacationResponseFromJson(
    Map<String, dynamic> json) {
  return EmployeeVacationResponse()
    ..due_balance = (json['due_balance'] as num).toDouble()
    ..effective_date = json['effective_date'] as String
    ..last_vacation_date = json['last_vacation_date'] as String
    ..rec_attachment = json['rec_attachment'] as String
    ..annual_balance = (json['annual_balance'] as num).toDouble()
    ..createddate = json['createddate'] as String
    ..updatedby = json['updatedby'] as String
    ..vacation_type = json['vacation_type'] as String
    ..vacation_type_name = json['vacation_type_name'] as String
    ..updatedate = json['updatedate'] as String
    ..permission_method = json['permission_method'] as String
    ..row_id = json['row_id'] as String
    ..consumed_balance = (json['consumed_balance'] as num).toDouble()
    ..vacation_detail_id = json['vacation_detail_id'] as String
    ..active_flg = json['active_flg'] as String
    ..createdby = json['createdby'] as String
    ..previous_balance = (json['previous_balance'] as num).toDouble()
    ..par_row_id = json['par_row_id'] as String
    ..remaining_balance = (json['remaining_balance'] as num).toDouble();
}

Map<String, dynamic> _$EmployeeVacationResponseToJson(
        EmployeeVacationResponse instance) =>
    <String, dynamic>{
      'due_balance': instance.due_balance,
      'effective_date': instance.effective_date,
      'last_vacation_date': instance.last_vacation_date,
      'rec_attachment': instance.rec_attachment,
      'annual_balance': instance.annual_balance,
      'createddate': instance.createddate,
      'updatedby': instance.updatedby,
      'vacation_type': instance.vacation_type,
      'vacation_type_name': instance.vacation_type_name,
      'updatedate': instance.updatedate,
      'permission_method': instance.permission_method,
      'row_id': instance.row_id,
      'consumed_balance': instance.consumed_balance,
      'vacation_detail_id': instance.vacation_detail_id,
      'active_flg': instance.active_flg,
      'createdby': instance.createdby,
      'previous_balance': instance.previous_balance,
      'par_row_id': instance.par_row_id,
      'remaining_balance': instance.remaining_balance,
    };
