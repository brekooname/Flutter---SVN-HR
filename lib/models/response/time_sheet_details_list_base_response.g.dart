// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_sheet_details_list_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSheetDetailsBaseResponse _$TimeSheetDetailsBaseResponseFromJson(
    Map<String, dynamic> json) {
  // Extract 'listOfTimesheetDetails' and cast each element to the desired type
  var listOfTimesheetDetailsJson = json['listOfTimesheetDetails'] as List<dynamic>?;
  var listOfTimesheetDetails = listOfTimesheetDetailsJson != null
      ? listOfTimesheetDetailsJson
      .map((e) => TimeSheetDetailsResponse.fromJson(e as Map<String, dynamic>))
      .toList()
      : <TimeSheetDetailsResponse>[]; // Provide a default empty list if null

  return TimeSheetDetailsBaseResponse()
    ..listOfTimesheetDetails = listOfTimesheetDetails
    ..err_MSG = json['err_MSG'] as String? ?? ''; // Provide a default value if null
}


Map<String, dynamic> _$TimeSheetDetailsBaseResponseToJson(
        TimeSheetDetailsBaseResponse instance) =>
    <String, dynamic>{
      'listOfTimesheetDetails': instance.listOfTimesheetDetails,
      'err_MSG': instance.err_MSG,
    };
