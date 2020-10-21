import 'package:fluttertoastalert/FlutterToastAlert.dart';

class ToastMessage {

  ToastMessage._();
 static void showErrorMsg(String msg) {
    FlutterToastAlert.showToastAndAlert(
        type: Type.Error,
        iosTitle: "Error",
        iosSubtitle: msg,
        androidToast: msg,
        toastDuration: 6,
        toastShowIcon: true);
  }

 static void showSuccessMsg(String msg) {
    FlutterToastAlert.showToastAndAlert(
        type: Type.Success,
        iosTitle: "Success",
        iosSubtitle: msg,
        androidToast: msg,
        toastDuration: 6,
        toastShowIcon: true);
  }

 static void showWarningMsg(String msg) {
    FlutterToastAlert.showToastAndAlert(
        type: Type.Warning,
        iosTitle: "Warning",
        iosSubtitle: msg,
        androidToast: msg,
        toastDuration: 6,
        toastShowIcon: true);
  }

 static void showNormalMsg(String msg) {
    FlutterToastAlert.showToastAndAlert(
        type: Type.Normal,
        iosTitle: "Normal",
        iosSubtitle: msg,
        androidToast: msg,
        toastDuration: 6,
        toastShowIcon: true);
  }
}
