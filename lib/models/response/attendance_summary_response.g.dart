// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceSummaryResponse _$AttendanceSummaryResponseFromJson(
    Map<String, dynamic> json) {
  return AttendanceSummaryResponse()
    ..check_out = json['check_out'] as String
    ..check_in = json['check_in'] as String
    ..rec_date = json['rec_date'] as String;
}

Map<String, dynamic> _$AttendanceSummaryResponseToJson(
        AttendanceSummaryResponse instance) =>
    <String, dynamic>{
      'check_out': instance.check_out,
      'check_in': instance.check_in,
      'rec_date': instance.rec_date,
    };
