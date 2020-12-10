// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectListResponse _$ProjectListResponseFromJson(Map<String, dynamic> json) {
  return ProjectListResponse()
    ..extra_details = json['extra_details'] as String
    ..description = json['description'] as String
    ..name = json['name'] as String
    ..row_id = json['row_id'] as String
    ..start_date = json['start_date'] as String
    ..end_date = json['end_date'] as String
    ..has_payroll_details = json['has_payroll_details'] as String
    ..is_funded = json['is_funded'] as String
    ..leader_id = json['leader_id'] as String
    ..is_core_project = json['is_core_project'] as String;
}

Map<String, dynamic> _$ProjectListResponseToJson(
        ProjectListResponse instance) =>
    <String, dynamic>{
      'extra_details': instance.extra_details,
      'description': instance.description,
      'name': instance.name,
      'row_id': instance.row_id,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'has_payroll_details': instance.has_payroll_details,
      'is_funded': instance.is_funded,
      'leader_id': instance.leader_id,
      'is_core_project': instance.is_core_project,
    };
