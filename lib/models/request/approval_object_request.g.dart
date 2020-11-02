// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_object_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalObjectRequest _$ApprovalObjectRequestFromJson(
    Map<String, dynamic> json) {
  return ApprovalObjectRequest(
    tokenWrapper:
        BaseRequest.fromJson(json['tokenWrapper'] as Map<String, dynamic>),
    par_row_id: json['par_row_id'] as String,
  );
}

Map<String, dynamic> _$ApprovalObjectRequestToJson(
        ApprovalObjectRequest instance) =>
    <String, dynamic>{
      'tokenWrapper': instance.tokenWrapper,
      'par_row_id': instance.par_row_id,
    };
