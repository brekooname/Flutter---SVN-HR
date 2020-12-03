import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/models/request/expense_base_request.dart';
import 'package:sven_hr/models/request/expense_request.dart';
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
      String description}) async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    var url = ApiConnections.url + ApiConnections.ADD_EXPENSE;

    ExpenseRequest expenseRequest = ExpenseRequest();
    expenseRequest.currency_id = currency;
    expenseRequest.expense_amount = expenseAmount;
    expenseRequest.expense_date = expenseDate;
    expenseRequest.description = description;
    expenseRequest.employee_id=prefs.getString(Const.SHARED_KEY_EMPLOYEE_ID);

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
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return userData[Const.SYSTEM_MSG_CODE];
    }
  }
}
