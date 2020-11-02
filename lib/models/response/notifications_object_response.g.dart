// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_object_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationObjectResponse _$NotificationObjectResponseFromJson(
    Map<String, dynamic> json) {
  return NotificationObjectResponse()
    ..message = json['message'] as String
    ..notification_date = json['notification_date'] as String
    ..object_type = json['object_type'] as String
    ..row_id = json['row_id'] as String
    ..action_user_id = json['action_user_id'] as String
    ..action_user_name = json['action_user_name'] as String
    ..target_user_id = json['target_user_id'] as String
    ..issue_date = json['issue_date'] as String
    ..reason = json['reason'] as String
    ..closed_flg = json['closed_flg'] as String
    ..type = json['type'] as String
    ..requestStatus = json['requestStatus'] as String
    ..employeeName = json['employeeName'] as String
    ..employmentClass = json['employmentClass'] as String
    ..employeeNumber = json['employeeNumber'] as String;
}

Map<String, dynamic> _$NotificationObjectResponseToJson(
        NotificationObjectResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'notification_date': instance.notification_date,
      'object_type': instance.object_type,
      'row_id': instance.row_id,
      'action_user_id': instance.action_user_id,
      'action_user_name': instance.action_user_name,
      'target_user_id': instance.target_user_id,
      'issue_date': instance.issue_date,
      'reason': instance.reason,
      'closed_flg': instance.closed_flg,
      'type': instance.type,
      'requestStatus': instance.requestStatus,
      'employeeName': instance.employeeName,
      'employmentClass': instance.employmentClass,
      'employeeNumber': instance.employeeNumber,
    };
