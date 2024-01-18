// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_work_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraWorkTransactionResponse _$ExtraWorkTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return ExtraWorkTransactionResponse()
    ..extra_work_date = json['extra_work_date'] as String? ?? 'default_extra_work_date'
    ..approvalList = (json['approvalList'] as List<dynamic>?)
        ?.map((e) => ApprovalList.fromJson(e as Map<String, dynamic>))
        .toList() ?? []
    ..approved_by = json['approved_by'] as String? ?? 'default_approved_by'
    ..day_type_display_value = json['day_type_display_value'] as String? ?? 'default_day_type_display_value'
    ..day_type = json['day_type'] as String? ?? 'default_day_type'
    ..request_date = json['request_date'] as String? ?? 'default_request_date'
    ..extra_details = json['extra_details'] as String? ?? 'default_extra_details'
    ..requested_by = json['requested_by'] as String? ?? 'default_requested_by'
    ..status_display_value = json['status_display_value'] as String? ?? 'default_status_display_value'
    ..status = json['status'] as String? ?? 'default_status'
    ..reason_id_display_value = json['reason_id_display_value'] as String? ?? 'default_reason_id_display_value'
    ..reason_id = json['reason_id'] as String? ?? 'default_reason_id'
    ..unit_quantity = (json['unit_quantity'] as num?)?.toDouble() ?? 0.0
    ..unit_display_value = json['unit_display_value'] as String? ?? 'default_unit_display_value'
    ..unit = json['unit'] as String? ?? 'default_unit'
    ..employee_id = json['employee_id'] as String? ?? 'default_employee_id'
    ..row_id = json['row_id'] as String? ?? 'default_row_id'
    ..approval_date = json['approval_date'] as String? ?? 'default_approval_date';
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
