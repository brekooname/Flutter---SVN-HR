import 'package:json_annotation/json_annotation.dart';

part 'time_sheet_header_transaction_response.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class TimeSheetHeaderTransactionResponse {

  String? _created_by;

  String? _deleted_by;

  String? _employee_id;

  String? _created_at;

  String? _updated_by;

  String? _deleted_at;

  String? _start_date;

  String? _updated_at;

  String? _row_id;

  num? _work_hour;

  num? _shit_type_hour;

  num? _difference_hour;

  TimeSheetHeaderTransactionResponse();


  factory TimeSheetHeaderTransactionResponse.fromJson(Map<String, dynamic> json) => _$TimeSheetHeaderTransactionResponseFromJson(json);


  Map<String, dynamic> toJson() => _$TimeSheetHeaderTransactionResponseToJson(this);

  num get difference_hour => _difference_hour!;

  set difference_hour(num value) {
    _difference_hour = value;
  }

  num get shit_type_hour => _shit_type_hour!;

  set shit_type_hour(num value) {
    _shit_type_hour = value;
  }

  num get work_hour => _work_hour!;

  set work_hour(num value) {
    _work_hour = value;
  }

  String get row_id => _row_id!;

  set row_id(String value) {
    _row_id = value;
  }

  String get updated_at => _updated_at!;

  set updated_at(String value) {
    _updated_at = value;
  }

  String get start_date => _start_date!;

  set start_date(String value) {
    _start_date = value;
  }

  String get deleted_at => _deleted_at!;

  set deleted_at(String value) {
    _deleted_at = value;
  }

  String get updated_by => _updated_by!;

  set updated_by(String value) {
    _updated_by = value;
  }

  String get created_at => _created_at!;

  set created_at(String value) {
    _created_at = value;
  }

  String get employee_id => _employee_id!;

  set employee_id(String value) {
    _employee_id = value;
  }

  String get deleted_by => _deleted_by!;

  set deleted_by(String value) {
    _deleted_by = value;
  }

  String get created_by => _created_by!;

  set created_by(String value) {
    _created_by = value;
  }
}
