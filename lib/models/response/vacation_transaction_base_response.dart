import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/vacation_transaction_response.dart';


part 'vacation_transaction_base_response.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class VacationTransactionBaseResponse{

  VacationTransactionBaseResponse();

  @JsonKey(name: 'err_MSG')
  String? _err_MSG;

  @JsonKey(name: 'vacationTransactions')
  List<VacationTransactionResponse>? _vacationTransactions;


  factory VacationTransactionBaseResponse.fromJson(Map<String, dynamic> json) => _$VacationTransactionBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$VacationTransactionBaseResponseToJson(this);

  List<VacationTransactionResponse> get vacationTransactions =>
      _vacationTransactions!;

  set vacationTransactions(List<VacationTransactionResponse> value) {
    _vacationTransactions = value;
  }

  String get err_MSG => _err_MSG!;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}