import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/approval_inbox/approval_inbox_controller.dart';
import 'package:sven_hr/Screens/custom_drawer/notification_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/approval_inbox_list_response.dart';
import 'package:sven_hr/models/response/approval_object_response.dart';
import 'package:sven_hr/models/response/notification_list_response.dart';
import 'package:sven_hr/models/response/notifications_object_response.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class NotificationDetailsScreen extends StatefulWidget {
  static String id = "NotificationDetails";
  final String approvalInboxId;

  NotificationDetailsScreen({this.approvalInboxId});

  @override
  _NotificationDetailsScreenState createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  NotificationObjectResponse _notificationDetail;
  NotificationController _notificationController;

  bool showSpinner = false;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  @override
  void initState() {
    _notificationDetail = NotificationObjectResponse();
    _notificationController = NotificationController();
    geNotificationObject();
    super.initState();
  }

  void geNotificationObject() async {
    await _notificationController
        .geNotificationObject(this.widget.approvalInboxId)
        .then((value) {
      setState(() {
        print(value);
        _notificationDetail = _notificationController.notificationDetail;
      });
    });
  }

  void closeNotification() async {
    buttonSendIsPressed = true;
    showSpinner = true;

    await _notificationController
        .closeNotification(notifId: _notificationDetail.row_id)
        .then((value) {
      if (value == null) {
        ToastMessage.showErrorMsg(Const.REQUEST_FAILED);
      } else if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
        ToastMessage.showSuccessMsg(Const.VACATION_SENT_SUCCESSFULLY);
        Navigator.pop(context, value);
      } else {
        ToastMessage.showErrorMsg(value);
      }
      buttonSendIsPressed = false;
      showSpinner = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        child: Scaffold(
            body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    AppTranslations.of(context)
                        .text(Const.LOCALE_KEY_REQUEST_DETAILS),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 0.27,
                      color: AppTheme.kPrimaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Card(
                    color: AppTheme.kPrimaryLightColor,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.kPrimaryLightColor.withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _notificationDetail.message != null
                                ? _notificationDetail.message
                                : "-",
                            style: TextStyle(
                                color: AppTheme.kPrimaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          ListTile(
                            title: Text(AppTranslations.of(context)
                                .text(Const.LOCALE_KEY_ISSUE_DATE)),
                            subtitle: Text(
                                _notificationDetail.issue_date != null
                                    ? _notificationDetail.issue_date
                                    : "-"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ////-----------------------
                Expanded(
                  flex: 7,
                  child: Card(
                    color: AppTheme.kPrimaryLightColor,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.kPrimaryLightColor.withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ListTile(
                                  title: Text(AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_STATUS)),
                                  subtitle: Text(
                                      _notificationDetail.requestStatus != null
                                          ? _notificationDetail.requestStatus
                                          : "Date .."),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ListTile(
                                  title: Text(AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_EMPLOYEE_NUMBER)),
                                  subtitle: Text(
                                      _notificationDetail.employeeNumber != null
                                          ? _notificationDetail.employeeNumber
                                          : "-"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ListTile(
                                  title: Text(AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_EMPLOYEE_NAME)),
                                  subtitle: Text(
                                      _notificationDetail.employeeName != null
                                          ? _notificationDetail.requestStatus
                                          : "-"),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ListTile(
                                  title: Text(AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_EMPLOYMENT_CLASS)),
                                  subtitle: Text(
                                      _notificationDetail.employmentClass != null
                                          ? _notificationDetail.employmentClass
                                          : "-"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ///////----------------------
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          buttonClosedIsPressed = true;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          child: Container(
                            decoration: BoxDecoration(
                              color: buttonClosedIsPressed
                                  ? AppTheme.kPrimaryColor.withOpacity(0.1)
                                  : AppTheme.nearlyWhite,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              border: Border.all(
                                  color: AppTheme.grey.withOpacity(0.2)),
                            ),
                            child: Icon(
                              Icons.close,
                              color: AppTheme.nearlyBlue,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            closeNotification();
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: buttonSendIsPressed
                                  ? AppTheme.nearlyWhite.withOpacity(0.1)
                                  : AppTheme.nearlyBlue,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.nearlyBlue.withOpacity(0.5),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                AppTranslations.of(context)
                                    .text(Const.LOCALE_KEY_EMPLOYMENT_CLOSE),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  letterSpacing: 0.0,
                                  color: AppTheme.nearlyWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
