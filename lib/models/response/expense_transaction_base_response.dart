import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/expense_transaction_response.dart';


part 'expense_transaction_base_response.g.dart';

@JsonSerializable(nullable: false)
class ExpenseTransactionBaseResponse{

  String? _response;

  String? _err_MSG;

  List<ExpenseTransactionResponse>? _expenseList;


  ExpenseTransactionBaseResponse();

  factory ExpenseTransactionBaseResponse.fromJson(Map<String, dynamic> json) => _$ExpenseTransactionBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ExpenseTransactionBaseResponseToJson(this);


  List<ExpenseTransactionResponse> get expenseList => _expenseList!;

  set expenseList(List<ExpenseTransactionResponse> value) {
    _expenseList = value;
  }

  String get err_MSG => _err_MSG!;

  set err_MSG(String value) {
    _err_MSG = value;
  }

  String get response => _response!;

  set response(String value) {
    _response = value;
  }
}