// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationListResponse _$NotificationListResponseFromJson(
    Map<String, dynamic> json) {
  return NotificationListResponse()
    ..notificationId = json['notificationId'] as String? ?? 'default_notificationId'
    ..approvalInboxId = json['approvalInboxId'] as String? ?? 'default_approvalInboxId'
    ..requestedDate = json['requestedDate'] as String? ?? 'default_requestedDate'
    ..name = json['name'] as String? ?? 'default_name'
    ..type = json['type'] as String? ?? 'default_type'
    ..requestedBy = json['requestedBy'] as String? ?? 'default_requestedBy';
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
