// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lov_value_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LovValuesResponse _$LovValuesResponseFromJson(Map<String, dynamic> json) {
  return LovValuesResponse()
    ..response = json['response'] as String
    ..lovs = (json['lovs'] as List)
        .map((e) => LovValues.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$LovValuesResponseToJson(LovValuesResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'lovs': instance.lovs,
      'err_MSG': instance.err_MSG,
    };
