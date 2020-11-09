import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/models/request/new_location_request.dart';
import 'package:sven_hr/models/request/new_network_request.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

class APPSettingsController {
  Future<String> addNewLocation(
      {
      String latitude,
      String longitude,
      String locationName,
      num locationRange}) async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    var url = ApiConnections.url + ApiConnections.ADD_NEW_LOCATION;

    NewLocationRequest request = NewLocationRequest(
        tokenId: tokenId,
        latitude: latitude,
        locationName: locationName,
        longitude: longitude,
        locationRange: locationRange);

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

  Future<String> addNewNetwork(
      {
      String wifiName,
      String wifiBSSID,
      String wifiIP}) async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    var url = ApiConnections.url + ApiConnections.ADD_NEW_NETWORK;

    NewNetworkRequest request = NewNetworkRequest(
        tokenId: tokenId,
        connectionBSSID: wifiBSSID,
        connectionName: wifiName,
        connectionIP: wifiIP);

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
