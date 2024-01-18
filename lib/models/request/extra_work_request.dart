import 'package:json_annotation/json_annotation.dart';

part 'extra_work_request.g.dart';

@JsonSerializable(nullable: false)
class ExtraWorkRequest {

  String? employee_id;
  String? unit;
  num? unit_quantity;
  String? reason_id;
  String? row_id;
  String? status;
  String? requested_by;
  String? extra_details;
  String? day_type;
  String? request_date;
  String? approved_by;
  String? extra_work_date;


  ExtraWorkRequest();

  factory ExtraWorkRequest.fromJson(Map<String, dynamic> json) =>
      _$ExtraWorkRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraWorkRequestToJson(this);
}
