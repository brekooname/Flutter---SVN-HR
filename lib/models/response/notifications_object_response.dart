import 'package:json_annotation/json_annotation.dart';

part 'notifications_object_response.g.dart';

@JsonSerializable(nullable: false)
class NotificationObjectResponse{

  NotificationObjectResponse();

  factory NotificationObjectResponse.fromJson(Map<String, dynamic> json) => _$NotificationObjectResponseFromJson(json);


  Map<String, dynamic> toJson() => _$NotificationObjectResponseToJson(this);

  @JsonKey(name: 'notification_date')
  String? _notification_date='';

  @JsonKey(name: 'object_type')
  String? _object_type='';

  @JsonKey(name: 'row_id')
  String? _row_id='';

  @JsonKey(name: 'action_user_id')
  String? _action_user_id='';

  @JsonKey(name: 'action_user_name')
  String? _action_user_name='';

  @JsonKey(name: 'target_user_id')
  String? _target_user_id='';

  @JsonKey(name: 'issue_date')
  String? _issue_date='';

  @JsonKey(name: 'reason')
  String? _reason='';

  @JsonKey(name: 'closed_flg')
  String? _closed_flg='';

  @JsonKey(name: 'type')
  String? _type='';

  @JsonKey(name: 'requestStatus')
  String? _requestStatus='';

  @JsonKey(name: 'employeeName')
  String? _employeeName='';

  @JsonKey(name: 'employmentClass')
  String? _employmentClass='';

  @JsonKey(name: 'employeeNumber')
  String? _employeeNumber='';

  @JsonKey(name: 'message')
  String? _message='';

  String get message => _message!;

  set message(String value) {
    _message = value;
  }

  String get notification_date => _notification_date!;

  set notification_date(String value) {
    _notification_date = value;
  }

  String get object_type => _object_type!;

  set object_type(String value) {
    _object_type = value;
  }

  String get row_id => _row_id!;

  set row_id(String value) {
    _row_id = value;
  }

  String get action_user_id => _action_user_id!;

  set action_user_id(String value) {
    _action_user_id = value;
  }

  String get action_user_name => _action_user_name!;

  set action_user_name(String value) {
    _action_user_name = value;
  }

  String get target_user_id => _target_user_id!;

  set target_user_id(String value) {
    _target_user_id = value;
  }

  String get issue_date => _issue_date!;

  set issue_date(String value) {
    _issue_date = value;
  }

  String get reason => _reason!;

  set reason(String value) {
    _reason = value;
  }

  String get closed_flg => _closed_flg!;

  set closed_flg(String value) {
    _closed_flg = value;
  }

  String get type => _type!;

  set type(String value) {
    _type = value;
  }

  String get requestStatus => _requestStatus!;

  set requestStatus(String value) {
    _requestStatus = value;
  }

  String get employeeName => _employeeName!;

  set employeeName(String value) {
    _employeeName = value;
  }

  String get employmentClass => _employmentClass!;

  set employmentClass(String value) {
    _employmentClass = value;
  }

  String get employeeNumber => _employeeNumber!;

  set employeeNumber(String value) {
    _employeeNumber = value;
  }
}