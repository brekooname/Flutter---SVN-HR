import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/employee_vacation_response.dart';

part 'employee_vacation_base_response.g.dart';

@JsonSerializable(nullable: false)
class EmployeeVacationBaseResponse{

  EmployeeVacationBaseResponse();


  factory EmployeeVacationBaseResponse.fromJson(Map<String, dynamic> json) => _$EmployeeVacationBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$EmployeeVacationBaseResponseToJson(this);

  @JsonKey(name: 'response')
  String _response;

  @JsonKey(name: 'employeeVacations')
  List<EmployeeVacationResponse> _employeeVacations;

  @JsonKey(name: 'err_MSG')
  String _err_MSG;

  String get response => _response;

  set response(String value) {
    _response = value;
  }

  List<EmployeeVacationResponse> get employeeVacations => _employeeVacations;

  set employeeVacations(List<EmployeeVacationResponse> value) {
    _employeeVacations = value;
  }

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}