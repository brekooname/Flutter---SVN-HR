import 'package:json_annotation/json_annotation.dart';


part 'attendance_summary_request.g.dart';

@JsonSerializable(nullable: false)
class AttendanceSummaryRequest{

  String? tokenId;

  String? fromDate;

  String? toDate;

  AttendanceSummaryRequest({this.tokenId, this.fromDate, this.toDate});

  factory AttendanceSummaryRequest.fromJson(Map<String, dynamic> json) => _$AttendanceSummaryRequestFromJson(json);


  Map<String, dynamic> toJson() => _$AttendanceSummaryRequestToJson(this);
}