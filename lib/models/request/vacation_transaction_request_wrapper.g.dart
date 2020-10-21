// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_transaction_request_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacationTransactionRequestWrapper _$VacationTransactionRequestWrapperFromJson(
    Map<String, dynamic> json) {
  return VacationTransactionRequestWrapper()
    ..fromDate = json['fromDate'] as String
    ..toDate = json['toDate'] as String
    ..statusList = (json['statusList'] as List).map((e) => e as String).toList()
    ..typeList = (json['typeList'] as List).map((e) => e as String).toList();
}

Map<String, dynamic> _$VacationTransactionRequestWrapperToJson(
        VacationTransactionRequestWrapper instance) =>
    <String, dynamic>{
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'statusList': instance.statusList,
      'typeList': instance.typeList,
    };
