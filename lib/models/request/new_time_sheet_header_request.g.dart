// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_time_sheet_header_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTimeSheetHeaderRequest _$NewTimeSheetHeaderRequestFromJson(
    Map<String, dynamic> json) {
  return NewTimeSheetHeaderRequest(
    start_date: json['start_date'] as String,
    row_id: json['row_id'] as String,
  );
}

Map<String, dynamic> _$NewTimeSheetHeaderRequestToJson(
        NewTimeSheetHeaderRequest instance) =>
    <String, dynamic>{
      'start_date': instance.start_date,
      'row_id': instance.row_id,
    };
