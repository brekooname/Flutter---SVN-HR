import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/notification_list_response.dart';
import 'package:sven_hr/models/response/notifications_object_response.dart';
import 'package:sven_hr/models/response/vacation_type_response.dart';

part 'notifications_object_base_response.g.dart';

@JsonSerializable(nullable: false)
class NotificationObjectBaseResponse{

  NotificationObjectBaseResponse();


  factory NotificationObjectBaseResponse.fromJson(Map<String, dynamic> json) => _$NotificationObjectBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$NotificationObjectBaseResponseToJson(this);

  @JsonKey(name: 'response')
  String _response;

  @JsonKey(name: 'notificationObject')
  NotificationObjectResponse _notificationObject;

  @JsonKey(name: 'err_MSG')
  String _err_MSG;

  String get response => _response;

  set response(String value) {
    _response = value;
  }

  NotificationObjectResponse get notificationObject => _notificationObject;

  set notificationObject(NotificationObjectResponse value) {
    _notificationObject = value;
  }

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}