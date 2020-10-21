import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/vacation_transaction_request_wrapper.dart';

part 'vacation_transaction_request.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class VacationTransactionRequest{

  VacationTransactionRequest();

  @JsonKey(name: 'tokenID')
  String tokenID;

  @JsonKey(name: 'vac')
  VacationTransactionRequestWrapper vac;

  factory VacationTransactionRequest.fromJson(Map<String, dynamic> json) => _$VacationTransactionRequestFromJson(json);


  Map<String, dynamic> toJson() => _$VacationTransactionRequestToJson(this);

}