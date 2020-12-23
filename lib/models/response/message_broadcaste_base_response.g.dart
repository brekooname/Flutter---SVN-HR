// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_broadcaste_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageBroadcasteBaseResponse _$MessageBroadcasteBaseResponseFromJson(
    Map<String, dynamic> json) {
  return MessageBroadcasteBaseResponse()
    ..messageList = (json['messageList'] as List)
        .map((e) =>
            MessageBroadcasteResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String
    ..response = json['response'] as String;
}

Map<String, dynamic> _$MessageBroadcasteBaseResponseToJson(
        MessageBroadcasteBaseResponse instance) =>
    <String, dynamic>{
      'messageList': instance.messageList,
      'err_MSG': instance.err_MSG,
      'response': instance.response,
    };
