
import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/salary.dart';

part 'employee.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class Employee{

  Employee();

  @JsonKey(name: 'tokenId')
  String? _tokenId;

  @JsonKey(name: 'employee_number')
  String? _employee_number;

  @JsonKey(name: 'employee_id')
  String? _employee_id;

  @JsonKey(name: 'position')
  String? _position;

  @JsonKey(name: 'department')
  String? _department;

  @JsonKey(name: 'email')
  String? _email;

  @JsonKey(name: 'telephoneNumber')
  String? _telephoneNumber;

  @JsonKey(name: 'employee_profile_pic_link')
  String? _employee_profile_pic_link;

  @JsonKey(name: 'err_MSG')
  String? _err_MSG;

  @JsonKey(name: 'salary')
  Salary? _salary;

  @JsonKey(name: 'employeeName')
  String? _employeeName;

  @JsonKey(name: 'reportingManager')
  String? _reportingManager;

  String get err_MSG => _err_MSG!;

  set err_MSG(String value) {
    _err_MSG = value;
  }

  String get employee_profile_pic_link => _employee_profile_pic_link!;

  set employee_profile_pic_link(String value) {
    _employee_profile_pic_link = value;
  }

  String get telephoneNumber => _telephoneNumber!;

  set telephoneNumber(String value) {
    _telephoneNumber = value;
  }

  String get email => _email!;

  set email(String value) {
    _email = value;
  }

  String get department => _department!;

  set department(String value) {
    _department = value;
  }

  String get position => _position!;

  set position(String value) {
    _position = value;
  }

  String get employee_id => _employee_id!;

  set employee_id(String value) {
    _employee_id = value;
  }

  String get employee_number => _employee_number!;

  set employee_number(String value) {
    _employee_number = value;
  }

  String get tokenId => _tokenId!;

  set tokenId(String value) {
    _tokenId = value;
  }


  Salary get salary => _salary!;

  set salary(Salary value) {
    _salary = value;
  }


  String get employeeName => _employeeName!;

  set employeeName(String value) {
    _employeeName = value;
  }

  String get reportingManager => _reportingManager!;

  set reportingManager(String value) {
    _reportingManager = value;
  }
  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);


  Map<String, dynamic> toJson() => _$EmployeeToJson(this);


}