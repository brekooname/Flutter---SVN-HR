// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_clock_check_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewClockCheckRequest _$NewClockCheckRequestFromJson(Map<String, dynamic> json) {
  return NewClockCheckRequest(
    tokenID: json['tokenID'] as String,
    clockTime: json['clockTime'] as num,
    clockType: json['clockType'] as String,
  );
}

Map<String, dynamic> _$NewClockCheckRequestToJson(
        NewClockCheckRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'clockTime': instance.clockTime,
      'clockType': instance.clockType,
    };
