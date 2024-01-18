// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacationTransactionRequest _$VacationTransactionRequestFromJson(
    Map<String, dynamic> json) {
  return VacationTransactionRequest()
    ..tokenID = json['tokenID'] as String
    ..vac = VacationTransactionRequestWrapper.fromJson(
        json['vac'] as Map<String, dynamic>);
}

Map<String, dynamic> _$VacationTransactionRequestToJson(
        VacationTransactionRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'vac': instance.vac!.toJson(),
    };
