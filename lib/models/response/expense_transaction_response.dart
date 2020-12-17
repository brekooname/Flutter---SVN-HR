import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/approval_list.dart';
import 'package:sven_hr/utilities/app_theme.dart';


part 'expense_transaction_response.g.dart';

@JsonSerializable(nullable: false)
class ExpenseTransactionResponse{


  String _row_id;

  String _description;

  String _expense_date;

  num _expense_amount;

  String _currency_id;

  String _request_status;

  String _status_display_name;

  String _request_date;

  num _approved_amount;

  String _approval_date;

  String _currency_display_name;

  List<ApprovalList> _approvalList;


  ExpenseTransactionResponse();

  factory ExpenseTransactionResponse.fromJson(Map<String, dynamic> json) => _$ExpenseTransactionResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ExpenseTransactionResponseToJson(this);

  num get approved_amount => _approved_amount;

  set approved_amount(num value) {
    _approved_amount = value;
  }

  String get request_date => _request_date;

  set request_date(String value) {
    _request_date = value;
  }

  String get currency_id => _currency_id;

  set currency_id(String value) {
    _currency_id = value;
  }

  num get expense_amount => _expense_amount;

  set expense_amount(num value) {
    _expense_amount = value;
  }

  String get expense_date => _expense_date;

  set expense_date(String value) {
    _expense_date = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  List<ApprovalList> get approvalList => _approvalList;

  set approvalList(List<ApprovalList> value) {
    _approvalList = value;
  }


  String get request_status => _request_status;

  set request_status(String value) {
    _request_status = value;
  }

  Icon getRightIcon() {
    return Icon(
      Icons.monetization_on_outlined,
      color: AppTheme.nearlyBlue,
    );
  }

  Color getRightColor() {
    return AppTheme.nearlyBlue;
  }

  String get approval_date => _approval_date;

  set approval_date(String value) {
    _approval_date = value;
  }

  String get currency_display_name => _currency_display_name;

  set currency_display_name(String value) {
    _currency_display_name = value;
  }

  String get status_display_name => _status_display_name;

  set status_display_name(String value) {
    _status_display_name = value;
  }
}