// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_type_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacationTypeBaseResponse _$VacationTypeBaseResponseFromJson(Map<String, dynamic> json) {
  return VacationTypeBaseResponse()
    ..response = json['response'] as String? ?? 'default_response'
    ..vacations = (json['vacations'] as List<dynamic>?)
        ?.map((e) => VacationTypeResponse.fromJson(e as Map<String, dynamic>))
        .toList() ?? []
    ..err_MSG = json['err_MSG'] as String? ?? 'default_err_msg';
}



Map<String, dynamic> _$VacationTypeBaseResponseToJson(
        VacationTypeBaseResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'vacations': instance.vacations,
      'err_MSG': instance.err_MSG,
    };
