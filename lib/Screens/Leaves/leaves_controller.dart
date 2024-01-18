import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/models/request/new_leave_base_request.dart';
import 'package:sven_hr/models/request/new_leave_request.dart';
import 'package:sven_hr/models/request/vacation_transaction_request.dart';
import 'package:sven_hr/models/request/vacation_transaction_request_wrapper.dart';
import 'package:sven_hr/models/response/leave_transaction_base_response.dart';
import 'package:sven_hr/models/response/leave_transaction_response.dart';
import 'package:sven_hr/services/multi_part_file_upload.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';

class LeavesController {
  List<LeaveTransactionResponse>? _leaveList;
  DateFormat? format = DateFormat(Const.DATE_FORMAT);
  DateFormat? dateTimeFormat = DateFormat(Const.DATE_TIME_FORMAT);

  LeavesController() {
    _leaveList = <LeaveTransactionResponse>[];
  }

  Future<List<LovValue>?> loadLeavesStatus() async {
    LovValue lov = LovValue();
    try {
      return lov.getLovsByParentId(Const.LEAVE_REQUEST_STATUS);
    } catch (e) {
      print(e);
    }
  }

  Future<List<LovValue>?> loadLeavesType() async {
    LovValue lov = LovValue();
    try {
      return lov.getLovsByParentId(Const.LEAVE_TYPE);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getDefualtSearch(BuildContext context) async {
    DateTime now = new DateTime.now();
    String toDate = format!.format(now);
    DateTime lastMonthDate = new DateTime(now.year, now.month  , now.day-7);
    String fromDate = format!.format(lastMonthDate);
    List<String> statusList = [];
    List<String> typeList = [];

    String? response =
        await getSelfLeaves(fromDate, toDate, statusList, typeList);
    if (leaveList!.isEmpty && response == 'SUCCESS') {
      showNoDataDialog(context);
    }
    return response!;
  }

  Future<String> advancedSearch(String fromDate, String toDate,
      List<LovValue> statusList, List<LovValue> typeList) async {
    List<String> statusStringList = statusList
        .where((element) => element.isSelected)
        .map((e) => e.row_id)
        .toList();
    List<String> typeStringList = typeList
        .where((element) => element.isSelected)
        .map((e) => e.row_id)
        .toList();
    String? response =
        await getSelfLeaves(fromDate, toDate, statusStringList, typeStringList);
    return response!;
  }

  Future<String?> getSelfLeaves(String fromDate, String toDate,
      List<String> statusList, List<String> typeList) async {
    leaveList =<LeaveTransactionResponse>[];
    // use same vacation request beacuse leave request take same input
    VacationTransactionRequest request = VacationTransactionRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";
    request.tokenID = tokenId;
    VacationTransactionRequestWrapper requestWrapper =
        VacationTransactionRequestWrapper();
    requestWrapper.fromDate = fromDate;
    requestWrapper.toDate = toDate;
    requestWrapper.statusList = statusList;
    requestWrapper.typeList = typeList;
    request.vac = requestWrapper;
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url  = host! + ApiConnections.LEAVES_TRANSACTION;
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_MSG_CODE] != null &&
        userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      LeaveTransactionBaseResponse baseResponse =
          LeaveTransactionBaseResponse.fromJson(userData);
      // add returned leaves to leaves list item view
      leaveList = baseResponse.leaveTransactions;
      // for (LeaveTransactionResponse vac in baseResponse.leaveTransactions) {
      //   LovValue statusLov = LovValue();
      //   statusLov.row_id = vac.request_status;
      //   statusLov.code = vac.request_status_code;
      //   statusLov.display = vac.request_status_displayValue;
      //
      //   LovValue typeLov = LovValue();
      //   typeLov.row_id = vac.leave_id;
      //   typeLov.code = vac.leave_code;
      //   typeLov.display = vac.leave_displayValue;
      //
      //   LeaveListItem levItem = LeaveListItem(
      //       status: statusLov,
      //       type: typeLov,
      //       fromDate: vac.start_date,
      //       toDate: vac.end_date,
      //       toTime: vac.end_time_String,
      //       fromTime: vac.start_time_String);
      //
      //   leaveList.add(levItem);
      // }
          // print("Finshed");
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
    }
    }
  void showNoDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: ModernTheme.backgroundColor, // Use your preferred background color
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.info_outline,
                  color: ModernTheme.accentColor, // Use your preferred accent color
                  size: 50.0, // Icon size
                ),
                SizedBox(height: 20.0),
                Text(
                  'No Data Found',
                  style: TextStyle(
                    color: ModernTheme.textColor, // Use your preferred text color
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'No results match your search criteria. Please try again.',
                  style: TextStyle(
                    color: ModernTheme.textColor, // Use your preferred text color
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ModernTheme.accentColor, // Use your preferred accent color
                    elevation: 5, // Button elevation
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<LeaveTransactionResponse> get leaveList => _leaveList!;

  set leaveList(List<LeaveTransactionResponse> value) {
    _leaveList = value;
  }

  Future<String> sendLeaveRequest(
      {String? fromDate,
      String? toDate,
      String? leaveId,
      String? notes,
      List<String>? filePaths}) async {
    final prefs = await SharedPreferences.getInstance();
    String? tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host! + ApiConnections.ADD_NEW_LEAVE;
    NewLeaveRequest newLeaveRequest = NewLeaveRequest();
    newLeaveRequest.leave_id = leaveId!;
    newLeaveRequest.notes = notes!;
    newLeaveRequest.start_date = fromDate!;
    newLeaveRequest.end_date = toDate!;

    NewLeaveBaseRequest request =
        NewLeaveBaseRequest(tokenID: tokenId!, leaveTrans: newLeaveRequest);
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE]
                .compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      String approvalInboxRowId = userData[Const.APPROVAL_INBOX_ROW_ID];
      if (approvalInboxRowId.isNotEmpty &&
          filePaths!.isNotEmpty) {
        for (int i = 0; i < filePaths.length; i++) {
          String path = filePaths[i];
          String res = await uploadAttachment(
              filePath: path,
              tokenId: tokenId,
              approval_inbox_row_id: approvalInboxRowId);
          print(path);
        }
      }
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return userData[Const.SYSTEM_MSG_CODE];
    }
  }

  Future<String> uploadAttachment(
      {String? filePath, String? tokenId, String? approval_inbox_row_id}) async {
    final prefs = await SharedPreferences.getInstance();

    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host! + ApiConnections.UPLOAD_FILE;
    String fileNameWithExtenstion = filePath!.split('/').last;
    String fileName = fileNameWithExtenstion.split('.').first;
    String fileType = fileNameWithExtenstion.split('.').last;
    MultiPartFileUpload request = MultiPartFileUpload(
        url: url,
        filePath: filePath,
        file_name: fileName,
        file_type: fileType,
        token_id: tokenId,
        approval_inbox_row_id: approval_inbox_row_id);

    var userData = await request.getData();
    return userData;
    if (userData != null &&
        userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE]
                .compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return userData[Const.SYSTEM_MSG_CODE];
    }
  }
}
