// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_transaction_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacationTransactionBaseResponse _$VacationTransactionBaseResponseFromJson(
    Map<String, dynamic> json) {
  return VacationTransactionBaseResponse()
    ..vacationTransactions = (json['vacationTransactions'] as List)
        .map((e) =>
            VacationTransactionResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$VacationTransactionBaseResponseToJson(
        VacationTransactionBaseResponse instance) =>
    <String, dynamic>{
      'vacationTransactions':
          instance.vacationTransactions.map((e) => e.toJson()).toList(),
      'err_MSG': instance.err_MSG,
    };
