// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_vacation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeVacationResponse _$EmployeeVacationResponseFromJson(
    Map<String, dynamic> json) {
  return EmployeeVacationResponse()
    ..due_balance = (json['due_balance'] as num?)?.toDouble() ?? 0.0
    ..effective_date = json['effective_date'] as String? ?? 'default_effective_date'
    ..last_vacation_date = json['last_vacation_date'] as String? ?? 'default_last_vacation_date'
    ..rec_attachment = json['rec_attachment'] as String? ?? 'default_rec_attachment'
    ..annual_balance = (json['annual_balance'] as num?)?.toDouble() ?? 0.0
    ..createddate = json['createddate'] as String? ?? 'default_createddate'
    ..updatedby = json['updatedby'] as String? ?? 'default_updatedby'
    ..vacation_type = json['vacation_type'] as String? ?? 'default_vacation_type'
    ..vacation_type_name = json['vacation_type_name'] as String? ?? 'default_vacation_type_name'
    ..updatedate = json['updatedate'] as String? ?? 'default_updatedate'
    ..permission_method = json['permission_method'] as String? ?? 'default_permission_method'
    ..row_id = json['row_id'] as String? ?? 'default_row_id'
    ..consumed_balance = (json['consumed_balance'] as num?)?.toDouble() ?? 0.0
    ..vacation_detail_id = json['vacation_detail_id'] as String? ?? 'default_vacation_detail_id'
    ..active_flg = json['active_flg'] as String? ?? 'default_active_flg'
    ..createdby = json['createdby'] as String? ?? 'default_createdby'
    ..previous_balance = (json['previous_balance'] as num?)?.toDouble() ?? 0.0
    ..par_row_id = json['par_row_id'] as String? ?? 'default_par_row_id'
    ..remaining_balance = (json['remaining_balance'] as num?)?.toDouble() ?? 0.0;
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
