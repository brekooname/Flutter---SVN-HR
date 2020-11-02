// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_object_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationObjectBaseResponse _$NotificationObjectBaseResponseFromJson(
    Map<String, dynamic> json) {
  return NotificationObjectBaseResponse()
    ..response = json['response'] as String
    ..notificationObject = NotificationObjectResponse.fromJson(
        json['notificationObject'] as Map<String, dynamic>)
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$NotificationObjectBaseResponseToJson(
        NotificationObjectBaseResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'notificationObject': instance.notificationObject,
      'err_MSG': instance.err_MSG,
    };
