import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'vacation_transaction_response.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class VacationTransactionResponse{

  VacationTransactionResponse();

  @JsonKey(name: 'createddate')
  String _createddate;

  @JsonKey(name: 'row_id')
  String _row_id;

  @JsonKey(name: 'actual_end')
  String _actual_end;

  @JsonKey(name: 'approve_date')
  String _approve_date;

  @JsonKey(name: 'remark')
  String _remark;

  @JsonKey(name: 'request_date')
  String _request_date;

  @JsonKey(name: 'holiday_days')
  int _holiday_days;

  @JsonKey(name: 'updatedate')
  String _updatedate;

  @JsonKey(name: 'vacation_id')
  String _vacation_id;

  @JsonKey(name: 'vacation_Name')
  String _vacation_Name;

  @JsonKey(name: 'trans_reason')
  String _trans_reason;

  @JsonKey(name: 'trans_reason_code')
  String _trans_reason_code;

  @JsonKey(name: 'trans_reason_displayValue')
  String _trans_reason_displayValue;

  @JsonKey(name: 'actual_start')
  String _actual_start;

  @JsonKey(name: 'employee_id')
  String _employee_id;

  @JsonKey(name: 'paid_days')
  int _paid_days;

  @JsonKey(name: 'unpaid_days')
  int _unpaid_days;

  @JsonKey(name: 'linked_vacation_id')
  String _linked_vacation_id;

  @JsonKey(name: 'trans_period')
  int _trans_period;

  @JsonKey(name: 'planned_flg')
  String _planned_flg;

  @JsonKey(name: 'request_status')
  String _request_status;

  @JsonKey(name: 'request_status_code')
  String _request_status_code;

  @JsonKey(name: 'request_status_displayValue')
  String _request_status_displayValue;

  @JsonKey(name: 'start_date')
  String _start_date;

  @JsonKey(name: 'actual_period')
  int _actual_period;

  @JsonKey(name: 'new_balance')
  double _new_balance;

  @JsonKey(name: 'previous_balance')
  double _previous_balance;

  @JsonKey(name: 'updatedby')
  String _updatedby;

  @JsonKey(name: 'trans_status')
  String _trans_status;

  @JsonKey(name: 'trans_status_code')
  String _trans_status_code;

  @JsonKey(name: 'trans_status_displayValue')
  String _trans_status_displayValue;

  @JsonKey(name: 'permission_method')
  String _permission_method;

  @JsonKey(name: 'end_date')
  String _end_date;

  @JsonKey(name: 'req_channel')
  String _req_channel;

  @JsonKey(name: 'req_channel_code')
  String _req_channel_code;

  @JsonKey(name: 'req_channel_displayValue')
  String _req_channel_displayValue;

  @JsonKey(name: 'createdby')
  String _createdby;

  @JsonKey(name: 'subsititude_emp')
  String _subsititude_emp;


  @JsonKey(name: 'vacation_location')
  String _vacation_location;

  @JsonKey(name: 'vacation_location_code')
  String _vacation_location_code;

  @JsonKey(name: 'vacation_location_displayValue')
  String _vacation_location_displayValue;


  String get vacation_location => _vacation_location;

  set vacation_location(String value) {
    _vacation_location = value;
  }

  String get createddate => _createddate;

  set createddate(String value) {
    _createddate = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  String get actual_end => _actual_end;

  set actual_end(String value) {
    _actual_end = value;
  }

  String get approve_date => _approve_date;

  set approve_date(String value) {
    _approve_date = value;
  }

  String get remark => _remark;

  set remark(String value) {
    _remark = value;
  }

  String get request_date => _request_date;

  set request_date(String value) {
    _request_date = value;
  }

  int get holiday_days => _holiday_days;

  set holiday_days(int value) {
    _holiday_days = value;
  }

  String get updatedate => _updatedate;

  set updatedate(String value) {
    _updatedate = value;
  }

  String get vacation_id => _vacation_id;

  set vacation_id(String value) {
    _vacation_id = value;
  }

  String get vacation_Name => _vacation_Name;

  set vacation_Name(String value) {
    _vacation_Name = value;
  }

  String get trans_reason => _trans_reason;

  set trans_reason(String value) {
    _trans_reason = value;
  }

  String get trans_reason_code => _trans_reason_code;

  set trans_reason_code(String value) {
    _trans_reason_code = value;
  }

  String get trans_reason_displayValue => _trans_reason_displayValue;

  set trans_reason_displayValue(String value) {
    _trans_reason_displayValue = value;
  }

  String get actual_start => _actual_start;

  set actual_start(String value) {
    _actual_start = value;
  }

  String get employee_id => _employee_id;

  set employee_id(String value) {
    _employee_id = value;
  }

  int get paid_days => _paid_days;

  set paid_days(int value) {
    _paid_days = value;
  }

  int get unpaid_days => _unpaid_days;

  set unpaid_days(int value) {
    _unpaid_days = value;
  }

  String get linked_vacation_id => _linked_vacation_id;

  set linked_vacation_id(String value) {
    _linked_vacation_id = value;
  }

  int get trans_period => _trans_period;

  set trans_period(int value) {
    _trans_period = value;
  }

  String get planned_flg => _planned_flg;

  set planned_flg(String value) {
    _planned_flg = value;
  }

  String get request_status => _request_status;

  set request_status(String value) {
    _request_status = value;
  }

  String get request_status_code => _request_status_code;

  set request_status_code(String value) {
    _request_status_code = value;
  }

  String get request_status_displayValue => _request_status_displayValue;

  set request_status_displayValue(String value) {
    _request_status_displayValue = value;
  }

  String get subsititude_emp => _subsititude_emp;

  set subsititude_emp(String value) {
    _subsititude_emp = value;
  }

  String get createdby => _createdby;

  set createdby(String value) {
    _createdby = value;
  }

  String get req_channel_displayValue => _req_channel_displayValue;

  set req_channel_displayValue(String value) {
    _req_channel_displayValue = value;
  }

  String get req_channel_code => _req_channel_code;

  set req_channel_code(String value) {
    _req_channel_code = value;
  }

  String get req_channel => _req_channel;

  set req_channel(String value) {
    _req_channel = value;
  }

  String get end_date => _end_date;

  set end_date(String value) {
    _end_date = value;
  }

  String get permission_method => _permission_method;

  set permission_method(String value) {
    _permission_method = value;
  }

  String get trans_status_displayValue => _trans_status_displayValue;

  set trans_status_displayValue(String value) {
    _trans_status_displayValue = value;
  }

  String get trans_status_code => _trans_status_code;

  set trans_status_code(String value) {
    _trans_status_code = value;
  }

  String get trans_status => _trans_status;

  set trans_status(String value) {
    _trans_status = value;
  }

  String get updatedby => _updatedby;

  set updatedby(String value) {
    _updatedby = value;
  }

  double get previous_balance => _previous_balance;

  set previous_balance(double value) {
    _previous_balance = value;
  }

  double get new_balance => _new_balance;

  set new_balance(double value) {
    _new_balance = value;
  }

  int get actual_period => _actual_period;

  set actual_period(int value) {
    _actual_period = value;
  }

  String get start_date => _start_date;

  set start_date(String value) {
    _start_date = value;
  }

  factory VacationTransactionResponse.fromJson(Map<String, dynamic> json) => _$VacationTransactionResponseFromJson(json);


  Map<String, dynamic> toJson() => _$VacationTransactionResponseToJson(this);

  String get vacation_location_code => _vacation_location_code;

  set vacation_location_code(String value) {
    _vacation_location_code = value;
  }

  String get vacation_location_displayValue => _vacation_location_displayValue;

  set vacation_location_displayValue(String value) {
    _vacation_location_displayValue = value;
  }
}