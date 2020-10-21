// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_leave_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewLeaveRequest _$NewLeaveRequestFromJson(Map<String, dynamic> json) {
  return NewLeaveRequest()
    ..notes = json['notes'] as String
    ..end_date = json['end_date'] as String
    ..start_date = json['start_date'] as String
    ..leave_id = json['leave_id'] as String;
}

Map<String, dynamic> _$NewLeaveRequestToJson(NewLeaveRequest instance) =>
    <String, dynamic>{
      'notes': instance.notes,
      'end_date': instance.end_date,
      'start_date': instance.start_date,
      'leave_id': instance.leave_id,
    };
