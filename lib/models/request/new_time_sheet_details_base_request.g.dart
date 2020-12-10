// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_time_sheet_details_base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTimeSheetDetailsBaseRequest _$NewTimeSheetDetailsBaseRequestFromJson(
    Map<String, dynamic> json) {
  return NewTimeSheetDetailsBaseRequest(
    tokenID: json['tokenID'] as String,
    timesheetDetails: NewTimeSheetDetailsRequest.fromJson(
        json['timesheetDetails'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NewTimeSheetDetailsBaseRequestToJson(
        NewTimeSheetDetailsBaseRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'timesheetDetails': instance.timesheetDetails,
    };
