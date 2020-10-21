// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee()
    ..err_MSG = json['err_MSG'] as String
    ..employee_profile_pic_link = json['employee_profile_pic_link'] as String
    ..telephoneNumber = json['telephoneNumber'] as String
    ..email = json['email'] as String
    ..department = json['department'] as String
    ..position = json['position'] as String
    ..employee_id = json['employee_id'] as String
    ..employee_number = json['employee_number'] as String
    ..tokenId = json['tokenId'] as String
    ..salary = Salary.fromJson(json['salary'] as Map<String, dynamic>)
    ..employeeName = json['employeeName'] as String
    ..reportingManager = json['reportingManager'] as String;
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'err_MSG': instance.err_MSG,
      'employee_profile_pic_link': instance.employee_profile_pic_link,
      'telephoneNumber': instance.telephoneNumber,
      'email': instance.email,
      'department': instance.department,
      'position': instance.position,
      'employee_id': instance.employee_id,
      'employee_number': instance.employee_number,
      'tokenId': instance.tokenId,
      'salary': instance.salary.toJson(),
      'employeeName': instance.employeeName,
      'reportingManager': instance.reportingManager,
    };
