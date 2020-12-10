// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseRequest _$ExpenseRequestFromJson(Map<String, dynamic> json) {
  return ExpenseRequest()
    ..currency_id = json['currency_id'] as String
    ..permission_method = json['permission_method'] as String
    ..employee_id = json['employee_id'] as String
    ..expense_amount = json['expense_amount'] as num
    ..response_date = json['response_date'] as String
    ..expense_date = json['expense_date'] as String
    ..request_status = json['request_status'] as String
    ..row_id = json['row_id'] as String
    ..trans_status = json['trans_status'] as String
    ..extra_details = json['extra_details'] as String
    ..description = json['description'] as String
    ..request_date = json['request_date'] as String
    ..approved_amount = json['approved_amount'] as num
    ..approve_date = json['approve_date'] as String;
}

Map<String, dynamic> _$ExpenseRequestToJson(ExpenseRequest instance) =>
    <String, dynamic>{
      'currency_id': instance.currency_id,
      'permission_method': instance.permission_method,
      'employee_id': instance.employee_id,
      'expense_amount': instance.expense_amount,
      'response_date': instance.response_date,
      'expense_date': instance.expense_date,
      'request_status': instance.request_status,
      'row_id': instance.row_id,
      'trans_status': instance.trans_status,
      'extra_details': instance.extra_details,
      'description': instance.description,
      'request_date': instance.request_date,
      'approved_amount': instance.approved_amount,
      'approve_date': instance.approve_date,
    };
