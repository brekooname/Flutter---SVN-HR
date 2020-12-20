// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalList _$ApprovalListFromJson(Map<String, dynamic> json) {
  return ApprovalList()
    ..employeeName = json['employeeName'] as String
    ..employeeId = json['employeeId'] as String;
}

Map<String, dynamic> _$ApprovalListToJson(ApprovalList instance) =>
    <String, dynamic>{
      'employeeName': instance.employeeName,
      'employeeId': instance.employeeId,
    };
