// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_summary_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceSummaryBaseResponse _$AttendanceSummaryBaseResponseFromJson(
    Map<String, dynamic> json) {
  return AttendanceSummaryBaseResponse()
    ..myAttendSummaryRecords = (json['myAttendSummaryRecords'] as List)
        .map((e) =>
            AttendanceSummaryResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String
    ..response = json['response'] as String;
}

Map<String, dynamic> _$AttendanceSummaryBaseResponseToJson(
        AttendanceSummaryBaseResponse instance) =>
    <String, dynamic>{
      'myAttendSummaryRecords': instance.myAttendSummaryRecords,
      'err_MSG': instance.err_MSG,
      'response': instance.response,
    };
