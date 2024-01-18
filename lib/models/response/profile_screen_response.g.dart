// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_screen_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileScreenResponse _$ProfileScreenResponseFromJson(Map<String, dynamic> json) {
  return ProfileScreenResponse()
    ..displayFlag = json['displayFlag'] as bool? ?? false
    ..screenName = json['screenName'] as String? ?? 'default_screenName';
}


Map<String, dynamic> _$ProfileScreenResponseToJson(
        ProfileScreenResponse instance) =>
    <String, dynamic>{
      'displayFlag': instance.displayFlag,
      'screenName': instance.screenName,
    };
