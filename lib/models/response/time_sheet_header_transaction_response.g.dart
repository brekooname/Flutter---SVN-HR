// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_sheet_header_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSheetHeaderTransactionResponse _$TimeSheetHeaderTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return TimeSheetHeaderTransactionResponse()
    ..difference_hour = json['difference_hour'] as num
    ..shit_type_hour = json['shit_type_hour'] as num
    ..work_hour = json['work_hour'] as num
    ..row_id = json['row_id'] as String
    ..updated_at = json['updated_at'] as String
    ..start_date = json['start_date'] as String
    ..deleted_at = json['deleted_at'] as String
    ..updated_by = json['updated_by'] as String
    ..created_at = json['created_at'] as String
    ..employee_id = json['employee_id'] as String
    ..deleted_by = json['deleted_by'] as String
    ..created_by = json['created_by'] as String;
}

Map<String, dynamic> _$TimeSheetHeaderTransactionResponseToJson(
        TimeSheetHeaderTransactionResponse instance) =>
    <String, dynamic>{
      'difference_hour': instance.difference_hour,
      'shit_type_hour': instance.shit_type_hour,
      'work_hour': instance.work_hour,
      'row_id': instance.row_id,
      'updated_at': instance.updated_at,
      'start_date': instance.start_date,
      'deleted_at': instance.deleted_at,
      'updated_by': instance.updated_by,
      'created_at': instance.created_at,
      'employee_id': instance.employee_id,
      'deleted_by': instance.deleted_by,
      'created_by': instance.created_by,
    };
