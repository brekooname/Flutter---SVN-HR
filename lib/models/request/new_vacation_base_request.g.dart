// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_vacation_base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewVacationBaseRequest _$NewVacationBaseRequestFromJson(
    Map<String, dynamic> json) {
  return NewVacationBaseRequest(
    tokenID: json['tokenID'] as String,
    vac: NewVacationRequest.fromJson(json['vac'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NewVacationBaseRequestToJson(
        NewVacationBaseRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'vac': instance.vac,
    };
