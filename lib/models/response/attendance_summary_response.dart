import 'package:json_annotation/json_annotation.dart';


part 'attendance_summary_response.g.dart';

@JsonSerializable(nullable: false)
class AttendanceSummaryResponse {
  String? _rec_date;

  String? _check_in;

  String? _check_out;


  AttendanceSummaryResponse();

  factory AttendanceSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceSummaryResponseToJson(this);


  String get check_out => _check_out!;

  set check_out(String value) {
    _check_out = value;
  }

  String get check_in => _check_in!;

  set check_in(String value) {
    _check_in = value;
  }

  String get rec_date => _rec_date!;

  set rec_date(String value) {
    _rec_date = value;
  }

// Icon getRightIcon() {
  //   if (rec_type != null && rec_type != null) {
  //     if (rec_type.compareTo(Const.RECORD_TYPE_OUT) == 0) {
  //       return Icon(
  //         Icons.arrow_circle_up_outlined,
  //         color: AppTheme.red,
  //       );
  //     } else if (rec_type.compareTo(Const.RECORD_TYPE_IN) == 0) {
  //       return Icon(
  //         Icons.arrow_circle_down_outlined,
  //         color: AppTheme.green,
  //       );
  //     }
  //   }
  // }
  //
  // Color getRightColor() {
  //   if (rec_type.compareTo(Const.RECORD_TYPE_IN) == 0) {
  //     return AppTheme.green;
  //   } else if (rec_type.compareTo(Const.RECORD_TYPE_OUT) == 0) {
  //     return AppTheme.red;
  //   }
  // }
}
