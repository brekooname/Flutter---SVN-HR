// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_leave_base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewLeaveBaseRequest _$NewLeaveBaseRequestFromJson(Map<String, dynamic> json) {
  return NewLeaveBaseRequest(
    tokenID: json['tokenID'] as String,
    leaveTrans:
        NewLeaveRequest.fromJson(json['leaveTrans'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NewLeaveBaseRequestToJson(
        NewLeaveBaseRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'leaveTrans': instance.leaveTrans,
    };
