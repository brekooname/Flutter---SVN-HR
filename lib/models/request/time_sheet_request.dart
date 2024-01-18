import 'package:json_annotation/json_annotation.dart';

part 'time_sheet_request.g.dart';

@JsonSerializable(nullable: false , explicitToJson: true)
class TimeSheetRequest{

  String? tokenId;

  String? fromDate;

  String? toDate;

  TimeSheetRequest({this.tokenId, this.fromDate, this.toDate});

  factory TimeSheetRequest.fromJson(Map<String, dynamic> json) => _$TimeSheetRequestFromJson(json);


  Map<String, dynamic> toJson() => _$TimeSheetRequestToJson(this);

}