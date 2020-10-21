// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_screen_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileScreenBaseResponse _$ProfileScreenBaseResponseFromJson(
    Map<String, dynamic> json) {
  return ProfileScreenBaseResponse()
    ..response = json['response'] as String
    ..err_MSG = json['err_MSG'] as String
    ..listOfAllScreensDisplay = (json['listOfAllScreensDisplay'] as List)
        .map((e) => ProfileScreenResponse.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ProfileScreenBaseResponseToJson(
        ProfileScreenBaseResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'err_MSG': instance.err_MSG,
      'listOfAllScreensDisplay': instance.listOfAllScreensDisplay,
    };
