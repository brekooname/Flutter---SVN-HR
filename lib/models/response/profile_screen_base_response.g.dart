// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_screen_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileScreenBaseResponse _$ProfileScreenBaseResponseFromJson(Map<String, dynamic> json) {
  return ProfileScreenBaseResponse()
    ..response = json['response'] as String? ?? 'default_response'
    ..err_MSG = json['err_MSG'] as String? ?? 'default_err_msg'
    ..listOfAllScreensDisplay = (json['listOfAllScreensDisplay'] as List<dynamic>?)
        ?.map((e) => ProfileScreenResponse.fromJson(e as Map<String, dynamic>))
        .toList() ?? [];
}



Map<String, dynamic> _$ProfileScreenBaseResponseToJson(
        ProfileScreenBaseResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'err_MSG': instance.err_MSG,
      'listOfAllScreensDisplay': instance.listOfAllScreensDisplay,
    };
