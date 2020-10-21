import 'package:json_annotation/json_annotation.dart';

part 'approval_inbox_list_response.g.dart';

@JsonSerializable(nullable: false)
class ApprovalInboxListResponse {

  ApprovalInboxListResponse();

  factory ApprovalInboxListResponse.fromJson(Map<String, dynamic> json) =>
      _$ApprovalInboxListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalInboxListResponseToJson(this);

  @JsonKey(name: 'request_response')
  String _request_response;

  @JsonKey(name: 'request_response_code')
  String _request_response_code;

  @JsonKey(name: 'request_response_displayValue')
  String _request_response_displayValue;

  @JsonKey(name: 'updatedby')
  String _updatedby;

  @JsonKey(name: 'createdby')
  String _createdby;

  @JsonKey(name: 'createddate')
  String _createddate;

  @JsonKey(name: 'object_type')
  String _object_type;

  @JsonKey(name: 'object_row_id')
  String _object_row_id;

  @JsonKey(name: 'approval_request_date')
  String _approval_request_date;

  @JsonKey(name: 'incharge_usr')
  String _incharge_usr;

  @JsonKey(name: 'updateddate')
  String _updateddate;

  @JsonKey(name: 'row_id')
  String _row_id;

  @JsonKey(name: 'approval_desc')
  String _approval_desc;

  @JsonKey(name: 'request_viewed')
  String _request_viewed;

  @JsonKey(name: 'response_notes')
  String _response_notes;

  @JsonKey(name: 'core_emp')
  String _core_emp;

  @JsonKey(name: 'core_emp_name')
  String _core_emp_name;

  @JsonKey(name: 'title_name')
  String _title_name;

  String get request_response => _request_response;

  set request_response(String value) {
    _request_response = value;
  }

  String get request_response_code => _request_response_code;

  set request_response_code(String value) {
    _request_response_code = value;
  }

  String get title_name => _title_name;

  set title_name(String value) {
    _title_name = value;
  }

  String get core_emp_name => _core_emp_name;

  set core_emp_name(String value) {
    _core_emp_name = value;
  }

  String get core_emp => _core_emp;

  set core_emp(String value) {
    _core_emp = value;
  }

  String get response_notes => _response_notes;

  set response_notes(String value) {
    _response_notes = value;
  }

  String get request_viewed => _request_viewed;

  set request_viewed(String value) {
    _request_viewed = value;
  }

  String get approval_desc => _approval_desc;

  set approval_desc(String value) {
    _approval_desc = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  String get updateddate => _updateddate;

  set updateddate(String value) {
    _updateddate = value;
  }

  String get incharge_usr => _incharge_usr;

  set incharge_usr(String value) {
    _incharge_usr = value;
  }

  String get approval_request_date => _approval_request_date;

  set approval_request_date(String value) {
    _approval_request_date = value;
  }

  String get object_row_id => _object_row_id;

  set object_row_id(String value) {
    _object_row_id = value;
  }

  String get object_type => _object_type;

  set object_type(String value) {
    _object_type = value;
  }

  String get createddate => _createddate;

  set createddate(String value) {
    _createddate = value;
  }

  String get createdby => _createdby;

  set createdby(String value) {
    _createdby = value;
  }

  String get updatedby => _updatedby;

  set updatedby(String value) {
    _updatedby = value;
  }

  String get request_response_displayValue => _request_response_displayValue;

  set request_response_displayValue(String value) {
    _request_response_displayValue = value;
  }
}
