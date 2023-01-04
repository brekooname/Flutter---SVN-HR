// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_work_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraWorkTransactionResponse _$ExtraWorkTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return ExtraWorkTransactionResponse()
    ..extra_work_date = json['extra_work_date'] as String
    ..approvalList = (json['approvalList'] as List)
        .map((e) => ApprovalList.fromJson(e as Map<String, dynamic>))
        .toList()
    ..approved_by = json['approved_by'] as String
    ..day_type_display_value = json['day_type_display_value'] as String
    ..day_type = json['day_type'] as String
    ..request_date = json['request_date'] as String
    ..extra_details = json['extra_details'] as String
    ..requested_by = json['requested_by'] as String
    ..status_display_value = json['status_display_value'] as String
    ..status = json['status'] as String
    ..reason_id_display_value = json['reason_id_display_value'] as String
    ..reason_id = json['reason_id'] as String
    ..unit_quantity = json['unit_quantity'] as num
    ..unit_display_value = json['unit_display_value'] as String
    ..unit = json['unit'] as String
    ..employee_id = json['employee_id'] as String
    ..row_id = json['row_id'] as String
    ..approval_date = json['approval_date'] as String;
}

Map<String, dynamic> _$ExtraWorkTransactionResponseToJson(
        ExtraWorkTransactionResponse instance) =>
    <String, dynamic>{
      'extra_work_date': instance.extra_work_date,
      'approvalList': instance.approvalList,
      'approved_by': instance.approved_by,
      'day_type_display_value': instance.day_type_display_value,
      'day_type': instance.day_type,
      'request_date': instance.request_date,
      'extra_details': instance.extra_details,
      'requested_by': instance.requested_by,
      'status_display_value': instance.status_display_value,
      'status': instance.status,
      'reason_id_display_value': instance.reason_id_display_value,
      'reason_id': instance.reason_id,
      'unit_quantity': instance.unit_quantity,
      'unit_display_value': instance.unit_display_value,
      'unit': instance.unit,
      'employee_id': instance.employee_id,
      'row_id': instance.row_id,
      'approval_date': instance.approval_date,
    };
