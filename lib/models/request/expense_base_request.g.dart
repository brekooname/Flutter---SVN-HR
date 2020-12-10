// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseBaseRequest _$ExpenseBaseRequestFromJson(Map<String, dynamic> json) {
  return ExpenseBaseRequest(
    tokenID: json['tokenID'] as String,
    expenseTrans:
        ExpenseRequest.fromJson(json['expenseTrans'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ExpenseBaseRequestToJson(ExpenseBaseRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'expenseTrans': instance.expenseTrans,
    };
