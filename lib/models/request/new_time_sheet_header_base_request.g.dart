// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_time_sheet_header_base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTimeSheetHeaderBaseRequest _$NewTimeSheetHeaderBaseRequestFromJson(
    Map<String, dynamic> json) {
  return NewTimeSheetHeaderBaseRequest(
    tokenID: json['tokenID'] as String,
    timesheetHeader: NewTimeSheetHeaderRequest.fromJson(
        json['timesheetHeader'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NewTimeSheetHeaderBaseRequestToJson(
        NewTimeSheetHeaderBaseRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'timesheetHeader': instance.timesheetHeader,
    };
