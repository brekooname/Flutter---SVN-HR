import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/Login/login_screen.dart';
import 'package:sven_hr/Screens/approval_inbox/models/approval_inbox_item_list.dart';
import 'package:sven_hr/Screens/approval_inbox/request_details_screen.dart';
import 'package:sven_hr/Screens/custom_drawer/notification_controller.dart';
import 'package:sven_hr/Screens/custom_drawer/notifications_details.dart';
import 'package:sven_hr/Screens/profile/employee_profile_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/rounded_password_field.dart';
import 'package:sven_hr/components/text_field_container.dart';
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
  _MenueTopBarState createState() => _MenueTopBarState();
}

class _MenueTopBarState extends State<MenueTopBar> {
  int counter = 0;
  List<NotificationListResponse> notificationList;
  NotificationController _notificationController = NotificationController();
  SharedPreferences prefs = null;
  var newPasswordTextController;
  var oldPasswordTextController;
  var confirmedPasswordTextController;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  EmployeeProfileController _employeeProfileController;

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
          } else {
            counter = 0;
          }
        }
      });
    });
  }
  void clearPref() async{
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  void onItemSelected(String selected) async {
    prefs = await SharedPreferences.getInstance();
    if (selected.compareTo(Const.LOCALE_KEY_LOGOUT) == 0) {
      Navigator.pop(context);
      Navigator.pushNamed(context, LoginScreen.id);
      clearPref();
      prefs.clear();
    } else if (selected.compareTo(Const.LOCALE_KEY_CHANGE_PASSWORD) == 0) {
      await _changePasswordDialog(context);
    }
  }

  Future _changePasswordDialog(BuildContext context) async {
    newPasswordTextController = new TextEditingController();
    oldPasswordTextController = new TextEditingController();
    confirmedPasswordTextController = new TextEditingController();
    return await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Container(
              color: AppTheme.white,
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: AppTheme.kPrimaryColor,
                                ),
                                tooltip: 'back',
                                hoverColor: AppTheme.kPrimaryColor,
                                splashColor: AppTheme.kPrimaryColor,
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                AppTranslations.of(context)
                                    .text(Const.LOCALE_KEY_CHANGE_PASSWORD),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  letterSpacing: 0.27,
                                  color: AppTheme.kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFieldContainer(
                            child: RoundedPasswordField(
                              textController: oldPasswordTextController,
                              text: AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_OLD_PASSWORD),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFieldContainer(
                            child: RoundedPasswordField(
                              textController: newPasswordTextController,
                              text: AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_NEW_PASSWORD),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFieldContainer(
                            child: RoundedPasswordField(
                              textController: confirmedPasswordTextController,
                              text: AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_CONFRIMED_PASSWORD),
                            ),
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                changePassword();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppTheme.nearlyBlue,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: AppTheme.nearlyBlue
                                            .withOpacity(0.5),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_CHANGE_PASSWORD),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void changePassword() async {
    showSpinner = true;
    _employeeProfileController = EmployeeProfileController();
    // newPasswordTextController = new TextEditingController();
    // oldPasswordTextController = new TextEditingController();
    // confirmedPasswordTextController = new TextEditingController();

    await _employeeProfileController
        .changePasswordRequest(
            oldPassword: oldPasswordTextController.text,
            newPassword: newPasswordTextController.text,
            confirmedPassword: confirmedPasswordTextController.text)
        .then((value) {
      if (value == null) {
        ToastMessage.showErrorMsg(Const.REQUEST_FAILED);
      } else if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
        ToastMessage.showSuccessMsg(Const.CHANGE_PASSWORD_SUCCESSFULLY);
        Navigator.pop(context);
      } else {
        ToastMessage.showErrorMsg(value);
      }
      showSpinner = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: AppBar().preferredSize.height,
      child: Container(
        height: AppBar().preferredSize.height,
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
                        fontSize: 20,
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
              // Padding(
              //   padding: const EdgeInsets.only(top: 8, right: 8),
              //   child: Container(
              //     width: AppBar().preferredSize.height - 8,
              //     height: AppBar().preferredSize.height - 8,
              //     child: PopupMenuButton<String>(
              //       // overflow menu
              //
              //       onSelected: (language) {
              //         print(language);
              //         newLocaleDelegate = AppTranslationsDelegate(
              //             newLocale: Locale(languagesMap[language]));
              //         MyApp.setLocale(context, Locale(languagesMap[language]));
              //         setState(() {});
              //       },
              //       icon: new Icon(Icons.language, color: Colors.white),
              //       itemBuilder: (BuildContext context) {
              //         return languagesList
              //             .map<PopupMenuItem<String>>((String choice) {
              //           return PopupMenuItem<String>(
              //             value: choice,
              //             child: Text(choice),
              //           );
              //         }).toList();
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                  child: PopupMenuButton<String>(
                    // overflow menu

                    onSelected: (value) {
                      onItemSelected(value);
                    },
                    icon: new Icon(Icons.settings, color: Colors.white),
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: Const.LOCALE_KEY_CHANGE_PASSWORD,
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.lock_open,
                                  size: 14,
                                  color: AppTheme.red,
                                ),
                              ),
                              TextSpan(
                                text: AppTranslations.of(context)
                                    .text(Const.LOCALE_KEY_CHANGE_PASSWORD),
                                style: TextStyle(color: AppTheme.kPrimaryColor),
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap = () async {
                                //     await _changePasswordDialog(context);
                                //   }
                              ),
                            ]),
                          ),
                        ),
                        PopupSubMenuItem<String>(
                          title: AppTranslations.of(context)
                              .text(Const.LOCALE_KEY_LANGUAGE),
                          items: languagesList,
                          onSelected: (language) {
                            print(language);
                            newLocaleDelegate = AppTranslationsDelegate(
                                newLocale: Locale(languagesMap[language]));
                            MyApp.setLocale(
                                context, Locale(languagesMap[language]));
                            setState(() {});
                          },
                        ),
                        PopupMenuItem<String>(
                          value: Const.LOCALE_KEY_LOGOUT,
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.logout,
                                  size: 14,
                                  color: AppTheme.red,
                                ),
                              ),
                              TextSpan(
                                text: AppTranslations.of(context)
                                    .text(Const.LOCALE_KEY_LOGOUT),
                                style: TextStyle(color: AppTheme.kPrimaryColor),
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap = () async {
                                //     await _changePasswordDialog(context);
                                //   }
                              ),
                            ]),
                          ),
                        ),
                      ];
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

class PopupSubMenuItem<T> extends PopupMenuEntry<T> {
  const PopupSubMenuItem({
    @required this.title,
    @required this.items,
    this.onSelected,
  });

  final String title;
  final List<T> items;
  final Function(T) onSelected;

  @override
  double get height =>
      kMinInteractiveDimension; //Does not actually affect anything

  @override
  bool represents(T value) =>
      false; //Our submenu does not represent any specific value for the parent menu

  @override
  State createState() => _PopupSubMenuState<T>();
}

/// The [State] for [PopupSubMenuItem] subclasses.
class _PopupSubMenuState<T> extends State<PopupSubMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      tooltip: widget.title,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 8.0, top: 12.0, bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.language,
                      size: 14,
                      color: AppTheme.red,
                    ),
                  ),
                  TextSpan(
                    text: widget.title,
                    style: TextStyle(color: AppTheme.kPrimaryColor),
                    // recognizer: TapGestureRecognizer()
                    //   ..onTap = () async {
                    //     await _changePasswordDialog(context);
                    //   }
                  ),
                ]),
              ),
            ),
            Icon(
              Icons.arrow_right,
              size: 24.0,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
      onCanceled: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      onSelected: (T value) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        widget.onSelected?.call(value);
      },
      offset: Offset
          .zero, //TODO This is the most complex part - to calculate the correct position of the submenu being populated. For my purposes is does not matter where exactly to display it (Offset.zero will open submenu at the poistion where you tapped the item in the parent menu). Others might think of some value more appropriate to their needs.
      itemBuilder: (BuildContext context) {
        return widget.items
            .map(
              (item) => PopupMenuItem<T>(
                value: item,
                child: Text(item
                    .toString()), //MEthod toString() of class T should be overridden to repesent something meaningful
              ),
            )
            .toList();
      },
    );
  }
}
