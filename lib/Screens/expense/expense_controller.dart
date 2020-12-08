import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/models/request/expense_base_request.dart';
import 'package:sven_hr/models/request/expense_request.dart';
import 'package:sven_hr/services/multi_part_file_upload.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

class ExpenseController {
  Future<List<LovValue>> loadCurrency() async {
    LovValue lov = LovValue();
    try {
      return lov.getLovsByParentId(Const.CURRENCY);
    } catch (e) {
      print(e);
    }
  }

  Future<String> sendExpenseRequest(
      {String currency,
      num expenseAmount,
      String expenseDate,
      String description,
      List<String> filePaths}) async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    var url = ApiConnections.url + ApiConnections.ADD_EXPENSE;

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
    var url = ApiConnections.url + ApiConnections.UPLOAD_FILE;
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
}
