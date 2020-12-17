import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/attendance_summary_response.dart';


part 'attendance_summary_base_response.g.dart';

@JsonSerializable(nullable: false)
class AttendanceSummaryBaseResponse{

  String _response;

  String _err_MSG;

  List<AttendanceSummaryResponse> _myAttendSummaryRecords;


  AttendanceSummaryBaseResponse();

  factory AttendanceSummaryBaseResponse.fromJson(Map<String, dynamic> json) => _$AttendanceSummaryBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$AttendanceSummaryBaseResponseToJson(this);

  List<AttendanceSummaryResponse> get myAttendSummaryRecords =>
      _myAttendSummaryRecords;

  set myAttendSummaryRecords(List<AttendanceSummaryResponse> value) {
    _myAttendSummaryRecords = value;
  }

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }

  String get response => _response;

  set response(String value) {
    _response = value;
  }
}