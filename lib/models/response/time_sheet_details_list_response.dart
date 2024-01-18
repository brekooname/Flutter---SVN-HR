import 'package:json_annotation/json_annotation.dart';

part 'time_sheet_details_list_response.g.dart';

@JsonSerializable(nullable: false)
class TimeSheetDetailsResponse {

  String? _created_by;
  String? _deleted_by;
  num? _start_time;
  num? _created_at;
  num? _total_work_hours;
  String? _deleted_at;
  num? _break_hours;
  String? _row_id;
  String? _status;
  num? _end_time;
  String? _extra_details;
  String? _description;
  String? _updated_by;
  String? _employee_timesheet_id;
  String? _updated_at;
  String? _type;
  String? _project_id;
  num? _work_hour;
  String? _status_display;
  String? _project_name;

  TimeSheetDetailsResponse();

  factory TimeSheetDetailsResponse.fromJson(Map<String, dynamic> json) => _$TimeSheetDetailsResponseFromJson(json);


  Map<String, dynamic> toJson() => _$TimeSheetDetailsResponseToJson(this);

  String get project_name => _project_name!;

  set project_name(String value) {
    _project_name = value;
  }

  String get status_display => _status_display!;

  set status_display(String value) {
    _status_display = value;
  }

  num get work_hour => _work_hour!;

  set work_hour(num value) {
    _work_hour = value;
  }

  String get project_id => _project_id!;

  set project_id(String value) {
    _project_id = value;
  }

  String get type => _type!;

  set type(String value) {
    _type = value;
  }

  String get updated_at => _updated_at!;

  set updated_at(String value) {
    _updated_at = value;
  }

  String get employee_timesheet_id => _employee_timesheet_id!;

  set employee_timesheet_id(String value) {
    _employee_timesheet_id = value;
  }

  String get updated_by => _updated_by!;

  set updated_by(String value) {
    _updated_by = value;
  }

  String get description => _description!;

  set description(String value) {
    _description = value;
  }

  String get extra_details => _extra_details!;

  set extra_details(String value) {
    _extra_details = value;
  }

  num get end_time => _end_time!;

  set end_time(num value) {
    _end_time = value;
  }

  String get status => _status!;

  set status(String value) {
    _status = value;
  }

  String get row_id => _row_id!;

  set row_id(String value) {
    _row_id = value;
  }

  num get break_hours => _break_hours!;

  set break_hours(num value) {
    _break_hours = value;
  }

  String get deleted_at => _deleted_at!;

  set deleted_at(String value) {
    _deleted_at = value;
  }

  num get total_work_hours => _total_work_hours!;

  set total_work_hours(num value) {
    _total_work_hours = value;
  }

  num get created_at => _created_at!;

  set created_at(num value) {
    _created_at = value;
  }

  num get start_time => _start_time!;

  set start_time(num value) {
    _start_time = value;
  }

  String get deleted_by => _deleted_by!;

  set deleted_by(String value) {
    _deleted_by = value;
  }

  String get created_by => _created_by!;

  set created_by(String value) {
    _created_by = value;
  }
}
