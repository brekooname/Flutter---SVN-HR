import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/time_sheet_details_list_response.dart';
import 'package:sven_hr/models/response/time_sheet_header_transaction_response.dart';

part 'time_sheet_details_list_base_response.g.dart';

@JsonSerializable(nullable: false)
class TimeSheetDetailsBaseResponse{

  TimeSheetDetailsBaseResponse();


  factory TimeSheetDetailsBaseResponse.fromJson(Map<String, dynamic> json) => _$TimeSheetDetailsBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$TimeSheetDetailsBaseResponseToJson(this);


  @JsonKey(name: 'listOfTimesheetDetails')
  List<TimeSheetDetailsResponse> _listOfTimesheetDetails;

  @JsonKey(name: 'err_MSG')
  String _err_MSG;


  List<TimeSheetDetailsResponse> get listOfTimesheetDetails =>
      _listOfTimesheetDetails;

  set listOfTimesheetDetails(List<TimeSheetDetailsResponse> value) {
    _listOfTimesheetDetails = value;
  }

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}