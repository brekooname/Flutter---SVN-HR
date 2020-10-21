import 'package:json_annotation/json_annotation.dart';

part 'new_vacation_request.g.dart';

@JsonSerializable(nullable: false)
class NewVacationRequest{
  String _vacation_id;

  String _planned_flg = "N";

  String _start_date;

  String _end_date;

  String _vacation_locaction;

  String _notes;

  NewVacationRequest();

  factory NewVacationRequest.fromJson(Map<String, dynamic> json) => _$NewVacationRequestFromJson(json);


  Map<String, dynamic> toJson() => _$NewVacationRequestToJson(this);

  String get vacation_locaction => _vacation_locaction;

  set vacation_locaction(String value) {
    _vacation_locaction = value;
  }

  String get end_date => _end_date;

  set end_date(String value) {
    _end_date = value;
  }

  String get start_date => _start_date;

  set start_date(String value) {
    _start_date = value;
  }

  String get planned_flg => _planned_flg;

  set planned_flg(String value) {
    _planned_flg = value;
  }

  String get vacation_id => _vacation_id;

  set vacation_id(String value) {
    _vacation_id = value;
  }

  String get notes => _notes;

  set notes(String value) {
    _notes = value;
  }
}