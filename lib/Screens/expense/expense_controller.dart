import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/models/request/expense_base_request.dart';
import 'package:sven_hr/models/request/expense_request.dart';
import 'package:sven_hr/models/request/expense_transaction_request.dart';
import 'package:sven_hr/models/response/expense_transaction_base_response.dart';
import 'package:sven_hr/models/response/expense_transaction_response.dart';
import 'package:sven_hr/services/multi_part_file_upload.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';

class ExpenseController {
  DateFormat format = DateFormat(Const.DATE_FORMAT);

  List<ExpenseTransactionResponse>? _expenseList;

  ExpenseController() {
    _expenseList = <ExpenseTransactionResponse>[];
  }

  Future<List<LovValue>?> loadCurrency() async {
    LovValue lov = LovValue();
    try {
      return lov.getLovsByParentId(Const.CURRENCY);
    } catch (e) {
      print(e);
    }
  }

  Future<String> sendExpenseRequest(
      {String? currency,
      num? expenseAmount,
      String? expenseDate,
      String? description,
      List<String>? filePaths}) async {
    final prefs = await SharedPreferences.getInstance();
    String? tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);
    var url = host! + ApiConnections.ADD_EXPENSE;

    ExpenseRequest expenseRequest = ExpenseRequest();
    expenseRequest.currency_id = currency;
    expenseRequest.expense_amount = expenseAmount;
    expenseRequest.expense_date = expenseDate;
    expenseRequest.description = description;
    expenseRequest.employee_id = prefs.getString(Const.SHARED_KEY_EMPLOYEE_ID);

    ExpenseBaseRequest request =
        ExpenseBaseRequest(tokenID: tokenId, expenseTrans: expenseRequest);

    print(expenseRequest.toJson().toString());
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
              tokenId: tokenId!,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
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

  Future<String> getDefualtSearch(BuildContext context) async {
    DateTime now = new DateTime.now();
    String toDate = format.format(now);
    DateTime lastMonthDate = new DateTime(now.year, now.month, now.day - 7);
    String fromDate = format.format(lastMonthDate);

    String? response = await getExpenseTransaction(fromDate, toDate);
    // print(' default search expense response ' + response.toString()!);
    if (_expenseList!.isEmpty && response == null) {
      showNoDataDialog(context);
    }
    return response!;
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

  Future<String?> getExpenseTransaction(
    String fromDate,
    String toDate,
  ) async {
    _expenseList = <ExpenseTransactionResponse>[];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    ExpenseTransactionRequest request = ExpenseTransactionRequest(
        tokenId: tokenId, fromDate: fromDate, toDate: toDate);
    var url = host! + ApiConnections.GET_EXPENSE_TRANSACTION;
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_MSG_CODE] != null &&
        userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      ExpenseTransactionBaseResponse baseResponse =
          ExpenseTransactionBaseResponse.fromJson(userData);

      _expenseList = baseResponse.expenseList;
          return Const.SYSTEM_SUCCESS_MSG;
    } else {
      // ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
    }
    }

  List<ExpenseTransactionResponse> get expenseList => _expenseList!;

  set expenseList(List<ExpenseTransactionResponse> value) {
    _expenseList = value;
  }
}
