import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/expense_request.dart';

part 'expense_base_request.g.dart';

@JsonSerializable(nullable: false)
class ExpenseBaseRequest{

  String? tokenID;
  ExpenseRequest? expenseTrans;

  ExpenseBaseRequest({this.tokenID, this.expenseTrans});

  factory ExpenseBaseRequest.fromJson(Map<String, dynamic> json) =>
      _$ExpenseBaseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseBaseRequestToJson(this);
}