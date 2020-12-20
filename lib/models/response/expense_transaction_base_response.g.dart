// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_transaction_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseTransactionBaseResponse _$ExpenseTransactionBaseResponseFromJson(
    Map<String, dynamic> json) {
  return ExpenseTransactionBaseResponse()
    ..expenseList = (json['expenseList'] as List)
        .map((e) =>
            ExpenseTransactionResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String
    ..response = json['response'] as String;
}

Map<String, dynamic> _$ExpenseTransactionBaseResponseToJson(
        ExpenseTransactionBaseResponse instance) =>
    <String, dynamic>{
      'expenseList': instance.expenseList,
      'err_MSG': instance.err_MSG,
      'response': instance.response,
    };
