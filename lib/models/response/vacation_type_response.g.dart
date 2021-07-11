// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacationTypeResponse _$VacationTypeResponseFromJson(Map<String, dynamic> json) {
  return VacationTypeResponse()
    ..name = json['name'] as String
    ..approval_flg = json['approval_flg'] as String
    ..default_balance = json['default_balance'] as num
    ..updatedate = json['updatedate'] as String
    ..createdby = json['createdby'] as String
    ..description = json['description'] as String
    ..permission_method = json['permission_method'] as String
    ..row_id = json['row_id'] as String
    ..updatedby = json['updatedby'] as String
    ..active_flg = json['active_flg'] as String
    ..balance_sign_code = json['balance_sign_code'] as String
    ..balance_sign_displayValue = json['balance_sign_displayValue'] as String
    ..balance_sign = json['balance_sign'] as String
    ..createddate = json['createddate'] as String;
}

Map<String, dynamic> _$VacationTypeResponseToJson(
        VacationTypeResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'approval_flg': instance.approval_flg,
      'default_balance': instance.default_balance,
      'updatedate': instance.updatedate,
      'createdby': instance.createdby,
      'description': instance.description,
      'permission_method': instance.permission_method,
      'row_id': instance.row_id,
      'updatedby': instance.updatedby,
      'active_flg': instance.active_flg,
      'balance_sign_code': instance.balance_sign_code,
      'balance_sign_displayValue': instance.balance_sign_displayValue,
      'balance_sign': instance.balance_sign,
      'createddate': instance.createddate,
    };
