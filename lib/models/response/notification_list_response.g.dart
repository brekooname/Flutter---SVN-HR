// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationListResponse _$NotificationListResponseFromJson(
    Map<String, dynamic> json) {
  return NotificationListResponse()
    ..notificationId = json['notificationId'] as String
    ..approvalInboxId = json['approvalInboxId'] as String
    ..requestedDate = json['requestedDate'] as String
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..requestedBy = json['requestedBy'] as String;
}

Map<String, dynamic> _$NotificationListResponseToJson(
        NotificationListResponse instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'approvalInboxId': instance.approvalInboxId,
      'requestedDate': instance.requestedDate,
      'name': instance.name,
      'type': instance.type,
      'requestedBy': instance.requestedBy,
    };
