import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/dao/vacation_type.dart';
import 'package:sven_hr/models/request/base_request.dart';
import 'package:sven_hr/models/request/lov_value_request.dart';
import 'package:sven_hr/models/request/user.dart';
import 'package:sven_hr/models/response/employee.dart';
import 'package:sven_hr/models/response/lov_value_response.dart';
import 'package:sven_hr/models/response/lov_values.dart';
import 'package:sven_hr/models/response/profile_screen_base_response.dart';
import 'package:sven_hr/models/response/profile_screen_response.dart';
import 'package:sven_hr/models/response/vacation_type_base_response.dart';
import 'package:sven_hr/models/response/vacation_type_response.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/utilities/database_helpers.dart';

import '../navigation_home_screen.dart';

class LoginController {
  SharedPreferences prefs;
  static List<ProfileScreenResponse> listOfProfileScreens;
  String _username , _password;

  Future<dynamic> loginVerifications(String username, String password) async {
    prefs = await SharedPreferences.getInstance();
    this._username=username;
    this._password=password;

    // //check if user login or not
    // String prefTokenId = prefs.get(Const.SHARED_KEY_TOKEN_ID);
    // if (prefTokenId != null && !prefTokenId.isEmpty) {
    //   Navigator.pushNamed(context, NavigationHomeScreen.id);
    //   return;
    // }

    if (username == null || username.isEmpty) {
      ToastMessage.showErrorMsg(Const.INVALID_USERNAME_MSG);
      return null;
    }

    if (password == null || password.isEmpty) {
      ToastMessage.showErrorMsg(Const.INVALID_PASSWORD_MSG);
      return null;
    }

    try {
      bool _isIntegrated = prefs.getBool(Const.SHARED_KEY_IS_INTEGRATED);
      User user =
          User(username: username, password: password, netsuitFlag: _isIntegrated);
      dynamic res = await getLoginAPI(user.toJson());
      if (res != null &&
          res.toString().compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
        // Navigator.pop(context);
        // Navigator.pushNamed(context, NavigationHomeScreen.id);
        return res;
      } else {
        ToastMessage.showErrorMsg(res.toString());
      }
    } catch (e) {
      print(e);
      ToastMessage.showErrorMsg(e.toString());
    }
  }

  Future<String> getLoginAPI(Map<String, dynamic> map) async {
    String host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host + ApiConnections.login;
    NetworkHelper helper = NetworkHelper(url: url, map: map);
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_MSG_CODE] != null &&
        userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      Employee employee = Employee();
      employee = Employee.fromJson(userData);

      await _saveToSharedPreferences(employee);
      String result = null;
      // String result = await loadLovValues();
      // await loadVacationType();
      // Future.wait([loadLovValues(), loadVacationType()])
      //     .then((List value) => () {
      //           print(value.length);
      //          return Const.SYSTEM_SUCCESS_MSG;
      //         })
      //     .catchError((e) => () {
      //       result=e;
      // });

      try {
        List responses = await Future.wait(
            [loadLovValues(), loadVacationType(), getProfileScreen()]);
        if (responses != null && responses.length > 0) {
          return Const.SYSTEM_SUCCESS_MSG;
        }
      } catch (e) {
        print(e);
        return e;
      }

      // if (result != null && result.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
      //   return employee.err_MSG;
      // } else {
      //   return result;
      // }
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return userData[Const.SYSTEM_MSG_CODE];
    }
  }

  void _saveToSharedPreferences(Employee employee) async {

    String server_ip = prefs.getString(Const.SHARED_KEY_SERVER_IP);
    String server_port = prefs.getString(Const.SHARED_KEY_SERVER_PORT);
    String imageUrl=ApiConnections.main_part+server_ip+":"+server_port;

    prefs.setString(Const.SHARED_KEY_USERNAME, _username);
    prefs.setString(Const.SHARED_KEY_PASSWORD, _password);
    prefs.setString(Const.SHARED_KEY_TOKEN_ID, employee.tokenId);
    prefs.setString(Const.SHARED_KEY_EMPLOYEE_NUMBER, employee.employee_number);
    prefs.setString(Const.SHARED_KEY_EMPLOYEE_ID, employee.employee_id);
    prefs.setString(Const.SHARED_KEY_POSITION, employee.position);
    prefs.setString(Const.SHARED_KEY_DEPARTMENT, employee.department);
    prefs.setString(Const.SHARED_KEY_EMAIL, employee.email);
    prefs.setString(
        Const.SHARED_KEY_TELEPHONE_NUMBER, employee.telephoneNumber);
    prefs.setString(
        Const.SHARED_KEY_EMPLOYEE_PIC_LINK, imageUrl+employee.employee_profile_pic_link);
    prefs.setString(Const.SHARED_KEY_EMPLOYEE_NAME, employee.employeeName);
    prefs.setString(
        Const.SHARED_KEY_REPORTING_MANAGER, employee.reportingManager);

    if (employee.salary != null) {
      if (employee.salary.basic_salary != null)
        prefs.setInt(
            Const.SHARED_KEY_BASIC_SALARY, employee.salary.basic_salary);
      if (employee.salary.currency_id_displayValue != null)
        prefs.setString(Const.SHARED_KEY_CURRENCY_CODE,
            employee.salary.currency_id_displayValue);
    }
  }

  Future<String> loadLovValues() async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host+ ApiConnections.lov_values;
    LovValuesRequest request = LovValuesRequest(tokenID: tokenId);
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE]
                .compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      // free Lov table

      try {
        await LovValue().delete();
      } catch (e) {
        print(e);
      }
      LovValuesResponse reponse = LovValuesResponse();
      reponse = LovValuesResponse.fromJson(userData);
      print(reponse.lovs.length);
      if (reponse.lovs != null) {
        for (LovValues lov in reponse.lovs) {
          LovValue value = LovValue();
          value.parent = lov.par_row_id;
          value.row_id = lov.row_id;
          value.code = lov.code;
          value.display = lov.dispaly_value;
          await value.insert(value);
        }
        // LovValue value = LovValue();
        // value = await value.getLovsByParentId("1465822047681");
        print("Lov load finished");
        return Const.SYSTEM_SUCCESS_MSG;
      }
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return Const.SYSTEM_MSG_CODE;
    }
  }

  Future<String> loadVacationType() async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host + ApiConnections.Vacations_type;
    BaseRequest request = BaseRequest(tokenID: tokenId);
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE]
                .compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      // free Vacation type table
      try {
        await VacationType().delete();
      } catch (e) {
        print(e);
      }
      VacationTypeBaseResponse reponse = VacationTypeBaseResponse();
      reponse = VacationTypeBaseResponse.fromJson(userData);
      print(reponse.vacations.length);
      if (reponse.vacations != null) {
        for (VacationTypeResponse vac in reponse.vacations) {
          VacationType value = VacationType();
          value.name = vac.name;
          value.approval_flg = vac.approval_flg;
          value.createddate = vac.createddate;
          value.balance_sign = vac.balance_sign;
          value.balance_sign_displayValue = vac.balance_sign_displayValue;
          value.balance_sign_code = vac.balance_sign_code;
          value.active_flg = vac.active_flg;
          value.updatedby = vac.updatedby;
          value.row_id = vac.row_id;
          value.permission_method = vac.permission_method;
          value.description = vac.description;
          value.createdby = vac.createdby;
          value.updatedate = vac.updatedate;
          value.default_balance = vac.default_balance;

          await value.insert(value);
        }

        print("Vacation Type load finished");
        // VacationType vacationType = VacationType();
        // List<VacationType> list = await vacationType.getAllVacationsType();
        // print(list.length);
        return Const.SYSTEM_SUCCESS_MSG;
      }
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return Const.SYSTEM_MSG_CODE;
    }
  }

  Future<String> getProfileScreen() async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host + ApiConnections.PROFILE_SCREEN;
    BaseRequest request = BaseRequest(tokenID: tokenId);
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE]
                .compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      ProfileScreenBaseResponse reponse = ProfileScreenBaseResponse();
      reponse = ProfileScreenBaseResponse.fromJson(userData);
      if (reponse.listOfAllScreensDisplay != null &&
          !reponse.listOfAllScreensDisplay.isEmpty) {
        listOfProfileScreens = List();
        listOfProfileScreens = reponse.listOfAllScreensDisplay
            .where((element) => element.displayFlag)
            .toList();
      }
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return Const.SYSTEM_MSG_CODE;
    }
  }
}
