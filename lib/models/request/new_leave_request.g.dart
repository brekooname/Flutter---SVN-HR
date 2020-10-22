// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_leave_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewLeaveRequest _$NewLeaveRequestFromJson(Map<String, dynamic> json) {
  return NewLeaveRequest()
    ..leave_id = json['leave_id'] as String
    ..start_date = json['start_date'] as String
    ..end_date = json['end_date'] as String
    ..notes = json['notes'] as String;
}

Map<String, dynamic> _$NewLeaveRequestToJson(NewLeaveRequest instance) =>
    <String, dynamic>{
      'leave_id': instance.leave_id,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'notes': instance.notes,
    };
