// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_check_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastCheckBaseResponse _$LastCheckBaseResponseFromJson(
    Map<String, dynamic> json) {
  return LastCheckBaseResponse()
    ..checkWra =
        LastCheckResponse.fromJson(json['checkWra'] as Map<String, dynamic>)
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$LastCheckBaseResponseToJson(
        LastCheckBaseResponse instance) =>
    <String, dynamic>{
      'checkWra': instance.checkWra.toJson(),
      'err_MSG': instance.err_MSG,
    };
