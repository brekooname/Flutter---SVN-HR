import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/Login/login_screen.dart';
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

import '../app_settings/server_connection_screen.dart';


class MenueTopBar extends StatefulWidget {
  final String? screenName;

  MenueTopBar({@required this.screenName});

  @override
  _MenueTopBarState createState() => _MenueTopBarState();
}

class _MenueTopBarState extends State<MenueTopBar> {
  int counter = 0;
  List<NotificationListResponse>? notificationList;
  NotificationController _notificationController = NotificationController();
  SharedPreferences? prefs = null;
  var newPasswordTextController;
  var oldPasswordTextController;
  var confirmedPasswordTextController;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  EmployeeProfileController? _employeeProfileController;

  @override
  void initState() {
    getLastNotifications();
    super.initState();
  }

  void getLastNotifications() async {
    await _notificationController.getLastNotifications().then((value) {
      setState(() {
        if (value!.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
          notificationList = _notificationController.notificationList;
          if (notificationList!.length > 0) {
            counter = notificationList!.length;
          } else {
            counter = 0;
          }
        }
      });
    });
  }

  void clearPref() async {
    prefs = await SharedPreferences.getInstance();
    String? _serverIP = prefs!.getString(Const.SHARED_KEY_SERVER_IP);
    String? _port = prefs!.getString(Const.SHARED_KEY_SERVER_PORT);
    String? _fullUrl = prefs!.getString(Const.SHARED_KEY_FULL_HOST_URL);

    prefs!.clear();

    prefs!.setString(Const.SHARED_KEY_SERVER_IP, _serverIP!);
    prefs!.setString(Const.SHARED_KEY_SERVER_PORT, _port!);
    prefs!.setString(Const.SHARED_KEY_FULL_HOST_URL, _fullUrl!);
  }

  void onItemSelected(String selected) async {
    prefs = await SharedPreferences.getInstance();
    if (selected.compareTo(Const.LOCALE_KEY_LOGOUT) == 0) {
      bool confirmLogout = await _showLogoutConfirmationDialog(context);
      if (confirmLogout) {
        Navigator.pop(context);
        Navigator.pushNamed(context, LoginScreen.id);

        // clearPref();
      }
    } else if (selected.compareTo(Const.LOCALE_KEY_CHANGE_PASSWORD) == 0) {
      await _changePasswordDialog(context);
    }
  }

  Future _changePasswordDialog(BuildContext context) async {
    newPasswordTextController = TextEditingController();
    oldPasswordTextController = TextEditingController();
    confirmedPasswordTextController = TextEditingController();

    return await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(15),
            ),
            // Adjust the height as needed or remove the height constraint
            // height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: SingleChildScrollView( // Added SingleChildScrollView
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Adjust size based on content
                    children: [
                      // Title and Close Button
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.close, color: ModernTheme.accentColor),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          AppTranslations.of(context)!.text(Const.LOCALE_KEY_CHANGE_PASSWORD),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ModernTheme.accentColor,
                          ),
                        ),
                      ),
                      // Password Fields
                      _buildPasswordField(
                        controller: oldPasswordTextController,
                        hint: AppTranslations.of(context)!.text(Const.LOCALE_KEY_OLD_PASSWORD),
                      ),
                      _buildPasswordField(
                        controller: newPasswordTextController,
                        hint: AppTranslations.of(context)!.text(Const.LOCALE_KEY_NEW_PASSWORD),
                      ),
                      _buildPasswordField(
                        controller: confirmedPasswordTextController,
                        hint: AppTranslations.of(context)!.text(Const.LOCALE_KEY_CONFRIMED_PASSWORD),
                      ),
                      // Change Password Button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ModernTheme.accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              changePassword();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              AppTranslations.of(context)!.text(Const.LOCALE_KEY_CHANGE_PASSWORD),
                              style: TextStyle(fontSize: 16, color: Colors.white),
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
      },
    );
  }

  Widget _buildPasswordField({TextEditingController? controller, String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ModernTheme.accentColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ModernTheme.accentColor.withOpacity(0.7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ModernTheme.accentColor),
          ),
        ),
        validator: (value) {
          if (value == null || value!.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    );
  }

  void changePassword() async {
    showSpinner = true;
    _employeeProfileController = EmployeeProfileController();
    // newPasswordTextController = new TextEditingController();
    // oldPasswordTextController = new TextEditingController();
    // confirmedPasswordTextController = new TextEditingController();

    await _employeeProfileController!
        .changePasswordRequest(
            oldPassword: oldPasswordTextController.text,
            newPassword: newPasswordTextController.text,
            confirmedPassword: confirmedPasswordTextController.text)
        .then((value) {
      if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
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
    return Container(
      height: AppBar().preferredSize.height,
      width: double.infinity,
       color: Colors.grey.withOpacity(0.22),
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
                 child:
                 Text(
                   this.widget.screenName!,
                   style: TextStyle(
                     fontSize: 20,
                     color: ModernTheme.textColor, // Updated to ModernTheme textColor
                     fontWeight: FontWeight.w700,
                   ),
                 ),
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 8),
             child: Container(
               width: AppBar().preferredSize.height,
               height: AppBar().preferredSize.height,
               child: Stack(
                 children: [
                   PopupMenuButton<NotificationListResponse>(
                     onSelected: (choice) {
                       setState(() {
                         if (choice.type.compareTo(Const.NOTIFICATION_TYPE) == 0) {
                           moveToNotificationDetailsScreen(choice);
                         } else {
                           moveToApprovalDetailsScreen(choice);
                         }
                       });
                     },
                     icon: Icon(Icons.notifications, color: ModernTheme.textColor, size: 28),
                     itemBuilder: (BuildContext context) {
                       return notificationList!.map((NotificationListResponse choice) {
                         return PopupMenuItem<NotificationListResponse>(
                           value: choice,
                           child: Padding(
                             padding: const EdgeInsets.all(4.0),
                             child: Container(
                               decoration: BoxDecoration(
                                 color: ModernTheme.backgroundColor.withOpacity(0.9),
                                 borderRadius: BorderRadius.circular(8),
                                 border: Border.all(color: ModernTheme.accentColor, width: 1),
                               ),
                               child: ListTile(
                                 leading: Icon(Icons.sd_card_alert_outlined, color: ModernTheme.textColor),
                                 title: Text(
                                   choice.name,
                                   style: TextStyle(
                                     color: ModernTheme.textColor,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 subtitle: Text(
                                   choice.requestedDate,
                                   style: TextStyle(
                                     color: ModernTheme.textColor.withOpacity(0.7),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                         );
                       }).toList();
                     },
                   ),
                   counter != 0
                       ? Positioned(
                     right: 10,
                     top: 10,
                     child: Container(
                       padding: EdgeInsets.all(2),
                       decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(6),
                       ),
                       constraints: BoxConstraints(
                         minWidth: 18,
                         minHeight: 18,
                       ),
                       child: Text(
                         '$counter',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 10,
                         ),
                         textAlign: TextAlign.center,
                       ),
                     ),
                   )
                       : Container(),
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

                 onSelected: (value) {
                   onItemSelected(value);
                 },
                 icon: Icon(Icons.settings, color: ModernTheme.textColor),
                 itemBuilder: (BuildContext context) {
                   return <PopupMenuEntry<String>>[
                     _buildModernPopupMenu(
                       context: context,
                       value: Const.LOCALE_KEY_CHANGE_PASSWORD,
                       iconData: Icons.lock_open,
                       textKey: Const.LOCALE_KEY_CHANGE_PASSWORD,
                     ),
                     PopupSubMenuItem<String>(
                       title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_LANGUAGE),
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
                     _buildModernPopupMenu(
                       context: context,
                       value: Const.LOCALE_KEY_LOGOUT,
                       iconData: Icons.logout,
                       textKey: Const.LOCALE_KEY_LOGOUT,
                     ),
                   ];
                 },               ),
             ),
           ),
         ],
       ),
     ),
      );
  }
  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Confirm Logout',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: TextStyle(color: Color(0xfffd0d00)),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: ModernTheme.accentColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ModernTheme.accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false; // Return false if dialog is dismissed without any action
  }
  _buildModernPopupMenu({
    required BuildContext context,
    required String value,
    required IconData iconData,
    required String textKey,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: ListTile(
        leading: Icon(iconData, color: ModernTheme.accentColor),
        title: Text(
          AppTranslations.of(context)!.text(textKey),
          style: TextStyle(
              color:  Colors.blueGrey
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

  final String? title;
  final List<T>? items;
  final Function(T)? onSelected;

  @override
  double get height =>
      kMinInteractiveDimension; //Does not actually affect anything

  @override
  bool represents(T? value) =>
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.language, // Globe icon
                        color: ModernTheme.accentColor,
                        size: 20,
                      ),
                    ),
                    TextSpan(
                      text: " ${widget.title}",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: ModernTheme.accentColor, size: 20),
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
      itemBuilder: (BuildContext context) {
        return widget.items!.map((item) => PopupMenuItem<T>(
          value: item,
          child: Text(item.toString(), style: TextStyle(color:
    Colors.blueGrey
          ),
          ),
        )).toList();
      },
    );
  }}
