import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_mac/get_mac.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/models/request/approval_object_request.dart';
import 'package:sven_hr/models/request/base_request.dart';
import 'package:sven_hr/models/request/new_clock_check_request.dart';
import 'package:sven_hr/models/request/user_verification_base_request.dart';
import 'package:sven_hr/models/request/user_verification_request.dart';
import 'package:sven_hr/models/response/last_check_base_response.dart';
import 'package:sven_hr/models/response/last_check_response.dart';
import 'package:sven_hr/services/location.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/constants.dart';

class ClockRecordController {
  LastCheckResponse _lastCheck;

  LastCheckResponse get lastCheck => _lastCheck;

  set lastCheck(LastCheckResponse value) {
    _lastCheck = value;
  }

  Future<String> getLastCheck() async {
    LastCheckResponse lastCheck = LastCheckResponse();

    ApprovalObjectRequest request = ApprovalObjectRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";
    var employeeId = prefs.getString(Const.SHARED_KEY_EMPLOYEE_ID) ?? "";
    BaseRequest baseRequest = BaseRequest();

    baseRequest.tokenID = tokenId;
    request.tokenWrapper = baseRequest;
    request.par_row_id = employeeId;

    if (request != null) {
      var url = ApiConnections.url + ApiConnections.GET_LAST_CHECK;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        LastCheckBaseResponse baseResponse =
            LastCheckBaseResponse.fromJson(userData);
        // add returned vacation to vacation list item view
        if (baseResponse.checkWra != null) {
          _lastCheck = baseResponse.checkWra;
        }
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  String _platformVersion;

  Future<void> getDeviceMacAdress() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }
    _platformVersion = platformVersion;
  }

  Future<String> userVerification(
      {String networkBSSID, String clockType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";

    Location location = Location();
    await location.getCurrentLocation();

    await getDeviceMacAdress();

    UserVerificationRequest verificationRequest = UserVerificationRequest();
    if (location.longitude != null)
      verificationRequest.userLang = location.longitude.toString();
    else
      verificationRequest.userLang = "";

    if (location.latitude != null)
      verificationRequest.userLat = location.latitude.toString();
    else
      verificationRequest.userLat = "";

    verificationRequest.userMacAddress = _platformVersion;
    verificationRequest.userNetworkBSSID = networkBSSID;

    UserVerificationBaseRequest request = UserVerificationBaseRequest(
        tokenId: tokenId, userVerificationRequest: verificationRequest);

    if (request != null) {
      var url = ApiConnections.url + ApiConnections.USER_VERIFICATION;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        return newCheck(clockType);
      } else {
        return userData[Const.SYSTEM_MSG_CODE];
      }
    }
  }

  Future<String> newCheck(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";

    TimeOfDay now = TimeOfDay.now();
    DateTime now2 = DateTime.now();
    num clockTime =
        ApplicationController.formatTimetoNum(now.hour, now2.minute, now2.second);
    NewClockCheckRequest request = NewClockCheckRequest(
        tokenID: tokenId, clockTime: clockTime, clockType: type);

    if (request != null) {
      var url = ApiConnections.url + ApiConnections.NEW_CHECK;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        return userData[Const.SYSTEM_MSG_CODE];
      }
    }
  }
}
