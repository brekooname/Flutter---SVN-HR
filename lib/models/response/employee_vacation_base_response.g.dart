// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_vacation_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeVacationBaseResponse _$EmployeeVacationBaseResponseFromJson(
    Map<String, dynamic> json) {
  return EmployeeVacationBaseResponse()
    ..response = json['response'] as String
    ..employeeVacations = (json['employeeVacations'] as List)
        .map(
            (e) => EmployeeVacationResponse.fromJson(e as Map<String, dynamic>))
        .toList()
    ..err_MSG = json['err_MSG'] as String;
}

Map<String, dynamic> _$EmployeeVacationBaseResponseToJson(
        EmployeeVacationBaseResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'employeeVacations': instance.employeeVacations,
      'err_MSG': instance.err_MSG,
    };
