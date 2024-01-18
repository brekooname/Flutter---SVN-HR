import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/approval_list.dart';

part 'extra_work_transaction_response.g.dart';

@JsonSerializable(nullable: false)
class ExtraWorkTransactionResponse {
  String? _row_id;

  String? _employee_id;

  String? _unit;

  String? _unit_display_value;

  num? _unit_quantity;

  String? _reason_id;

  String? _reason_id_display_value;

  String? _status;

  String? _status_display_value;

  String? _requested_by;

  String? _extra_details;

  String? _request_date;

  String? _approval_date;

  String? _day_type;

  String? _day_type_display_value;

  String? _approved_by;

  String? _extra_work_date;


  String get extra_work_date => _extra_work_date!;

  set extra_work_date(String value) {
    _extra_work_date = value;
  }

  List<ApprovalList>? _approvalList;

  ExtraWorkTransactionResponse();

  factory ExtraWorkTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtraWorkTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraWorkTransactionResponseToJson(this);

  List<ApprovalList> get approvalList => _approvalList!;

  set approvalList(List<ApprovalList> value) {
    _approvalList = value;
  }

  String get approved_by => _approved_by!;

  set approved_by(String value) {
    _approved_by = value;
  }

  String get day_type_display_value => _day_type_display_value!;

  set day_type_display_value(String value) {
    _day_type_display_value = value;
  }

  String get day_type => _day_type!;

  set day_type(String value) {
    _day_type = value;
  }

  String get request_date => _request_date!;

  set request_date(String value) {
    _request_date = value;
  }

  String get extra_details => _extra_details!;

  set extra_details(String value) {
    _extra_details = value;
  }

  String get requested_by => _requested_by!;

  set requested_by(String value) {
    _requested_by = value;
  }

  String get status_display_value => _status_display_value!;

  set status_display_value(String value) {
    _status_display_value = value;
  }

  String get status => _status!;

  set status(String value) {
    _status = value;
  }

  String get reason_id_display_value => _reason_id_display_value!;

  set reason_id_display_value(String value) {
    _reason_id_display_value = value;
  }

  String get reason_id => _reason_id!;

  set reason_id(String value) {
    _reason_id = value;
  }

  num get unit_quantity => _unit_quantity!;

  set unit_quantity(num value) {
    _unit_quantity = value;
  }

  String get unit_display_value => _unit_display_value!;

  set unit_display_value(String value) {
    _unit_display_value = value;
  }

  String get unit => _unit!;

  set unit(String value) {
    _unit = value;
  }

  String get employee_id => _employee_id!;

  set employee_id(String value) {
    _employee_id = value;
  }

  String get row_id => _row_id!;

  set row_id(String value) {
    _row_id = value;
  }

  Icon getRightIcon() {
    return Icon(
      Icons.work_outline,
      color: getRightColor(),
    );
  }

  Color getRightColor() {
    return status_display_value.toString() == 'Approved'
        ? Colors.green
        : status_display_value.toString() == 'Rejected'
            ? Colors.red
            : status_display_value.toString() == 'Declined'
                ? Colors.red
                : status_display_value.toString() == 'New'
                    ? Colors.orange
                    : Colors.blue;
  }

  String get approval_date => _approval_date!;

  set approval_date(String value) {
    _approval_date = value;
  }
}
