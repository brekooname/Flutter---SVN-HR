import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/notification_list_response.dart';

part 'notification_list_base_response.g.dart';

@JsonSerializable(nullable: false)
class NotificationListBaseResponse{

  NotificationListBaseResponse();


  factory NotificationListBaseResponse.fromJson(Map<String, dynamic> json) => _$NotificationListBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$NotificationListBaseResponseToJson(this);

  @JsonKey(name: 'response')
  String? _response;

  @JsonKey(name: 'listOfAllNotifications')
  List<NotificationListResponse>? _listOfAllNotifications;

  @JsonKey(name: 'err_MSG')
  String? _err_MSG;

  String get response => _response!;

  set response(String value) {
    _response = value;
  }


  List<NotificationListResponse> get listOfAllNotifications =>
      _listOfAllNotifications!;

  set listOfAllNotifications(List<NotificationListResponse> value) {
    _listOfAllNotifications = value;
  }

  String get err_MSG => _err_MSG!;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}