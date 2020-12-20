import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/approval_list.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

part 'leave_transaction_response.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class LeaveTransactionResponse{

  LeaveTransactionResponse();

  @JsonKey(name: 'permission_method')
  String _permission_method;

  @JsonKey(name: 'createddate')
  String _createddate;

  @JsonKey(name: 'trans_status')
  String _trans_status;

  @JsonKey(name: 'trans_status_displayValue')
  String _trans_status_displayValue;

  @JsonKey(name: 'trans_status_code')
  String _trans_status_code;

  @JsonKey(name: 'trans_type')
  String _trans_type;

  @JsonKey(name: 'employee_id')
  String _employee_id;

  @JsonKey(name: 'start_date')
  String _start_date;

  @JsonKey(name: 'end_date')
  String _end_date;

  @JsonKey(name: 'approver_note')
  String _approver_note;

  @JsonKey(name: 'request_date')
  String _request_date;

  @JsonKey(name: 'start_time')
  int _start_time;

  @JsonKey(name: 'row_id')
  String _row_id;

  @JsonKey(name: 'request_status')
  String request_status;

  @JsonKey(name: 'request_status_displayValue')
  String _request_status_displayValue;

  @JsonKey(name: 'request_status_code')
  String _request_status_code;

  @JsonKey(name: 'remark')
  String _remark;

  @JsonKey(name: 'createdby')
  String _createdby;

  @JsonKey(name: 'updatedate')
  String _updatedate;

  @JsonKey(name: 'leave_id')
  String _leave_id;

  @JsonKey(name: 'leave_code')
  String _leave_code;

  @JsonKey(name: 'leave_displayValue')
  String _leave_displayValue;

  @JsonKey(name: 'approve_date')
  String _approve_date;

  @JsonKey(name: 'approver_id')
  String _approver_id;

  @JsonKey(name: 'end_time')
  int _end_time;

  @JsonKey(name: 'start_time_String')
  String _start_time_String;

  @JsonKey(name: 'end_time_String')
  String _end_time_String;

  @JsonKey(name: 'approvalList')
  List<ApprovalList> _approvalList;

  factory LeaveTransactionResponse.fromJson(Map<String, dynamic> json) => _$LeaveTransactionResponseFromJson(json);


  Map<String, dynamic> toJson() => _$LeaveTransactionResponseToJson(this);

  int get end_time => _end_time;

  set end_time(int value) {
    _end_time = value;
  }

  String get approver_id => _approver_id;

  set approver_id(String value) {
    _approver_id = value;
  }

  String get approve_date => _approve_date;

  set approve_date(String value) {
    _approve_date = value;
  }

  String get leave_displayValue => _leave_displayValue;

  set leave_displayValue(String value) {
    _leave_displayValue = value;
  }

  String get leave_code => _leave_code;

  set leave_code(String value) {
    _leave_code = value;
  }

  String get leave_id => _leave_id;

  set leave_id(String value) {
    _leave_id = value;
  }

  String get updatedate => _updatedate;

  set updatedate(String value) {
    _updatedate = value;
  }

  String get createdby => _createdby;

  set createdby(String value) {
    _createdby = value;
  }

  String get remark => _remark;

  set remark(String value) {
    _remark = value;
  }

  String get request_status_code => _request_status_code;

  set request_status_code(String value) {
    _request_status_code = value;
  }

  String get request_status_displayValue => _request_status_displayValue;

  set request_status_displayValue(String value) {
    _request_status_displayValue = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  int get start_time => _start_time;

  set start_time(int value) {
    _start_time = value;
  }

  String get request_date => _request_date;

  set request_date(String value) {
    _request_date = value;
  }

  String get approver_note => _approver_note;

  set approver_note(String value) {
    _approver_note = value;
  }

  String get end_date => _end_date;

  set end_date(String value) {
    _end_date = value;
  }

  String get start_date => _start_date;

  set start_date(String value) {
    _start_date = value;
  }

  String get employee_id => _employee_id;

  set employee_id(String value) {
    _employee_id = value;
  }

  String get trans_type => _trans_type;

  set trans_type(String value) {
    _trans_type = value;
  }

  String get trans_status_code => _trans_status_code;

  set trans_status_code(String value) {
    _trans_status_code = value;
  }

  String get trans_status_displayValue => _trans_status_displayValue;

  set trans_status_displayValue(String value) {
    _trans_status_displayValue = value;
  }

  String get trans_status => _trans_status;

  set trans_status(String value) {
    _trans_status = value;
  }

  String get createddate => _createddate;

  set createddate(String value) {
    _createddate = value;
  }

  String get permission_method => _permission_method;

  set permission_method(String value) {
    _permission_method = value;
  }

  String get end_time_String => _end_time_String;

  set end_time_String(String value) {
    _end_time_String = value;
  }

  String get start_time_String => _start_time_String;

  set start_time_String(String value) {
    _start_time_String = value;
  }

  List<ApprovalList> get approvalList => _approvalList;

  set approvalList(List<ApprovalList> value) {
    _approvalList = value;
  }

  Icon getRightIcon() {
    if (request_status != null) {
      if (request_status.compareTo(Const.LEAVE_REQUEST_APPROVED_STATUS) ==
          0) {
        return Icon(
          Icons.done_outline,
          color: AppTheme.green,
        );
      } else if (request_status
          .compareTo(Const.LEAVE_REQUEST_CANCELED_STATUS) ==
          0) {
        return Icon(
          Icons.cancel,
          color: AppTheme.blue_dark,
        );
      } else if (request_status
          .compareTo(Const.LEAVE_REQUEST_REJECTED_STATUS) ==
          0) {
        return Icon(
          Icons.close,
          color: AppTheme.red,
        );
      } else if (request_status
          .compareTo(Const.LEAVE_REQUEST_PENDING_STATUS) ==
          0) {
        return Icon(
          Icons.query_builder,
          color: AppTheme.orange,
        );
      }
    }
  }

  Color getRightColor() {
    if (request_status.compareTo(Const.LEAVE_REQUEST_APPROVED_STATUS) == 0) {
      return AppTheme.green;
    } else if (request_status
        .compareTo(Const.LEAVE_REQUEST_CANCELED_STATUS) ==
        0) {
      return AppTheme.blue_dark;
    } else if (request_status
        .compareTo(Const.LEAVE_REQUEST_REJECTED_STATUS) ==
        0) {
      return AppTheme.red;
    } else if (request_status.compareTo(Const.LEAVE_REQUEST_PENDING_STATUS) ==
        0) {
      return AppTheme.orange;
    }
  }
}