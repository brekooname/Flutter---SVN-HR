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

class LoginController {
  SharedPreferences? prefs;
  static List<ProfileScreenResponse>? listOfProfileScreens;
  String? _username, _password;

  Future<dynamic> loginVerifications(String username, String password) async {
    prefs = await SharedPreferences.getInstance();
    this._username = username;
    this._password = password;

    // //check if user login or not
    // String prefTokenId = prefs.get(Const.SHARED_KEY_TOKEN_ID);
    // if (prefTokenId != null && !prefTokenId.isEmpty) {
    //   Navigator.pushNamed(context, NavigationHomeScreen.id);
    //   return;
    // }

    if (username.isEmpty) {
      ToastMessage.showErrorMsg(Const.INVALID_USERNAME_MSG);
      return null;
    }

    if (password.isEmpty) {
      ToastMessage.showErrorMsg(Const.INVALID_PASSWORD_MSG);
      return null;
    }

    try {
      bool? _isIntegrated = prefs!.getBool(Const.SHARED_KEY_IS_INTEGRATED);
      if (_isIntegrated == null) {
        _isIntegrated=false;
        return null;
      }
      print('username - loginVerifications '+username);
      print('password - loginVerifications '+password);
      print('_isIntegrated - loginVerifications '+_isIntegrated.toString());
      User user = User(
        username: username,
        password: password,
        netsuitFlag: _isIntegrated,
      );
      print('user.toJson() - loginVerifications '+user.toJson().toString());
      dynamic res = await getLoginAPI(user.toJson());
      print('res login API 1 getLoginApi - '+res);
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

  Future<String?> getLoginAPI(Map<String, dynamic> map) async {
    prefs = await SharedPreferences.getInstance();
    String? host = prefs!.getString(Const.SHARED_KEY_FULL_HOST_URL);
    if (host == null) {
      // Handle the null case, maybe with an error message
      return null;
    }
    var url = host + ApiConnections.login;
    print('url getLoginAPI '+url.toString());
    NetworkHelper helper = NetworkHelper(url: url, map: map);
    var userData = await helper.getData();
    print('userData getLoginAPI '+userData.toString());

    if (userData != null &&
        userData[Const.SYSTEM_MSG_CODE] != null &&
        userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      Employee employee = Employee();
      print('employee1 - get login API '+employee.toString());
      employee = Employee.fromJson(userData);
      print('employee2 - get login API '+employee.toString());
      _saveToSharedPreferences(employee);
      print('after save prefs API ');
      // String result = null;
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
            [loadLovValues(),
         loadVacationType(),
              getProfileScreen()
            ]);
        print('responses login controller load lovs 3 - '+responses.toString());
        if (responses.length > 0) {
          return Const.SYSTEM_SUCCESS_MSG;
        }
      } catch (e) {
        print("error after LOV future "+e.toString());
        return e.toString();
      }

      // if (result != null && result.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
      //   return employee.err_MSG;
      // } else {
      //   return result;
      // }
    } else {
      print("userData[Const.SYSTEM_MSG_CODE]" +userData[Const.SYSTEM_MSG_CODE]);
      return userData[Const.SYSTEM_MSG_CODE];
    }
  }

  void _saveToSharedPreferences(Employee employee) async {
    print('Getting SharedPreferences instance');
    prefs = await SharedPreferences.getInstance();

    String? serverIp = prefs!.getString(Const.SHARED_KEY_SERVER_IP);
    String? serverPort = prefs!.getString(Const.SHARED_KEY_SERVER_PORT);

    print('serverIp: $serverIp');
    print('serverPort: $serverPort');

    String imageUrl = ApiConnections.main_part + (serverIp ?? 'default_server_ip') + ":" + (serverPort ?? 'default_server_port');
    print('Constructed imageUrl: $imageUrl');
    prefs!.setString(Const.SHARED_KEY_EMPLOYEE_PIC_LINK, imageUrl);

    print('Saving username: ${_username ?? 'null'}');
    if (_username != null) {
      prefs!.setString(Const.SHARED_KEY_USERNAME, _username!);
    }

    print('Saving password: ${_password ?? 'null'}');
    if (_password != null) {
      prefs!.setString(Const.SHARED_KEY_PASSWORD, _password!);
    }

    print('Saving tokenId: ${employee.tokenId ?? 'null'}');
    if (employee.tokenId != null) {
      prefs!.setString(Const.SHARED_KEY_TOKEN_ID, employee.tokenId!);
    }

    print('Saving employee_number: ${employee.employee_number ?? 'null'}');
    if (employee.employee_number != null) {
      prefs!.setString(Const.SHARED_KEY_EMPLOYEE_NUMBER, employee.employee_number!);
    }

    print('Saving employee_id: ${employee.employee_id ?? 'null'}');
    if (employee.employee_id != null) {
      prefs!.setString(Const.SHARED_KEY_EMPLOYEE_ID, employee.employee_id!);
    }

    print('Saving position: ${employee.position ?? 'null'}');
    if (employee.position != null) {
      prefs!.setString(Const.SHARED_KEY_POSITION, employee.position!);
    }

    print('Saving department: ${employee.department ?? 'null'}');
    if (employee.department != null) {
      prefs!.setString(Const.SHARED_KEY_DEPARTMENT, employee.department!);
    }

    print('Saving email: ${employee.email ?? 'null'}');
    if (employee.email != null) {
      prefs!.setString(Const.SHARED_KEY_EMAIL, employee.email!);
    }

    print('Saving telephoneNumber: ${employee.telephoneNumber ?? 'null'}');
    if (employee.telephoneNumber != null) {
      prefs!.setString(Const.SHARED_KEY_TELEPHONE_NUMBER, employee.telephoneNumber!);
    }

    print('Saving employeeName: ${employee.employeeName ?? 'null'}');
    if (employee.employeeName != null) {
      prefs!.setString(Const.SHARED_KEY_EMPLOYEE_NAME, employee.employeeName!);
    }

    print('Saving reportingManager: ${employee.reportingManager ?? 'null'}');
    if (employee.reportingManager != null) {
      prefs!.setString(Const.SHARED_KEY_REPORTING_MANAGER, employee.reportingManager!);
    }

    if (employee.salary != null) {
      print('Saving basic_salary: ${employee.salary.basic_salary?.toDouble() ?? 'null'}');
      if (employee.salary.basic_salary != null) {
        prefs!.setDouble(Const.SHARED_KEY_BASIC_SALARY, employee.salary.basic_salary!.toDouble());
      }

      print('Saving currency_id_displayValue: ${employee.salary.currency_id_displayValue ?? 'null'}');
      if (employee.salary.currency_id_displayValue != null) {
        prefs!.setString(Const.SHARED_KEY_CURRENCY_CODE, employee.salary.currency_id_displayValue!);
      }
    }

    print('End of save prefs');
  }
  Future<String> loadLovValues() async {
    final prefs = await SharedPreferences.getInstance();
    String? tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host! + ApiConnections.lov_values;
    LovValuesRequest request = LovValuesRequest(tokenID: tokenId!);
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();

    print('Response Data (LovValues): $userData');

    if (userData != null && userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {

      try {
        await LovValue().delete();
      } catch (e) {
        print('Error deleting old LovValues2: $e');
      }

      LovValuesResponse response = LovValuesResponse.fromJson(userData);
      print('Parsed Response (LovValues): $response');

      for (LovValues lov in response.lovs!) {
        print('Processing LovValue: $lov');
        LovValue value = LovValue();
        value.parent = lov.par_row_id;
        value.row_id = lov.row_id;
        value.code = lov.code;
        value.display = lov.dispaly_value;

        try {
          await value.insert(value);
          print('Inserted LovValue: $value');
        } catch (e) {
          print('Error inserting LovValue2: $e');
        }
      }
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      print('Error in response: ${userData[Const.SYSTEM_MSG_CODE]}');
      return Const.SYSTEM_MSG_CODE;
    }
  }

  Future<String> loadVacationType() async {
    final prefs = await SharedPreferences.getInstance();
    String? tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host! + ApiConnections.Vacations_type;
    BaseRequest request = BaseRequest(tokenID: tokenId!);
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
      print("reponse1. get vac types "+reponse.toString());
      reponse = VacationTypeBaseResponse.fromJson(userData);
      print("reponse2. get vac types "+reponse.toString());
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

      // print("Vacation Type load finished");
      // VacationType vacationType = VacationType();
      // List<VacationType> list = await vacationType.getAllVacationsType();
      // print(list.length);
      return Const.SYSTEM_SUCCESS_MSG;
        } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return Const.SYSTEM_MSG_CODE;
    }
  }

  Future<String> getProfileScreen() async {
    final prefs = await SharedPreferences.getInstance();
    String? tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host! + ApiConnections.PROFILE_SCREEN;
    BaseRequest request = BaseRequest(tokenID: tokenId!);
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE]
            .compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      ProfileScreenBaseResponse reponse = ProfileScreenBaseResponse();
      print('reponse1 getProfileScreens '+reponse.toString());
      reponse = ProfileScreenBaseResponse.fromJson(userData);
      print('reponse2 getProfileScreens '+reponse.toString());

      if (reponse.listOfAllScreensDisplay.isNotEmpty) {
        print("Response contains screens, proceeding to filter and assign.");

        // Print the count of screens before filtering
        print("Total screens before filtering: ${reponse.listOfAllScreensDisplay.length}");

        listOfProfileScreens = [];
        listOfProfileScreens = reponse.listOfAllScreensDisplay
            .where((element) {
          // Print each screen's name and its displayFlag
          print("Screen Name: ${element.screenName}, Display Flag: ${element.displayFlag}");
          return element.displayFlag;
        }).toList();

        // Print the count of screens after filtering
        print("Total screens after filtering: ${listOfProfileScreens!.length}");
      } else {
        print("Response listOfAllScreensDisplay is empty or null.");
      }
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return Const.SYSTEM_MSG_CODE;
    }
  }
}
