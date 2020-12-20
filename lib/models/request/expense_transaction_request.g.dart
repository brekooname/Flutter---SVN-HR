// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseTransactionRequest _$ExpenseTransactionRequestFromJson(
    Map<String, dynamic> json) {
  return ExpenseTransactionRequest(
    tokenId: json['tokenId'] as String,
    fromDate: json['fromDate'] as String,
    toDate: json['toDate'] as String,
  );
}

Map<String, dynamic> _$ExpenseTransactionRequestToJson(
        ExpenseTransactionRequest instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
    };
