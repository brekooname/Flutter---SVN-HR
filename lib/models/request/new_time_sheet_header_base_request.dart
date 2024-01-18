import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/new_time_sheet_header_request.dart';

part 'new_time_sheet_header_base_request.g.dart';

@JsonSerializable(nullable: false)
class NewTimeSheetHeaderBaseRequest{
  String? tokenID;
  NewTimeSheetHeaderRequest? timesheetHeader;


  NewTimeSheetHeaderBaseRequest({this.tokenID, this.timesheetHeader});

  factory NewTimeSheetHeaderBaseRequest.fromJson(Map<String, dynamic> json) => _$NewTimeSheetHeaderBaseRequestFromJson(json);


  Map<String, dynamic> toJson() => _$NewTimeSheetHeaderBaseRequestToJson(this);

}