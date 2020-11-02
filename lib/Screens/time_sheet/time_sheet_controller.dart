import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/models/request/time_sheet_request.dart';
import 'package:sven_hr/models/response/time_sheet_header_transaction_base_response.dart';
import 'package:sven_hr/models/response/time_sheet_header_transaction_response.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

import 'models/time_sheet_header_list_item.dart';

class TimeSheetController {
  List<TimeSheetHeaderListItem> _timeSheetHeaderListItem;

  List<TimeSheetHeaderTransactionResponse> _timeSheetHeaderList;

  DateFormat format = DateFormat(Const.DATE_FORMAT);


  Future<String> getDefualtSearch() async {
    DateTime now = new DateTime.now();
    String toDate = format.format(now);
    DateTime lastMonthDate = new DateTime(now.year, now.month , now.day-1);
    String fromDate = format.format(lastMonthDate);

    String response =
    await getSelfTimeSheetHeaderTransaction(fromDate, toDate);
    return response;
  }

  Future<String> getSelfTimeSheetHeaderTransaction(
    String fromDate,
    String toDate,
  ) async {
    timeSheetHeaderList = List();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";

    TimeSheetRequest request =
        TimeSheetRequest(tokenId: tokenId, fromDate: fromDate, toDate: toDate);
    if (request != null) {
      var url =
          ApiConnections.url + ApiConnections.TIME_SHEET_HEADER_TRANSACTION;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        TimeSheetHeaderTransactionBaseResponse baseResponse =
            TimeSheetHeaderTransactionBaseResponse.fromJson(userData);
        // add returned vacation to vacation list item view
        if (baseResponse.timesheetTransactions != null) {
          for (TimeSheetHeaderTransactionResponse timeSheet
              in baseResponse.timesheetTransactions) {
            TimeSheetHeaderListItem item = TimeSheetHeaderListItem(
                startDate: timeSheet.start_date,
                workingHour: timeSheet.work_hour,
                shiftTypeHour: timeSheet.shit_type_hour,
                differenceHour: timeSheet.difference_hour);

            _timeSheetHeaderListItem.add(item);
            _timeSheetHeaderList.add(timeSheet);
          }
        }
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  List<TimeSheetHeaderTransactionResponse> get timeSheetHeaderList =>
      _timeSheetHeaderList;

  set timeSheetHeaderList(List<TimeSheetHeaderTransactionResponse> value) {
    _timeSheetHeaderList = value;
  }

  List<TimeSheetHeaderListItem> get timeSheetHeaderListItem =>
      _timeSheetHeaderListItem;

  set timeSheetHeaderListItem(List<TimeSheetHeaderListItem> value) {
    _timeSheetHeaderListItem = value;
  }
}
