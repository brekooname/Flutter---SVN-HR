// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_transaction_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTransactionBaseResponse _$LeaveTransactionBaseResponseFromJson(
    Map<String, dynamic> json) {
  return LeaveTransactionBaseResponse()
    ..leaveTransactions = (json['leaveTransactions'] as List)
        .map(
            (e) => LeaveTransactionResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$LeaveTransactionBaseResponseToJson(
        LeaveTransactionBaseResponse instance) =>
    <String, dynamic>{
      'leaveTransactions':
          instance.leaveTransactions.map((e) => e.toJson()).toList(),
      'err_MSG': instance.err_MSG,
    };
