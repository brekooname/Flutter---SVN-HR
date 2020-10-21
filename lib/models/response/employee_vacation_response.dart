import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/employee_vacation_response.dart';

part 'employee_vacation_response.g.dart';

@JsonSerializable(nullable: false)
class EmployeeVacationResponse{

  EmployeeVacationResponse();

  factory EmployeeVacationResponse.fromJson(Map<String, dynamic> json) => _$EmployeeVacationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeVacationResponseToJson(this);

  @JsonKey(name: 'effective_date')
  String _effective_date;

  @JsonKey(name: 'last_vacation_date')
  String _last_vacation_date;

  @JsonKey(name: 'rec_attachment')
  String _rec_attachment;

  @JsonKey(name: 'annual_balance')
  double _annual_balance;

  @JsonKey(name: 'createddate')
  String _createddate;


  @JsonKey(name: 'updatedby')
  String _updatedby;

  @JsonKey(name: 'vacation_type')
  String _vacation_type;

  @JsonKey(name: 'vacation_type_name')
  String _vacation_type_name;

  @JsonKey(name: 'updatedate')
  String _updatedate;

  @JsonKey(name: 'permission_method')
  String _permission_method;

  @JsonKey(name: 'row_id')
  String _row_id;

  @JsonKey(name: 'consumed_balance')
  double _consumed_balance;

  @JsonKey(name: 'vacation_detail_id')
  String _vacation_detail_id;

  @JsonKey(name: 'active_flg')
  String _active_flg;

  @JsonKey(name: 'createdby')
  String _createdby;

  @JsonKey(name: 'previous_balance')
  double _previous_balance;


  @JsonKey(name: 'par_row_id')
  String _par_row_id;

  @JsonKey(name: 'remaining_balance')
  double _remaining_balance;

  @JsonKey(name: 'due_balance')
  double _due_balance;


  double get due_balance => _due_balance;

  set due_balance(double value) {
    _due_balance = value;
  }

  String get effective_date => _effective_date;

  set effective_date(String value) {
    _effective_date = value;
  }

  String get last_vacation_date => _last_vacation_date;

  set last_vacation_date(String value) {
    _last_vacation_date = value;
  }

  String get rec_attachment => _rec_attachment;

  set rec_attachment(String value) {
    _rec_attachment = value;
  }

  double get annual_balance => _annual_balance;

  set annual_balance(double value) {
    _annual_balance = value;
  }

  String get createddate => _createddate;

  set createddate(String value) {
    _createddate = value;
  }

  String get updatedby => _updatedby;

  set updatedby(String value) {
    _updatedby = value;
  }

  String get vacation_type => _vacation_type;

  set vacation_type(String value) {
    _vacation_type = value;
  }

  String get vacation_type_name => _vacation_type_name;

  set vacation_type_name(String value) {
    _vacation_type_name = value;
  }

  String get updatedate => _updatedate;

  set updatedate(String value) {
    _updatedate = value;
  }

  String get permission_method => _permission_method;

  set permission_method(String value) {
    _permission_method = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  double get consumed_balance => _consumed_balance;

  set consumed_balance(double value) {
    _consumed_balance = value;
  }

  String get vacation_detail_id => _vacation_detail_id;

  set vacation_detail_id(String value) {
    _vacation_detail_id = value;
  }

  String get active_flg => _active_flg;

  set active_flg(String value) {
    _active_flg = value;
  }

  String get createdby => _createdby;

  set createdby(String value) {
    _createdby = value;
  }

  double get previous_balance => _previous_balance;

  set previous_balance(double value) {
    _previous_balance = value;
  }

  String get par_row_id => _par_row_id;

  set par_row_id(String value) {
    _par_row_id = value;
  }

  double get remaining_balance => _remaining_balance;

  set remaining_balance(double value) {
    _remaining_balance = value;
  }
}