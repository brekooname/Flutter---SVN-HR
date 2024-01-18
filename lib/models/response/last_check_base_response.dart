import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/last_check_response.dart';

part 'last_check_base_response.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class LastCheckBaseResponse{

  LastCheckBaseResponse();

  @JsonKey(name: 'err_MSG')
  String? _err_MSG;

  @JsonKey(name: 'checkWra')
  LastCheckResponse? _checkWra;


  factory LastCheckBaseResponse.fromJson(Map<String, dynamic> json) => _$LastCheckBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$LastCheckBaseResponseToJson(this);


  LastCheckResponse get checkWra => _checkWra!;

  set checkWra(LastCheckResponse value) {
    _checkWra = value;
  }

  String get err_MSG => _err_MSG!;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}