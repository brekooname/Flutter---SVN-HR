import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/new_time_sheet_details_request.dart';

part 'new_time_sheet_details_base_request.g.dart';

@JsonSerializable(nullable: false)
class NewTimeSheetDetailsBaseRequest {
  String? tokenID;
  NewTimeSheetDetailsRequest? timesheetDetails;

  NewTimeSheetDetailsBaseRequest({this.tokenID, this.timesheetDetails});

  factory NewTimeSheetDetailsBaseRequest.fromJson(Map<String, dynamic> json) =>
      _$NewTimeSheetDetailsBaseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NewTimeSheetDetailsBaseRequestToJson(this);
}