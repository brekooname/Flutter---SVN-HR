// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  print('emp - from JSON 1');

  return Employee()
    ..err_MSG = json['err_MSG'] as String? ?? 'default_err_msg'
    ..employee_profile_pic_link = json['employee_profile_pic_link'] as String? ?? 'default_pic_link'
    ..telephoneNumber = json['telephoneNumber'] as String? ?? 'default_telephone'
    ..email = json['email'] as String? ?? 'default_email'
    ..department = json['department'] as String? ?? 'default_department'
    ..position = json['position'] as String? ?? 'default_position'
    ..employee_id = json['employee_id'] as String? ?? 'default_employee_id'
    ..employee_number = json['employee_number'] as String? ?? 'default_employee_number'
    ..tokenId = json['tokenId'] as String? ?? 'default_tokenId'
    ..salary = (json['salary'] == null ? null : Salary.fromJson(json['salary'] as Map<String, dynamic>))!
    ..employeeName = json['employeeName'] as String? ?? 'default_employeeName'
    ..reportingManager = json['reportingManager'] as String? ?? 'default_reportingManager';
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
