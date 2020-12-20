import 'package:json_annotation/json_annotation.dart';

import 'extra_work_transaction_response.dart';


part 'extra_work_transaction_base_response.g.dart';

@JsonSerializable(nullable: false)
class ExtraWorkTransactionBaseResponse{

  String _response;

  String _err_MSG;

  List<ExtraWorkTransactionResponse> _extraWorkList;


  ExtraWorkTransactionBaseResponse();

  factory ExtraWorkTransactionBaseResponse.fromJson(Map<String, dynamic> json) => _$ExtraWorkTransactionBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ExtraWorkTransactionBaseResponseToJson(this);

  List<ExtraWorkTransactionResponse> get extraWorkList => _extraWorkList;

  set extraWorkList(List<ExtraWorkTransactionResponse> value) {
    _extraWorkList = value;
  }

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }

  String get response => _response;

  set response(String value) {
    _response = value;
  }
}