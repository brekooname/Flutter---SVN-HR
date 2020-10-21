
import 'package:json_annotation/json_annotation.dart';

part 'lov_values.g.dart';

@JsonSerializable(nullable: false)
class LovValues{
  String _par_row_id;
  String _code;
  String _row_id;
  String _dispaly_value;


  LovValues();

  factory LovValues.fromJson(Map<String, dynamic> json) => _$LovValuesFromJson(json);


  Map<String, dynamic> toJson() => _$LovValuesToJson(this);

  String get par_row_id => _par_row_id;

  set par_row_id(String value) {
    _par_row_id = value;
  }

  String get code => _code;

  set code(String value) {
    _code = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  String get dispaly_value => _dispaly_value;

  set dispaly_value(String value) {
    _dispaly_value = value;
  }
}