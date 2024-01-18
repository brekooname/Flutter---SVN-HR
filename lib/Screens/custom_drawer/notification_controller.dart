import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/models/request/approval_object_request.dart';
import 'package:sven_hr/models/request/base_request.dart';
import 'package:sven_hr/models/request/notification_close_request.dart';
import 'package:sven_hr/models/response/notification_list_base_response.dart';
import 'package:sven_hr/models/response/notification_list_response.dart';
import 'package:sven_hr/models/response/notifications_object_base_response.dart';
import 'package:sven_hr/models/response/notifications_object_response.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

class NotificationController {
  List<NotificationListResponse>? _notificationList;
  NotificationObjectResponse? _notificationDetail;

  List<NotificationListResponse> get notificationList => _notificationList!;

  set notificationList(List<NotificationListResponse> value) {
    _notificationList = value;
  }

  NotificationObjectResponse get notificationDetail => _notificationDetail!;

  set notificationDetail(NotificationObjectResponse value) {
    _notificationDetail = value;
  }

  Future<String?> getLastNotifications() async {
    _notificationList = <NotificationListResponse>[];
    BaseRequest request = BaseRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";
    request.tokenID = tokenId;
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host! + ApiConnections.GET_ALL_NOTIFICATION_LIST;
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_MSG_CODE] != null &&
        userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      NotificationListBaseResponse baseResponse =
          NotificationListBaseResponse.fromJson(userData);
      for (NotificationListResponse inbox
          in baseResponse.listOfAllNotifications) {
        _notificationList = baseResponse.listOfAllNotifications;
      }
    
      // print("Finshed");
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
    }
    }

  Future<String?> geNotificationObject(String approvalInboxId) async {
    _notificationDetail = NotificationObjectResponse();
    ApprovalObjectRequest request = ApprovalObjectRequest();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";
    BaseRequest baseRequest = BaseRequest();
    baseRequest.tokenID = tokenId;
    request.tokenWrapper = baseRequest;
    request.par_row_id = approvalInboxId;
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host! + ApiConnections.GET_NOTIFICATION_OBJECT;
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_MSG_CODE] != null &&
        userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      NotificationObjectBaseResponse baseResponse =
          NotificationObjectBaseResponse.fromJson(userData);
      // add returned vacation to vacation list item view
      _notificationDetail = baseResponse.notificationObject;
          // print("Finshed");
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
    }
    }

  Future<String> closeNotification({String? notifId}) async {
    final prefs = await SharedPreferences.getInstance();
    String? tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    String? host = prefs.getString(Const.SHARED_KEY_FULL_HOST_URL);

    var url = host! + ApiConnections.CLOSE_NOTIFICATION;

    NotificationCloseRequest request =
        NotificationCloseRequest(tokenId: tokenId, notifId: notifId);
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
