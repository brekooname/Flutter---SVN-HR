import 'package:json_annotation/json_annotation.dart';

part 'expense_request.g.dart';

@JsonSerializable(nullable: false)
class ExpenseRequest {
  String currency_id;
  String permission_method = "OBJECT";
  String employee_id;
  num expense_amount;
  String response_date;
  String expense_date;
  String request_status;
  String row_id;
  String trans_status;
  String extra_details;
  String description;
  String request_date;
  num approved_amount;
  String approve_date;

  ExpenseRequest();

  factory ExpenseRequest.fromJson(Map<String, dynamic> json) =>
      _$ExpenseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseRequestToJson(this);
}
