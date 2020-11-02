// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_sheet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSheetRequest _$TimeSheetRequestFromJson(Map<String, dynamic> json) {
  return TimeSheetRequest(
    tokenId: json['tokenId'] as String,
    fromDate: json['fromDate'] as String,
    toDate: json['toDate'] as String,
  );
}

Map<String, dynamic> _$TimeSheetRequestToJson(TimeSheetRequest instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
    };
