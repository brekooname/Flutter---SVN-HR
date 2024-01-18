import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/time_sheet_header_transaction_response.dart';

part 'time_sheet_header_transaction_base_response.g.dart';

@JsonSerializable(nullable: false)
class TimeSheetHeaderTransactionBaseResponse{

  TimeSheetHeaderTransactionBaseResponse();


  factory TimeSheetHeaderTransactionBaseResponse.fromJson(Map<String, dynamic> json) => _$TimeSheetHeaderTransactionBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$TimeSheetHeaderTransactionBaseResponseToJson(this);


  @JsonKey(name: 'timesheetTransactions')
  List<TimeSheetHeaderTransactionResponse>? _timesheetTransactions;

  @JsonKey(name: 'err_MSG')
  String? _err_MSG;


  List<TimeSheetHeaderTransactionResponse> get timesheetTransactions =>
      _timesheetTransactions!;

  set timesheetTransactions(List<TimeSheetHeaderTransactionResponse> value) {
    _timesheetTransactions = value;
  }

  String get err_MSG => _err_MSG!;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}