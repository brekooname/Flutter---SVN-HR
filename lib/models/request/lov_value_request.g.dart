// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lov_value_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LovValuesRequest _$LovValuesRequestFromJson(Map<String, dynamic> json) {
  return LovValuesRequest(
    tokenID: json['tokenID'] as String,
  )..lovID = json['lovID'] as String;
}

Map<String, dynamic> _$LovValuesRequestToJson(LovValuesRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'lovID': instance.lovID,
    };
