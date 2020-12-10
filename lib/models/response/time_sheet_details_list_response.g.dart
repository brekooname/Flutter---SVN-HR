// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_sheet_details_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSheetDetailsResponse _$TimeSheetDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return TimeSheetDetailsResponse()
    ..project_name = json['project_name'] as String
    ..status_display = json['status_display'] as String
    ..work_hour = json['work_hour'] as num
    ..project_id = json['project_id'] as String
    ..type = json['type'] as String
    ..updated_at = json['updated_at'] as String
    ..employee_timesheet_id = json['employee_timesheet_id'] as String
    ..updated_by = json['updated_by'] as String
    ..description = json['description'] as String
    ..extra_details = json['extra_details'] as String
    ..end_time = json['end_time'] as num
    ..status = json['status'] as String
    ..row_id = json['row_id'] as String
    ..break_hours = json['break_hours'] as num
    ..deleted_at = json['deleted_at'] as String
    ..total_work_hours = json['total_work_hours'] as num
    ..created_at = json['created_at'] as num
    ..start_time = json['start_time'] as num
    ..deleted_by = json['deleted_by'] as String
    ..created_by = json['created_by'] as String;
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
