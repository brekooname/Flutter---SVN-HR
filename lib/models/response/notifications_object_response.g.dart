// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_object_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationObjectResponse _$NotificationObjectResponseFromJson(
    Map<String, dynamic> json) {
  return NotificationObjectResponse()
    ..message = json['message'] as String? ?? 'Default Message'
    ..notification_date = json['notification_date'] as String? ?? 'Default Date'
    ..object_type = json['object_type'] as String? ?? 'Default Object Type'
    ..row_id = json['row_id'] as String? ?? 'Default Row ID'
    ..action_user_id = json['action_user_id'] as String? ?? 'Default Action User ID'
    ..action_user_name = json['action_user_name'] as String? ?? 'Default Action User Name'
    ..target_user_id = json['target_user_id'] as String? ?? 'Default Target User ID'
    ..issue_date = json['issue_date'] as String? ?? 'Default Issue Date'
    ..reason = json['reason'] as String? ?? 'Default Reason'
    ..closed_flg = json['closed_flg'] as String? ?? 'Default Closed Flag'
    ..type = json['type'] as String? ?? 'Default Type'
    ..requestStatus = json['requestStatus'] as String? ?? 'Default Request Status'
    ..employeeName = json['employeeName'] as String? ?? 'Default Employee Name'
    ..employmentClass = json['employmentClass'] as String? ?? 'Default Employment Class'
    ..employeeNumber = json['employeeNumber'] as String? ?? 'Default Employee Number';
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
