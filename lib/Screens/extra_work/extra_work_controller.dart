import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/models/request/expense_transaction_request.dart';
import 'package:sven_hr/models/request/extra_work_base_request.dart';
import 'package:sven_hr/models/request/extra_work_request.dart';
import 'package:sven_hr/models/response/extra_work_transaction_base_response.dart';
import 'package:sven_hr/models/response/extra_work_transaction_response.dart';
import 'package:sven_hr/services/multi_part_file_upload.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

class ExtraWorkController {
  DateFormat format = DateFormat(Const.DATE_FORMAT);

  List<ExtraWorkTransactionResponse> _extraWorkList;

  Future<List<LovValue>> loadDayType() async {
    LovValue lov = LovValue();
    try {
      return lov.getLovsByParentId(Const.DAY_TYPE);
    } catch (e) {
      print(e);
    }
  }

  Future<List<LovValue>> loadUnit() async {
    LovValue lov = LovValue();
    try {
      return lov.getLovsByParentId(Const.EMPLOYEE_EXTRA_WORK_UNIT);
    } catch (e) {
      print(e);
    }
  }

  Future<String> sendExtraWorkRequest(
      {String dayType,
      String unit,
      num unitQuantity,
      String notes,
      List<String> filePaths}) async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host + ApiConnections.ADD_EXTRA_WORK;

    ExtraWorkRequest extraWorkRequest = ExtraWorkRequest();
    extraWorkRequest.employee_id =
        prefs.getString(Const.SHARED_KEY_EMPLOYEE_ID);
    extraWorkRequest.day_type = dayType;
    extraWorkRequest.unit = unit;
    extraWorkRequest.unit_quantity = unitQuantity;
    extraWorkRequest.extra_details = notes;

    ExtraWorkBaseRequest request = ExtraWorkBaseRequest(
        tokenID: tokenId, extraWorkTrans: extraWorkRequest);

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
        for (int i = 0; i < filePaths.length; i++) {
          String path = filePaths[i];
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host + ApiConnections.UPLOAD_FILE;
    String fileNameWithExtenstion = filePath.split('/').last;
    String fileName = fileNameWithExtenstion.split('.').first;
    ;
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

  Future<String> getDefualtSearch() async {
    DateTime now = new DateTime.now();
    String toDate = format.format(now);
    DateTime lastMonthDate = new DateTime(now.year, now.month, now.day - 1);
    String fromDate = format.format(lastMonthDate);

    String response = await getExtraWorkTransaction(fromDate, toDate);
    return response;
  }

  Future<String> getExtraWorkTransaction(
    String fromDate,
    String toDate,
  ) async {
    extraWorkList = List();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";
    String host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    ExpenseTransactionRequest request = ExpenseTransactionRequest(
        tokenId: tokenId, fromDate: fromDate, toDate: toDate);
    if (request != null) {
      var url = host + ApiConnections.GET_EXTRA_WORK_TRANSACTION;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        ExtraWorkTransactionBaseResponse baseResponse =
            ExtraWorkTransactionBaseResponse.fromJson(userData);

        if (baseResponse.extraWorkList != null) {
          extraWorkList = baseResponse.extraWorkList;
        }
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  List<ExtraWorkTransactionResponse> get extraWorkList => _extraWorkList;

  set extraWorkList(List<ExtraWorkTransactionResponse> value) {
    _extraWorkList = value;
  }
}
