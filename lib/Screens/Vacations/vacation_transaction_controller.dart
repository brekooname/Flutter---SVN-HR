
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/dao/vacation_type.dart';
import 'package:sven_hr/models/request/base_request.dart';
import 'package:sven_hr/models/request/new_vacation_base_request.dart';
import 'package:sven_hr/models/request/new_vacation_request.dart';
import 'package:sven_hr/models/request/vacation_transaction_request.dart';
import 'package:sven_hr/models/request/vacation_transaction_request_wrapper.dart';
import 'package:sven_hr/models/response/employee_vacation_base_response.dart';
import 'package:sven_hr/models/response/employee_vacation_response.dart';
import 'package:sven_hr/models/response/vacation_transaction_base_response.dart';
import 'package:sven_hr/models/response/vacation_transaction_response.dart';
import 'package:sven_hr/services/multi_part_file_upload.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';
import 'package:mime/mime.dart';

import 'models/vacation_list_item.dart';

class VacationTransactionController {
  List<VacationTransactionResponse> _vacationList;
  List<EmployeeVacationResponse> _employeeVactions;
  DateFormat format = DateFormat(Const.DATE_FORMAT);

  VacationTransactionController() {
    _vacationList = List();
  }

  Future<String> getDefualtSearch() async {
    DateTime now = new DateTime.now();
    String toDate = format.format(now);
    DateTime lastMonthDate = new DateTime(now.year, now.month - 1, now.day);
    String fromDate = format.format(lastMonthDate);
    List<String> statusList = [
      // Const.VACATION_REQUEST_PENDING_STATUS,
      // Const.VACATION_REQUEST_APPROVED_STATUS,
      // Const.VACATION_REQUEST_DECLINED_STATUS,
      // Const.VACATION_REQUEST_CANCELED_STATUS
    ];
    List<String> typeList = [
      // Const.VACATION_REQUEST_LOCATION_INTERNAL,
      // Const.VACATION_REQUEST_LOCATION_EXTERNAL
    ];

    String response =
        await getSelfVacation(fromDate, toDate, statusList, typeList);
    return response;
  }

  Future<List<LovValue>> loadVacationStatus() async {
    LovValue lov = LovValue();
    try {
      return lov.getLovsByParentId(Const.VACATION_REQUEST_STATUS);
    } catch (e) {
      print(e);
    }
  }

  Future<List<LovValue>> loadVacationLocation() async {
    LovValue lov = LovValue();
    try {
      return lov.getLovsByParentId(Const.VACATION_REQUEST_LOCATION);
    } catch (e) {
      print(e);
    }
  }

  Future<String> loadEmployeeVacationsBalance() async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    var url = ApiConnections.url + ApiConnections.Employee_Vacations;
    BaseRequest request = BaseRequest(tokenID: tokenId);
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE]
                .compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      EmployeeVacationBaseResponse reponse = EmployeeVacationBaseResponse();
      reponse = EmployeeVacationBaseResponse.fromJson(userData);
      print(reponse.employeeVacations.length);
      if (reponse.employeeVacations != null) {
        employeeVactions = reponse.employeeVacations;

        return Const.SYSTEM_SUCCESS_MSG;
      }
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return userData[Const.SYSTEM_MSG_CODE];
    }
  }

  Future<String> sendVacationRequest(
      {String fromDate,
      String toDate,
      String vacationId,
      String locationId,
      String notes,
      List<String> filePaths}) async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    var url = ApiConnections.url + ApiConnections.Add_New_Vacations;
    NewVacationRequest newVacationRequest = NewVacationRequest();
    newVacationRequest.vacation_id = vacationId;
    newVacationRequest.vacation_locaction = locationId;
    newVacationRequest.notes = notes;
    newVacationRequest.start_date = fromDate;
    newVacationRequest.end_date = toDate;
    NewVacationBaseRequest request =
        NewVacationBaseRequest(tokenID: tokenId, vac: newVacationRequest);
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE]
                .compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      String approval_inbox_row_id = userData[Const.APPROVAL_INBOX_ROW_ID];
      if (approval_inbox_row_id != null &&
          !approval_inbox_row_id.isEmpty &&
          filePaths != null &&
          !filePaths.isEmpty) {
        for(int i=0;i<filePaths.length;i++){
          String path=filePaths[i];
          String res = await uploadAttachment(
              filePath: path,
              tokenId: tokenId,
              approval_inbox_row_id: approval_inbox_row_id);
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
      {String filePath, String tokenId, String approval_inbox_row_id}) async {
    var url = ApiConnections.url + ApiConnections.UPLOAD_FILE;
    String fileNameWithExtenstion = filePath.split('/').last;
    String fileName=fileNameWithExtenstion.split('.').first;;
    String fileType =  fileNameWithExtenstion.split('.').last;
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

  Future<List<VacationType>> loadVacationTypes() async {
    VacationType vac = VacationType();
    try {
      return vac.getAllVacationsType();
    } catch (e) {
      print(e);
    }
  }

  Future<String> advancedSearch(String fromDate, String toDate,
      List<LovValue> statusList, List<VacationType> typeList) async {
    List<String> statusStringList = statusList
        .where((element) => element.isSelected)
        .map((e) => e.row_id)
        .toList();
    List<String> typeStringList = typeList
        .where((element) => element.isSelected)
        .map((e) => e.row_id)
        .toList();
    String response = await getSelfVacation(
        fromDate, toDate, statusStringList, typeStringList);
    return response;
  }

  Future<String> getSelfVacation(String fromDate, String toDate,
      List<String> statusList, List<String> typeList) async {
    vacationList = List();
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

    if (request != null) {
      var url = ApiConnections.url + ApiConnections.vacation_transaction;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        VacationTransactionBaseResponse baseResponse =
            VacationTransactionBaseResponse.fromJson(userData);
        // add returned vacation to vacation list item view
        if (baseResponse.vacationTransactions != null) {
          vacationList=baseResponse.vacationTransactions;
          // for (VacationTransactionResponse vac
          //     in baseResponse.vacationTransactions) {
          //   LovValue statusLov = LovValue();
          //   statusLov.row_id = vac.request_status;
          //   statusLov.code = vac.request_status_code;
          //   statusLov.display = vac.request_status_displayValue;
          //
          //   LovValue typeLov = LovValue();
          //   typeLov.row_id = vac.vacation_location;
          //   typeLov.code = vac.vacation_location_code;
          //   typeLov.display = vac.vacation_location_displayValue;
          //
          //   VacationListItem vacItem = VacationListItem(
          //       name: vac.vacation_Name,
          //       status: statusLov,
          //       type: typeLov,
          //       fromDate: vac.start_date,
          //       toDate: vac.end_date);
          //
          //   vacationList.add(vacItem);
          // }
        }
        print("Finshed");
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  List<VacationTransactionResponse> get vacationList => _vacationList;

  set vacationList(List<VacationTransactionResponse> value) {
    _vacationList = value;
  }

  List<EmployeeVacationResponse> get employeeVactions => _employeeVactions;

  set employeeVactions(List<EmployeeVacationResponse> value) {
    _employeeVactions = value;
  }
}
