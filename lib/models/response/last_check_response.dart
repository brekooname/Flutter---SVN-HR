import 'package:json_annotation/json_annotation.dart';

part 'last_check_response.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class LastCheckResponse{

  LastCheckResponse();

  factory LastCheckResponse.fromJson(Map<String, dynamic> json) => _$LastCheckResponseFromJson(json);


  Map<String, dynamic> toJson() => _$LastCheckResponseToJson(this);

  @JsonKey(name: 'rec_type')
  String? _rec_type;

  @JsonKey(name: 'emp_clock_id')
  String? _emp_clock_id;

  @JsonKey(name: 'updatedby')
  String? _updatedby;

  @JsonKey(name: 'rec_time')
  num? _rec_time;

  @JsonKey(name: 'updatedate')
  String? _updatedate;

  @JsonKey(name: 'clock_id')
  String? _clock_id;

  @JsonKey(name: 'status')
  String? _status;

  @JsonKey(name: 'updated_flg')
  String? _updated_flg;

  @JsonKey(name: 'createddate')
  String? _createddate;

  @JsonKey(name: 'permission_method')
  String? _permission_method;

  @JsonKey(name: 'source')
  String? _source;

  @JsonKey(name: 'row_id')
  String? _row_id;

  @JsonKey(name: 'rec_date')
  String? _rec_date;

  @JsonKey(name: 'createdby')
  String? _createdby;

  @JsonKey(name: 'actual_time')
  num? _actual_time;

  String get rec_type => _rec_type!;

  set rec_type(String value) {
    _rec_type = value;
  }

  String get emp_clock_id => _emp_clock_id!;

  set emp_clock_id(String value) {
    _emp_clock_id = value;
  }

  num get actual_time => _actual_time!;

  set actual_time(num value) {
    _actual_time = value;
  }

  String get createdby => _createdby!;

  set createdby(String value) {
    _createdby = value;
  }

  String get rec_date => _rec_date!;

  set rec_date(String value) {
    _rec_date = value;
  }

  String get row_id => _row_id!;

  set row_id(String value) {
    _row_id = value;
  }

  String get source => _source!;

  set source(String value) {
    _source = value;
  }

  String get permission_method => _permission_method!;

  set permission_method(String value) {
    _permission_method = value;
  }

  String get createddate => _createddate!;

  set createddate(String value) {
    _createddate = value;
  }

  String get updated_flg => _updated_flg!;

  set updated_flg(String value) {
    _updated_flg = value;
  }

  String get status => _status!;

  set status(String value) {
    _status = value;
  }

  String get clock_id => _clock_id!;

  set clock_id(String value) {
    _clock_id = value;
  }

  String get updatedate => _updatedate!;

  set updatedate(String value) {
    _updatedate = value;
  }

  num get rec_time => _rec_time!;

  set rec_time(num value) {
    _rec_time = value;
  }

  String get updatedby => _updatedby!;

  set updatedby(String value) {
    _updatedby = value;
  }
}