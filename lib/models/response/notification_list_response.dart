import 'package:json_annotation/json_annotation.dart';

part 'notification_list_response.g.dart';

@JsonSerializable(nullable: false)
class NotificationListResponse{

  NotificationListResponse();


  factory NotificationListResponse.fromJson(Map<String, dynamic> json) => _$NotificationListResponseFromJson(json);


  Map<String, dynamic> toJson() => _$NotificationListResponseToJson(this);

  @JsonKey(name: 'notificationId')
  String? _notificationId;

  @JsonKey(name: 'approvalInboxId')
  String? _approvalInboxId;

  @JsonKey(name: 'requestedDate')
  String? _requestedDate;


  @JsonKey(name: 'name')
  String? _name;

  @JsonKey(name: 'type')
  String? _type;

  @JsonKey(name: 'requestedBy')
  String? _requestedBy;

  String get notificationId => _notificationId!;

  set notificationId(String value) {
    _notificationId = value;
  }

  String get approvalInboxId => _approvalInboxId!;

  set approvalInboxId(String value) {
    _approvalInboxId = value;
  }

  String get requestedDate => _requestedDate!;

  set requestedDate(String value) {
    _requestedDate = value;
  }

  String get name => _name!;

  set name(String value) {
    _name = value;
  }

  String get type => _type!;

  set type(String value) {
    _type = value;
  }

  String get requestedBy => _requestedBy!;

  set requestedBy(String value) {
    _requestedBy = value;
  }
}