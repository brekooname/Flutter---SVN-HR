import 'package:json_annotation/json_annotation.dart';


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

// Icon getRightIcon() {
//   if (rec_type != null && rec_type != null) {
//     if (rec_type.compareTo(Const.RECORD_TYPE_OUT) == 0) {
//       return Icon(
//         Icons.arrow_circle_up_outlined,
//         color: AppTheme.red,
//       );
//     } else if (rec_type.compareTo(Const.RECORD_TYPE_IN) == 0) {
//       return Icon(
//         Icons.arrow_circle_down_outlined,
//         color: AppTheme.green,
//       );
//     }
//   }
// }
//
// Color getRightColor() {
//   if (rec_type.compareTo(Const.RECORD_TYPE_IN) == 0) {
//     return AppTheme.green;
//   } else if (rec_type.compareTo(Const.RECORD_TYPE_OUT) == 0) {
//     return AppTheme.red;
//   }
// }
}
