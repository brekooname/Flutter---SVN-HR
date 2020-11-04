import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/time_sheet/models/time_sheet_details_list_item.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/models/request/approval_object_request.dart';
import 'package:sven_hr/models/request/base_request.dart';
import 'package:sven_hr/models/request/new_time_sheet_details_base_request.dart';
import 'package:sven_hr/models/request/new_time_sheet_details_request.dart';
import 'package:sven_hr/models/request/new_time_sheet_header_base_request.dart';
import 'package:sven_hr/models/request/new_time_sheet_header_request.dart';
import 'package:sven_hr/models/request/time_sheet_request.dart';
import 'package:sven_hr/models/response/approval_object_base_response.dart';
import 'package:sven_hr/models/response/project_list_base_response.dart';
import 'package:sven_hr/models/response/project_list_response.dart';
import 'package:sven_hr/models/response/time_sheet_details_list_base_response.dart';
import 'package:sven_hr/models/response/time_sheet_details_list_response.dart';
import 'package:sven_hr/models/response/time_sheet_header_transaction_base_response.dart';
import 'package:sven_hr/models/response/time_sheet_header_transaction_response.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

import 'models/time_sheet_header_list_item.dart';

class TimeSheetController {
  List<TimeSheetHeaderListItem> _timeSheetHeaderListItem;

  List<TimeSheetHeaderTransactionResponse> _timeSheetHeaderList;

  List<TimeSheetDetailsListItem> _detalisListItem;

  List<TimeSheetDetailsResponse> _detalisList;

  List<ProjectListResponse> _projectList;

  DateFormat format = DateFormat(Const.DATE_FORMAT);

  Future<String> getDefualtSearch() async {
    DateTime now = new DateTime.now();
    String toDate = format.format(now);
    DateTime lastMonthDate = new DateTime(now.year, now.month, now.day - 1);
    String fromDate = format.format(lastMonthDate);

    String response = await getSelfTimeSheetHeaderTransaction(fromDate, toDate);
    return response;
  }

  Future<String> getSelfTimeSheetHeaderTransaction(
    String fromDate,
    String toDate,
  ) async {
    _timeSheetHeaderListItem = List();
    _timeSheetHeaderList = List();

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

  Future<String> addNewTimeSheetHeader({String startDate, String rowId}) async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    var url = ApiConnections.url + ApiConnections.ADD_TIME_SHEET_HEADER_REQUEST;

    NewTimeSheetHeaderRequest timesheetHeader = NewTimeSheetHeaderRequest();
    timesheetHeader.start_date = startDate;
    timesheetHeader.row_id = rowId;

    NewTimeSheetHeaderBaseRequest request = NewTimeSheetHeaderBaseRequest(
        tokenID: tokenId, timesheetHeader: timesheetHeader);

    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
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

  Future<String> addNewTimeSheetDetails(
      {num startTime,
      num endTime,
      String rowId,
      String status,
      String projectId,
      timeSheetId,
      String description}) async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    var url = ApiConnections.url + ApiConnections.ADD_TIME_SHEET_DETAILS;

    NewTimeSheetDetailsRequest timesheetDetails = NewTimeSheetDetailsRequest(
        start_time: startTime,
        end_time: endTime,
        status: status,
        project_id: projectId,
        employee_timesheet_id: timeSheetId,
        description: description,
    row_id: rowId);

    NewTimeSheetDetailsBaseRequest request = NewTimeSheetDetailsBaseRequest(
        tokenID: tokenId, timesheetDetails: timesheetDetails);

    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
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

  Future<String> getTimeSheetDetailsTransaction(
    String timeSheetRowId,
  ) async {
    _detalisListItem = List();
    _detalisList = List();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";

    BaseRequest baseRequest = BaseRequest(tokenID: tokenId);

    ApprovalObjectRequest request = ApprovalObjectRequest(
        tokenWrapper: baseRequest, par_row_id: timeSheetRowId);
    if (request != null) {
      var url = ApiConnections.url + ApiConnections.GET_TIME_SHEET_DETAILS_LIST;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        TimeSheetDetailsBaseResponse baseResponse =
            TimeSheetDetailsBaseResponse.fromJson(userData);
        // add returned vacation to vacation list item view
        if (baseResponse.listOfTimesheetDetails != null) {
          for (TimeSheetDetailsResponse details
              in baseResponse.listOfTimesheetDetails) {
            TimeSheetDetailsListItem item = TimeSheetDetailsListItem(
                startTime: details.start_time,
                endTime: details.end_time,
                projectName: details.project_name,
                status: details.status_display,
                workingHour: details.work_hour);

            _detalisListItem.add(item);
            _detalisList.add(details);
          }
        }
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  Future<String> getProjectList() async {
    _detalisListItem = List();
    _detalisList = List();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";

    BaseRequest request = BaseRequest(tokenID: tokenId);

    if (request != null) {
      var url = ApiConnections.url + ApiConnections.GET_PROJECTS_lIST;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        ProjectListBaseResponse baseResponse =
            ProjectListBaseResponse.fromJson(userData);
        // add returned vacation to vacation list item view
        if (baseResponse.projectListTransactions != null) {
          for (ProjectListResponse details
              in baseResponse.projectListTransactions) {
            projectList = baseResponse.projectListTransactions;
          }
        }
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }


  Future<List<LovValue>> loadProjectsType() async {
    LovValue lov = LovValue();
    try {
      return lov.getLovsByParentId(Const.TIME_SHEET_STATUS);
    } catch (e) {
      print(e);
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

  List<TimeSheetDetailsResponse> get detalisList => _detalisList;

  set detalisList(List<TimeSheetDetailsResponse> value) {
    _detalisList = value;
  }

  List<TimeSheetDetailsListItem> get detalisListItem => _detalisListItem;

  set detalisListItem(List<TimeSheetDetailsListItem> value) {
    _detalisListItem = value;
  }

  List<ProjectListResponse> get projectList => _projectList;

  set projectList(List<ProjectListResponse> value) {
    _projectList = value;
  }
}
