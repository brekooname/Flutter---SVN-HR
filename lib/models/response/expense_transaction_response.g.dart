// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseTransactionResponse _$ExpenseTransactionResponseFromJson(Map<String, dynamic> json) {
  return ExpenseTransactionResponse()
    ..approved_amount = json['approved_amount'] as num? ?? 0
    ..request_date = json['request_date'] as String? ?? ''
    ..currency_id = json['currency_id'] as String? ?? ''
    ..expense_amount = json['expense_amount'] as num? ?? 0
    ..expense_date = json['expense_date'] as String? ?? ''
    ..description = json['description'] as String? ?? ''
    ..row_id = json['row_id'] as String? ?? ''
    ..approvalList = (json['approvalList'] as List<dynamic>?)
        ?.map((e) => ApprovalList.fromJson(e as Map<String, dynamic>))
        .toList() ?? []
    ..request_status = json['request_status'] as String? ?? ''
    ..approval_date = json['approval_date'] as String? ?? ''
    ..currency_display_name = json['currency_display_name'] as String? ?? ''
    ..status_display_name = json['status_display_name'] as String? ?? '';
}

Map<String, dynamic> _$ExpenseTransactionResponseToJson(
        ExpenseTransactionResponse instance) =>
    <String, dynamic>{
      'approved_amount': instance.approved_amount,
      'request_date': instance.request_date,
      'currency_id': instance.currency_id,
      'expense_amount': instance.expense_amount,
      'expense_date': instance.expense_date,
      'description': instance.description,
      'row_id': instance.row_id,
      'approvalList': instance.approvalList,
      'request_status': instance.request_status,
      'approval_date': instance.approval_date,
      'currency_display_name': instance.currency_display_name,
      'status_display_name': instance.status_display_name,
    };
