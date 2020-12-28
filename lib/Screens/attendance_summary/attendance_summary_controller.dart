import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/attendance_summary/models/attendance_list_item.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/models/request/attendance_summary_request.dart';
import 'package:sven_hr/models/response/attendance_summary_base_response.dart';
import 'package:sven_hr/models/response/attendance_summary_response.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/constants.dart';

class AttendanceSummaryController {
  DateFormat format = DateFormat(Const.DATE_FORMAT);

  List<AttendanceSummaryResponse> _attendanceList;

  AttendanceSummaryController() {
    _attendanceList = List();
  }

  Future<String> getDefualtSearch() async {
    DateTime now = new DateTime.now();
    String toDate = format.format(now);
    DateTime lastMonthDate = new DateTime(now.year, now.month, now.day - 1);
    String fromDate = format.format(lastMonthDate);

    String response = await getAttendanceSummaryTransaction(fromDate, toDate);
    return response;
  }

  Future<String> getAttendanceSummaryTransaction(
    String fromDate,
    String toDate,
  ) async {
    _attendanceList = List();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";
    String host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    AttendanceSummaryRequest request = AttendanceSummaryRequest(
        tokenId: tokenId, fromDate: fromDate, toDate: toDate);
    if (request != null) {
      var url = host + ApiConnections.GET_ATTENDANCE_SUMMARY;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        AttendanceSummaryBaseResponse baseResponse =
            AttendanceSummaryBaseResponse.fromJson(userData);

        if (baseResponse.cloackRecordList != null) {
          _attendanceList = baseResponse.cloackRecordList;

        }
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  List<AttendanceSummaryResponse> get attendanceList => _attendanceList;

  set attendanceList(List<AttendanceSummaryResponse> value) {
    _attendanceList = value;
  }
}
