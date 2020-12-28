import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/utilities/constants.dart';
import 'package:sven_hr/utilities/hex_color.dart';


part 'message_broadcaste_response.g.dart';

@JsonSerializable(nullable: false)
class MessageBroadcasteResponse {
  String _message_title;

  String _row_id;

  String _message_severity;

  String _message_severity_display_value;

  String _message_color;

  String _message_text;

  MessageBroadcasteResponse();

  factory MessageBroadcasteResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageBroadcasteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageBroadcasteResponseToJson(this);

  String get message_text => _message_text;

  set message_text(String value) {
    _message_text = value;
  }

  String get message_color => _message_color;

  set message_color(String value) {
    _message_color = value;
  }

  String get message_severity_display_value => _message_severity_display_value;

  set message_severity_display_value(String value) {
    _message_severity_display_value = value;
  }

  String get message_severity => _message_severity;

  set message_severity(String value) {
    _message_severity = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  String get message_title => _message_title;

  set message_title(String value) {
    _message_title = value;
  }

Icon getRightIcon() {
  if (message_severity != null) {
    if (message_severity.compareTo(Const.MESSAGE_SEVERITY_HIGH) == 0) {
      return Icon(
        Icons.notification_important,
        color: Color(HexColor.getColorFromHex(message_color)),
      );
    } else if (message_severity.compareTo(Const.MESSAGE_SEVERITY_MEDUIM) == 0) {
      return Icon(
        Icons.notification_important_outlined,
        color: Color(HexColor.getColorFromHex(message_color)),
      );
    }else if (message_severity.compareTo(Const.MESSAGE_SEVERITY_LOW) == 0) {
      return Icon(
        Icons.low_priority,
        color: Color(HexColor.getColorFromHex(message_color)),
      );
    }
  }
}
//
// Color getRightColor() {
//   if (rec_type.compareTo(Const.RECORD_TYPE_IN) == 0) {
//     return AppTheme.green;
//   } else if (rec_type.compareTo(Const.RECORD_TYPE_OUT) == 0) {
//     return AppTheme.red;
//   }
// }
}
