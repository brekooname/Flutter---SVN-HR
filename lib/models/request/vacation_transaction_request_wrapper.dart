import 'package:json_annotation/json_annotation.dart';

part 'vacation_transaction_request_wrapper.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class VacationTransactionRequestWrapper{

  VacationTransactionRequestWrapper();

  @JsonKey(name: 'fromDate')
  String fromDate;

  @JsonKey(name: 'toDate')
  String toDate;

  @JsonKey(name: 'statusList')
  List<String> statusList;

  @JsonKey(name: 'typeList')
  List<String> typeList;

  factory VacationTransactionRequestWrapper.fromJson(Map<String, dynamic> json) => _$VacationTransactionRequestWrapperFromJson(json);


  Map<String, dynamic> toJson() => _$VacationTransactionRequestWrapperToJson(this);
}