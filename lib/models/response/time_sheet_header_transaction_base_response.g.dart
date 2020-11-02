// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_sheet_header_transaction_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSheetHeaderTransactionBaseResponse
    _$TimeSheetHeaderTransactionBaseResponseFromJson(
        Map<String, dynamic> json) {
  return TimeSheetHeaderTransactionBaseResponse()
    ..timesheetTransactions = (json['timesheetTransactions'] as List)
        .map((e) => TimeSheetHeaderTransactionResponse.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$TimeSheetHeaderTransactionBaseResponseToJson(
        TimeSheetHeaderTransactionBaseResponse instance) =>
    <String, dynamic>{
      'timesheetTransactions': instance.timesheetTransactions,
      'err_MSG': instance.err_MSG,
    };
