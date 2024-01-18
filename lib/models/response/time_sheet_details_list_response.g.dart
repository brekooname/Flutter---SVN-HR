// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_sheet_details_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSheetDetailsResponse _$TimeSheetDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return TimeSheetDetailsResponse()
    ..project_name = json['project_name'] as String? ?? 'default_project_name'
    ..status_display = json['status_display'] as String? ?? 'default_status_display'
    ..work_hour = json['work_hour'] as num? ?? 0
    ..project_id = json['project_id'] as String? ?? 'default_project_id'
    ..type = json['type'] as String? ?? 'default_type'
    ..updated_at = json['updated_at'] as String? ?? 'default_updated_at'
    ..employee_timesheet_id = json['employee_timesheet_id'] as String? ?? 'default_employee_timesheet_id'
    ..updated_by = json['updated_by'] as String? ?? 'default_updated_by'
    ..description = json['description'] as String? ?? 'default_description'
    ..extra_details = json['extra_details'] as String? ?? 'default_extra_details'
    ..end_time = json['end_time'] as num? ?? 0
    ..status = json['status'] as String? ?? 'default_status'
    ..row_id = json['row_id'] as String? ?? 'default_row_id'
    ..break_hours = json['break_hours'] as num? ?? 0
    ..deleted_at = json['deleted_at'] as String? ?? 'default_deleted_at'
    ..total_work_hours = json['total_work_hours'] as num? ?? 0
    ..created_at = json['created_at'] as num? ?? 0
    ..start_time = json['start_time'] as num? ?? 0
    ..deleted_by = json['deleted_by'] as String? ?? 'default_deleted_by'
    ..created_by = json['created_by'] as String? ?? 'default_created_by';
}


Map<String, dynamic> _$TimeSheetDetailsResponseToJson(
        TimeSheetDetailsResponse instance) =>
    <String, dynamic>{
      'project_name': instance.project_name,
      'status_display': instance.status_display,
      'work_hour': instance.work_hour,
      'project_id': instance.project_id,
      'type': instance.type,
      'updated_at': instance.updated_at,
      'employee_timesheet_id': instance.employee_timesheet_id,
      'updated_by': instance.updated_by,
      'description': instance.description,
      'extra_details': instance.extra_details,
      'end_time': instance.end_time,
      'status': instance.status,
      'row_id': instance.row_id,
      'break_hours': instance.break_hours,
      'deleted_at': instance.deleted_at,
      'total_work_hours': instance.total_work_hours,
      'created_at': instance.created_at,
      'start_time': instance.start_time,
      'deleted_by': instance.deleted_by,
      'created_by': instance.created_by,
    };
