import 'package:json_annotation/json_annotation.dart';

part 'vacation_type_response.g.dart';

@JsonSerializable(nullable: false)
class VacationTypeResponse{

  VacationTypeResponse();

  factory VacationTypeResponse.fromJson(Map<String, dynamic> json) => _$VacationTypeResponseFromJson(json);


  Map<String, dynamic> toJson() => _$VacationTypeResponseToJson(this);


  @JsonKey(name: 'name')
  String _name;

  @JsonKey(name: 'approval_flg')
  String _approval_flg;

  @JsonKey(name: 'createddate')
  String _createddate;
  @JsonKey(name: 'balance_sign')
  String _balance_sign;

  @JsonKey(name: 'balance_sign_displayValue')
  String _balance_sign_displayValue;

  @JsonKey(name: 'balance_sign_code')
  String _balance_sign_code;

  @JsonKey(name: 'active_flg')
  String _active_flg;

  @JsonKey(name: 'updatedby')
  String _updatedby;

  @JsonKey(name: 'row_id')
  String _row_id;


  @JsonKey(name: 'permission_method')
  String _permission_method;


  @JsonKey(name: 'description')
  String _description;


  @JsonKey(name: 'createdby')
  String _createdby;


  @JsonKey(name: 'updatedate')
  String _updatedate;


  @JsonKey(name: 'default_balance')
  int _default_balance;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get approval_flg => _approval_flg;

  set approval_flg(String value) {
    _approval_flg = value;
  }

  int get default_balance => _default_balance;

  set default_balance(int value) {
    _default_balance = value;
  }

  String get updatedate => _updatedate;

  set updatedate(String value) {
    _updatedate = value;
  }

  String get createdby => _createdby;

  set createdby(String value) {
    _createdby = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get permission_method => _permission_method;

  set permission_method(String value) {
    _permission_method = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  String get updatedby => _updatedby;

  set updatedby(String value) {
    _updatedby = value;
  }

  String get active_flg => _active_flg;

  set active_flg(String value) {
    _active_flg = value;
  }

  String get balance_sign_code => _balance_sign_code;

  set balance_sign_code(String value) {
    _balance_sign_code = value;
  }

  String get balance_sign_displayValue => _balance_sign_displayValue;

  set balance_sign_displayValue(String value) {
    _balance_sign_displayValue = value;
  }

  String get balance_sign => _balance_sign;

  set balance_sign(String value) {
    _balance_sign = value;
  }

  String get createddate => _createddate;

  set createddate(String value) {
    _createddate = value;
  }
}