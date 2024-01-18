import 'package:json_annotation/json_annotation.dart';


part 'expense_transaction_request.g.dart';

@JsonSerializable(nullable: false)
class ExpenseTransactionRequest{

  String? tokenId;

  String? fromDate;

  String? toDate;

  ExpenseTransactionRequest({this.tokenId, this.fromDate, this.toDate});

  factory ExpenseTransactionRequest.fromJson(Map<String, dynamic> json) => _$ExpenseTransactionRequestFromJson(json);


  Map<String, dynamic> toJson() => _$ExpenseTransactionRequestToJson(this);
}