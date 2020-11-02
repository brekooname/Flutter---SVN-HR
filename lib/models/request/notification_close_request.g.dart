// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_close_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationCloseRequest _$NotificationCloseRequestFromJson(
    Map<String, dynamic> json) {
  return NotificationCloseRequest(
    tokenId: json['tokenId'] as String,
    notifId: json['notifId'] as String,
  );
}

Map<String, dynamic> _$NotificationCloseRequestToJson(
        NotificationCloseRequest instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'notifId': instance.notifId,
    };
