// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_sheet_details_list_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSheetDetailsBaseResponse _$TimeSheetDetailsBaseResponseFromJson(
    Map<String, dynamic> json) {
  return TimeSheetDetailsBaseResponse()
    ..listOfTimesheetDetails = (json['listOfTimesheetDetails'] as List)
        .map(
            (e) => TimeSheetDetailsResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$TimeSheetDetailsBaseResponseToJson(
        TimeSheetDetailsBaseResponse instance) =>
    <String, dynamic>{
      'listOfTimesheetDetails': instance.listOfTimesheetDetails,
      'err_MSG': instance.err_MSG,
    };
