// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_list_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationListBaseResponse _$NotificationListBaseResponseFromJson(
    Map<String, dynamic> json) {
  return NotificationListBaseResponse()
    ..response = json['response'] as String
    ..listOfAllNotifications = (json['listOfAllNotifications'] as List)
        .map(
            (e) => NotificationListResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$NotificationListBaseResponseToJson(
        NotificationListBaseResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'listOfAllNotifications': instance.listOfAllNotifications,
      'err_MSG': instance.err_MSG,
    };
