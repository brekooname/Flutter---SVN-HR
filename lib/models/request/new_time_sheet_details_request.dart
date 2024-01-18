import 'package:json_annotation/json_annotation.dart';

part 'new_time_sheet_details_request.g.dart';

@JsonSerializable(nullable: false)
class NewTimeSheetDetailsRequest {

  num? start_time;
  String? status;
  num? end_time;
  String? description;
  String? employee_timesheet_id;
  String? project_id;
  String? row_id;

  NewTimeSheetDetailsRequest({
      this.start_time,
      this.status,
      this.end_time,
      this.description,
      this.employee_timesheet_id,
      this.project_id,
      this.row_id});

  factory NewTimeSheetDetailsRequest.fromJson(Map<String, dynamic> json) => _$NewTimeSheetDetailsRequestFromJson(json);


  Map<String, dynamic> toJson() => _$NewTimeSheetDetailsRequestToJson(this);
}
