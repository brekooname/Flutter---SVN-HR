import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/message_broadcaste_response.dart';


part 'message_broadcaste_base_response.g.dart';

@JsonSerializable(nullable: false)
class MessageBroadcasteBaseResponse{

  String?_response;

  String?_err_MSG;

  List<MessageBroadcasteResponse>? _messageList;


  MessageBroadcasteBaseResponse();

  factory MessageBroadcasteBaseResponse.fromJson(Map<String, dynamic> json) => _$MessageBroadcasteBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$MessageBroadcasteBaseResponseToJson(this);


  List<MessageBroadcasteResponse> get messageList => _messageList!;

  set messageList(List<MessageBroadcasteResponse> value) {
    _messageList = value;
  }

  String get err_MSG => _err_MSG!;

  set err_MSG(String value) {
    _err_MSG = value;
  }

  String get response => _response!;

  set response(String value) {
    _response = value;
  }
}