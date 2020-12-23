// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_broadcaste_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageBroadcasteResponse _$MessageBroadcasteResponseFromJson(
    Map<String, dynamic> json) {
  return MessageBroadcasteResponse()
    ..message_text = json['message_text'] as String
    ..message_color = json['message_color'] as String
    ..message_severity_display_value =
        json['message_severity_display_value'] as String
    ..message_severity = json['message_severity'] as String
    ..row_id = json['row_id'] as String
    ..message_title = json['message_title'] as String;
}

Map<String, dynamic> _$MessageBroadcasteResponseToJson(
        MessageBroadcasteResponse instance) =>
    <String, dynamic>{
      'message_text': instance.message_text,
      'message_color': instance.message_color,
      'message_severity_display_value': instance.message_severity_display_value,
      'message_severity': instance.message_severity,
      'row_id': instance.row_id,
      'message_title': instance.message_title,
    };
