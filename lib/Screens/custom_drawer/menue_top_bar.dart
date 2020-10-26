import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/Screens/approval_inbox/models/approval_inbox_item_list.dart';
import 'package:sven_hr/Screens/approval_inbox/request_details_screen.dart';
import 'package:sven_hr/Screens/custom_drawer/notification_controller.dart';
import 'package:sven_hr/Screens/custom_drawer/notifications_details.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/localization/app_translations_delegate.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/approval_inbox_list_response.dart';
import 'package:sven_hr/models/response/notification_list_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import 'drawer_user_controller.dart';

class MenueTopBar extends StatefulWidget {
  final String screenName;

  MenueTopBar({@required this.screenName});

  @override
  _MenueTopBarState createState() =>
      _MenueTopBarState();
}

class _MenueTopBarState extends State<MenueTopBar> {
  int counter=0;
  List<NotificationListResponse> notificationList;
  NotificationController _notificationController = NotificationController();

  @override
  void initState() {
    getLastNotifications();
    super.initState();
  }

  void getLastNotifications() async {
    await _notificationController.getLastNotifications().then((value) {
      setState(() {
        if (value != null && value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
          notificationList = _notificationController.notificationList;
          if (notificationList != null && notificationList.length > 0) {
            counter = notificationList.length;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: AppBar().preferredSize.height,
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppTheme.kPrimaryColor.withOpacity(0.7),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      this.widget.screenName,
                      style: TextStyle(
                        fontSize: 22,
                        color: AppTheme.nearlyWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                  child: Stack(
                    children: [
                      PopupMenuButton<NotificationListResponse>(
                        // overflow menu

                        onSelected: (choice) {
                          setState(() {
                            if (choice.type != null) {
                              if (choice.type
                                      .compareTo(Const.NOTIFICATION_TYPE) ==
                                  0) {
                                moveToNotificationDetailsScreen(choice);
                              } else {
                                moveToApprovalDetailsScreen(choice);
                              }
                            }
                          });
                        },
                        icon:
                            new Icon(Icons.notifications, color: Colors.white),
                        itemBuilder: (BuildContext context) {
                          return notificationList
                              .map<PopupMenuItem<NotificationListResponse>>(
                                  (NotificationListResponse choice) {
                            return PopupMenuItem<NotificationListResponse>(
                              value: choice,
                              child: Container(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.sd_card_alert_outlined,
                                    color: AppTheme.kPrimaryColor,
                                  ),
                                  title: Text(
                                    choice.name,
                                    style: TextStyle(
                                        color: AppTheme.kPrimaryColor),
                                  ),
                                  subtitle: Text(choice.requestedDate),
                                ),
                              ),
                            );
                          }).toList();
                        },
                      ),
                      counter != 0
                          ? new Positioned(
                              left: 25,
                              top: 8,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 15,
                                  minHeight: 15,
                                ),
                                child: Text(
                                  '$counter',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : new Container()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                  child: PopupMenuButton<String>(
                    // overflow menu

                    onSelected: (language) {
                      print(language);
                      newLocaleDelegate = AppTranslationsDelegate(
                          newLocale: Locale(languagesMap[language]));
                      MyApp.setLocale(context, Locale(languagesMap[language]));
                      setState(() {});
                    },
                    icon: new Icon(Icons.language, color: Colors.white),
                    itemBuilder: (BuildContext context) {
                      return languagesList
                          .map<PopupMenuItem<String>>((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void moveToApprovalDetailsScreen(NotificationListResponse choice) {
    ApprovalInboxListResponse item = ApprovalInboxListResponse();
    item.title_name = choice.name;
    item.approval_request_date = choice.requestedDate;
    item.row_id = choice.approvalInboxId;

    Navigator.of(context)
        .push(
          MaterialPageRoute(
              builder: (context) => RequestDetailsScreen(
                    approvalInboxItenm: item,
                  )),
        )
        .then((value) => {
              if (value != null)
                {
                  if (value.toString().compareTo(Const.SYSTEM_SUCCESS_MSG) == 0)
                    {getLastNotifications()}
                }
            });
  }

  void moveToNotificationDetailsScreen(NotificationListResponse choice) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
              builder: (context) => NotificationDetailsScreen(
                    approvalInboxId: choice.notificationId,
                  )),
        )
        .then((value) => {
              if (value != null)
                {
                  if (value.toString().compareTo(Const.SYSTEM_SUCCESS_MSG) == 0)
                    {getLastNotifications()}
                }
            });
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }
}
