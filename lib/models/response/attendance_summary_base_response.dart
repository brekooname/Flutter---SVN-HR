import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/attendance_summary_response.dart';


part 'attendance_summary_base_response.g.dart';

@JsonSerializable(nullable: false)
class AttendanceSummaryBaseResponse{

  String _response;

  String _err_MSG;

  List<AttendanceSummaryResponse> _cloackRecordList;


  AttendanceSummaryBaseResponse();

  factory AttendanceSummaryBaseResponse.fromJson(Map<String, dynamic> json) => _$AttendanceSummaryBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$AttendanceSummaryBaseResponseToJson(this);


  List<AttendanceSummaryResponse> get cloackRecordList => _cloackRecordList;

  set cloackRecordList(List<AttendanceSummaryResponse> value) {
    _cloackRecordList = value;
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