// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_work_transaction_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraWorkTransactionBaseResponse _$ExtraWorkTransactionBaseResponseFromJson(
    Map<String, dynamic> json) {
  return ExtraWorkTransactionBaseResponse()
    ..extraWorkList = (json['extraWorkList'] as List)
        .map((e) =>
            ExtraWorkTransactionResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String
    ..response = json['response'] as String;
}

Map<String, dynamic> _$ExtraWorkTransactionBaseResponseToJson(
        ExtraWorkTransactionBaseResponse instance) =>
    <String, dynamic>{
      'extraWorkList': instance.extraWorkList,
      'err_MSG': instance.err_MSG,
      'response': instance.response,
    };
