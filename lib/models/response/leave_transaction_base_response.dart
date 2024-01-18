import 'package:json_annotation/json_annotation.dart';

import 'leave_transaction_response.dart';


part 'leave_transaction_base_response.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class LeaveTransactionBaseResponse{

  LeaveTransactionBaseResponse();

  @JsonKey(name: 'err_MSG')
  String? _err_MSG;

  @JsonKey(name: 'leaveTransactions')
  List<LeaveTransactionResponse>? _leaveTransactions;


  factory LeaveTransactionBaseResponse.fromJson(Map<String, dynamic> json) => _$LeaveTransactionBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$LeaveTransactionBaseResponseToJson(this);


  List<LeaveTransactionResponse> get leaveTransactions => _leaveTransactions!;

  set leaveTransactions(List<LeaveTransactionResponse> value) {
    _leaveTransactions = value;
  }

  String get err_MSG => _err_MSG!;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}