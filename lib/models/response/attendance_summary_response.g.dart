// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceSummaryResponse _$AttendanceSummaryResponseFromJson(
    Map<String, dynamic> json) {
  return AttendanceSummaryResponse()
    ..rec_time = json['rec_time'] as num
    ..source_display_value = json['source_display_value'] as String
    ..source = json['source'] as String
    ..actual_time = json['actual_time'] as num
    ..extra_details = json['extra_details'] as String
    ..status_display_value = json['status_display_value'] as String
    ..status = json['status'] as String
    ..row_id = json['row_id'] as String
    ..emp_clock_id = json['emp_clock_id'] as String
    ..rec_type_display_value = json['rec_type_display_value'] as String
    ..rec_type = json['rec_type'] as String
    ..clock_id = json['clock_id'] as String
    ..rec_date = json['rec_date'] as String;
}

Map<String, dynamic> _$AttendanceSummaryResponseToJson(
        AttendanceSummaryResponse instance) =>
    <String, dynamic>{
      'rec_time': instance.rec_time,
      'source_display_value': instance.source_display_value,
      'source': instance.source,
      'actual_time': instance.actual_time,
      'extra_details': instance.extra_details,
      'status_display_value': instance.status_display_value,
      'status': instance.status,
      'row_id': instance.row_id,
      'emp_clock_id': instance.emp_clock_id,
      'rec_type_display_value': instance.rec_type_display_value,
      'rec_type': instance.rec_type,
      'clock_id': instance.clock_id,
      'rec_date': instance.rec_date,
    };
