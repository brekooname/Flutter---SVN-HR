// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectListResponse _$ProjectListResponseFromJson(Map<String, dynamic> json) {
  return ProjectListResponse()
    ..extra_details = json['extra_details'] as String? ?? 'default_extra_details'
    ..description = json['description'] as String? ?? 'default_description'
    ..name = json['name'] as String? ?? 'default_name'
    ..row_id = json['row_id'] as String? ?? 'default_row_id'
    ..start_date = json['start_date'] as String? ?? 'default_start_date'
    ..end_date = json['end_date'] as String? ?? 'default_end_date'
    ..has_payroll_details = json['has_payroll_details'] as String? ?? 'default_has_payroll_details'
    ..is_funded = json['is_funded'] as String? ?? 'default_is_funded'
    ..leader_id = json['leader_id'] as String? ?? 'default_leader_id'
    ..is_core_project = json['is_core_project'] as String? ?? 'default_is_core_project';
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
