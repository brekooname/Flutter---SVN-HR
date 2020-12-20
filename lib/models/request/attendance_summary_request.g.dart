// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_summary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceSummaryRequest _$AttendanceSummaryRequestFromJson(
    Map<String, dynamic> json) {
  return AttendanceSummaryRequest(
    tokenId: json['tokenId'] as String,
    fromDate: json['fromDate'] as String,
    toDate: json['toDate'] as String,
  );
}

Map<String, dynamic> _$AttendanceSummaryRequestToJson(
        AttendanceSummaryRequest instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
    };
