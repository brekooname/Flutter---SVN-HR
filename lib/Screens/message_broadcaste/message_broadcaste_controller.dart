import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/models/request/base_request.dart';
import 'package:sven_hr/models/response/message_broadcaste_base_response.dart';
import 'package:sven_hr/models/response/message_broadcaste_response.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

class MessageBroadcasteController {
  List<MessageBroadcasteResponse> _messageList;

  MessageBroadcasteController() {
    _messageList = List();
  }

  Future<String> getMessageBroadcasteList() async {
    _messageList = List();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";

    BaseRequest request = BaseRequest(tokenID: tokenId);
    if (request != null) {
      var url = ApiConnections.url + ApiConnections.GET_MESSAGES;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        MessageBroadcasteBaseResponse baseResponse =
            MessageBroadcasteBaseResponse.fromJson(userData);

        if (baseResponse.messageList != null) {
          _messageList = baseResponse.messageList;
        }
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  List<MessageBroadcasteResponse> get messageList => _messageList;

  set messageList(List<MessageBroadcasteResponse> value) {
    _messageList = value;
  }
}
