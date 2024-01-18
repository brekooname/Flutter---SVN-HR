import 'package:json_annotation/json_annotation.dart';

part 'new_time_sheet_header_request.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class NewTimeSheetHeaderRequest{
  String? start_date;

  String? row_id;

  NewTimeSheetHeaderRequest({this.start_date, this.row_id});

  factory NewTimeSheetHeaderRequest.fromJson(Map<String, dynamic> json) => _$NewTimeSheetHeaderRequestFromJson(json);


  Map<String, dynamic> toJson() => _$NewTimeSheetHeaderRequestToJson(this);
}