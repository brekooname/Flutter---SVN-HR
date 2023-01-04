// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_work_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraWorkRequest _$ExtraWorkRequestFromJson(Map<String, dynamic> json) {
  return ExtraWorkRequest()
    ..employee_id = json['employee_id'] as String
    ..unit = json['unit'] as String
    ..unit_quantity = json['unit_quantity'] as num
    ..reason_id = json['reason_id'] as String
    ..row_id = json['row_id'] as String
    ..status = json['status'] as String
    ..requested_by = json['requested_by'] as String
    ..extra_details = json['extra_details'] as String
    ..day_type = json['day_type'] as String
    ..request_date = json['request_date'] as String
    ..approved_by = json['approved_by'] as String
    ..extra_work_date = json['extra_work_date'] as String;
}

Map<String, dynamic> _$ExtraWorkRequestToJson(ExtraWorkRequest instance) =>
    <String, dynamic>{
      'employee_id': instance.employee_id,
      'unit': instance.unit,
      'unit_quantity': instance.unit_quantity,
      'reason_id': instance.reason_id,
      'row_id': instance.row_id,
      'status': instance.status,
      'requested_by': instance.requested_by,
      'extra_details': instance.extra_details,
      'day_type': instance.day_type,
      'request_date': instance.request_date,
      'approved_by': instance.approved_by,
      'extra_work_date': instance.extra_work_date,
    };
