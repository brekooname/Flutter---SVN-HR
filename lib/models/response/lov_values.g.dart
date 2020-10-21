// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lov_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LovValues _$LovValuesFromJson(Map<String, dynamic> json) {
  return LovValues()
    ..par_row_id = json['par_row_id'] as String
    ..code = json['code'] as String
    ..row_id = json['row_id'] as String
    ..dispaly_value = json['dispaly_value'] as String;
}

Map<String, dynamic> _$LovValuesToJson(LovValues instance) => <String, dynamic>{
      'par_row_id': instance.par_row_id,
      'code': instance.code,
      'row_id': instance.row_id,
      'dispaly_value': instance.dispaly_value,
    };
