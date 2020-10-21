// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_vacation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewVacationRequest _$NewVacationRequestFromJson(Map<String, dynamic> json) {
  return NewVacationRequest()
    ..vacation_locaction = json['vacation_locaction'] as String
    ..end_date = json['end_date'] as String
    ..start_date = json['start_date'] as String
    ..planned_flg = json['planned_flg'] as String
    ..vacation_id = json['vacation_id'] as String
    ..notes = json['notes'] as String;
}

Map<String, dynamic> _$NewVacationRequestToJson(NewVacationRequest instance) =>
    <String, dynamic>{
      'vacation_locaction': instance.vacation_locaction,
      'end_date': instance.end_date,
      'start_date': instance.start_date,
      'planned_flg': instance.planned_flg,
      'vacation_id': instance.vacation_id,
      'notes': instance.notes,
    };
