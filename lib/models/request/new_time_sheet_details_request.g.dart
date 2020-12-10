// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_time_sheet_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTimeSheetDetailsRequest _$NewTimeSheetDetailsRequestFromJson(
    Map<String, dynamic> json) {
  return NewTimeSheetDetailsRequest(
    start_time: json['start_time'] as num,
    status: json['status'] as String,
    end_time: json['end_time'] as num,
    description: json['description'] as String,
    employee_timesheet_id: json['employee_timesheet_id'] as String,
    project_id: json['project_id'] as String,
    row_id: json['row_id'] as String,
  );
}

Map<String, dynamic> _$NewTimeSheetDetailsRequestToJson(
        NewTimeSheetDetailsRequest instance) =>
    <String, dynamic>{
      'start_time': instance.start_time,
      'status': instance.status,
      'end_time': instance.end_time,
      'description': instance.description,
      'employee_timesheet_id': instance.employee_timesheet_id,
      'project_id': instance.project_id,
      'row_id': instance.row_id,
    };
