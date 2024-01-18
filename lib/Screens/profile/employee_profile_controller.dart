import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/models/request/new_password_request.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

class EmployeeProfileController {
  Future<String> changePasswordRequest(
      {
      String? oldPassword,
      String? newPassword,
      String? confirmedPassword}) async {
    final prefs = await SharedPreferences.getInstance();
    String? tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host! + ApiConnections.CHANGE_PASSWORD;

    NewPasswordRequest request = NewPasswordRequest(
        tokenID: tokenId!,
        newPassword: newPassword!,
        oldPassword: oldPassword!,
        repatedPassword: confirmedPassword!);

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
