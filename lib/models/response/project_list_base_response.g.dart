// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_list_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectListBaseResponse _$ProjectListBaseResponseFromJson(
    Map<String, dynamic> json) {
  return ProjectListBaseResponse()
    ..projectListTransactions = (json['projectListTransactions'] as List<dynamic>?)
        ?.map((e) => ProjectListResponse.fromJson(e as Map<String, dynamic>))
        .toList() ?? []
    ..err_MSG = json['err_MSG'] as String? ?? 'default_err_msg';
}

Map<String, dynamic> _$ProjectListBaseResponseToJson(
        ProjectListBaseResponse instance) =>
    <String, dynamic>{
      'projectListTransactions': instance.projectListTransactions,
      'err_MSG': instance.err_MSG,
    };
