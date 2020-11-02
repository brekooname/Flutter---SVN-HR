// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastCheckResponse _$LastCheckResponseFromJson(Map<String, dynamic> json) {
  return LastCheckResponse()
    ..rec_type = json['rec_type'] as String
    ..emp_clock_id = json['emp_clock_id'] as String
    ..actual_time = json['actual_time'] as num
    ..createdby = json['createdby'] as String
    ..rec_date = json['rec_date'] as String
    ..row_id = json['row_id'] as String
    ..source = json['source'] as String
    ..permission_method = json['permission_method'] as String
    ..createddate = json['createddate'] as String
    ..updated_flg = json['updated_flg'] as String
    ..status = json['status'] as String
    ..clock_id = json['clock_id'] as String
    ..updatedate = json['updatedate'] as String
    ..rec_time = json['rec_time'] as num
    ..updatedby = json['updatedby'] as String;
}

Map<String, dynamic> _$LastCheckResponseToJson(LastCheckResponse instance) =>
    <String, dynamic>{
      'rec_type': instance.rec_type,
      'emp_clock_id': instance.emp_clock_id,
      'actual_time': instance.actual_time,
      'createdby': instance.createdby,
      'rec_date': instance.rec_date,
      'row_id': instance.row_id,
      'source': instance.source,
      'permission_method': instance.permission_method,
      'createddate': instance.createddate,
      'updated_flg': instance.updated_flg,
      'status': instance.status,
      'clock_id': instance.clock_id,
      'updatedate': instance.updatedate,
      'rec_time': instance.rec_time,
      'updatedby': instance.updatedby,
    };
