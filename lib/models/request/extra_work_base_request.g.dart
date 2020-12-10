// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_work_base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraWorkBaseRequest _$ExtraWorkBaseRequestFromJson(Map<String, dynamic> json) {
  return ExtraWorkBaseRequest(
    tokenID: json['tokenID'] as String,
    extraWorkTrans: ExtraWorkRequest.fromJson(
        json['extraWorkTrans'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ExtraWorkBaseRequestToJson(
        ExtraWorkBaseRequest instance) =>
    <String, dynamic>{
      'tokenID': instance.tokenID,
      'extraWorkTrans': instance.extraWorkTrans,
    };
