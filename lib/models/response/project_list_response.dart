import 'package:json_annotation/json_annotation.dart';


part 'project_list_response.g.dart';

@JsonSerializable(nullable: false)
class ProjectListResponse{

   String? _is_core_project ;
   String? _leader_id;
   String? _is_funded ;
   String? _has_payroll_details;
   String? _end_date;
   String? _start_date;
   String? _row_id;
   String? _name;
   String? _description;
   String? _extra_details;

   ProjectListResponse();

   factory ProjectListResponse.fromJson(Map<String, dynamic> json) => _$ProjectListResponseFromJson(json);


   Map<String, dynamic> toJson() => _$ProjectListResponseToJson(this);

   String get extra_details => _extra_details!;

  set extra_details(String value) {
    _extra_details = value;
  }

  String get description => _description!;

  set description(String value) {
    _description = value;
  }

  String get name => _name!;

  set name(String value) {
    _name = value;
  }

  String get row_id => _row_id!;

  set row_id(String value) {
    _row_id = value;
  }

  String get start_date => _start_date!;

  set start_date(String value) {
    _start_date = value;
  }

  String get end_date => _end_date!;

  set end_date(String value) {
    _end_date = value;
  }

  String get has_payroll_details => _has_payroll_details!;

  set has_payroll_details(String value) {
    _has_payroll_details = value;
  }

  String get is_funded => _is_funded!;

  set is_funded(String value) {
    _is_funded = value;
  }

  String get leader_id => _leader_id!;

  set leader_id(String value) {
    _leader_id = value;
  }

  String get is_core_project => _is_core_project!;

  set is_core_project(String value) {
    _is_core_project = value;
  }

   @override
  String toString() {
    return 'ProjectListResponse{_name: $_name}';
  }
}