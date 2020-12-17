import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

part 'attendance_summary_response.g.dart';

@JsonSerializable(nullable: false)
class AttendanceSummaryResponse {
  String _rec_date;

  String _clock_id;

  String _rec_type;

  String _rec_type_display_value;

  String _emp_clock_id;

  String _row_id;

  String _status;

  String _status_display_value;

  String _extra_details;

  num _actual_time;

  String _source;

  String _source_display_value;

  num _rec_time;

  AttendanceSummaryResponse();

  factory AttendanceSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceSummaryResponseToJson(this);

  num get rec_time => _rec_time;

  set rec_time(num value) {
    _rec_time = value;
  }

  String get source_display_value => _source_display_value;

  set source_display_value(String value) {
    _source_display_value = value;
  }

  String get source => _source;

  set source(String value) {
    _source = value;
  }

  num get actual_time => _actual_time;

  set actual_time(num value) {
    _actual_time = value;
  }

  String get extra_details => _extra_details;

  set extra_details(String value) {
    _extra_details = value;
  }

  String get status_display_value => _status_display_value;

  set status_display_value(String value) {
    _status_display_value = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  String get emp_clock_id => _emp_clock_id;

  set emp_clock_id(String value) {
    _emp_clock_id = value;
  }

  String get rec_type_display_value => _rec_type_display_value;

  set rec_type_display_value(String value) {
    _rec_type_display_value = value;
  }

  String get rec_type => _rec_type;

  set rec_type(String value) {
    _rec_type = value;
  }

  String get clock_id => _clock_id;

  set clock_id(String value) {
    _clock_id = value;
  }

  String get rec_date => _rec_date;

  set rec_date(String value) {
    _rec_date = value;
  }

  Icon getRightIcon() {
    if (rec_type != null && rec_type != null) {
      if (rec_type.compareTo(Const.RECORD_TYPE_OUT) == 0) {
        return Icon(
          Icons.arrow_circle_up_outlined,
          color: AppTheme.red,
        );
      } else if (rec_type.compareTo(Const.RECORD_TYPE_IN) == 0) {
        return Icon(
          Icons.arrow_circle_down_outlined,
          color: AppTheme.green,
        );
      }
    }
  }

  Color getRightColor() {
    if (rec_type.compareTo(Const.RECORD_TYPE_IN) == 0) {
      return AppTheme.green;
    } else if (rec_type.compareTo(Const.RECORD_TYPE_OUT) == 0) {
      return AppTheme.red;
    }
  }
}
