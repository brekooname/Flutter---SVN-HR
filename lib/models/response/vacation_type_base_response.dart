import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/vacation_type_response.dart';

part 'vacation_type_base_response.g.dart';

@JsonSerializable(nullable: false)
class VacationTypeBaseResponse{

  VacationTypeBaseResponse();


  factory VacationTypeBaseResponse.fromJson(Map<String, dynamic> json) => _$VacationTypeBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$VacationTypeBaseResponseToJson(this);

  @JsonKey(name: 'response')
  String _response;

  @JsonKey(name: 'vacations')
  List<VacationTypeResponse> _vacations;

  @JsonKey(name: 'err_MSG')
  String _err_MSG;

  String get response => _response;

  set response(String value) {
    _response = value;
  }

  List<VacationTypeResponse> get vacations => _vacations;

  set vacations(List<VacationTypeResponse> value) {
    _vacations = value;
  }

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}