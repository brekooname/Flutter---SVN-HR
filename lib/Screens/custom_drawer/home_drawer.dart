import 'package:flutter/gestures.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/Leaves/leaves_transaction_screen.dart';
import 'package:sven_hr/Screens/Login/login_controller.dart';
import 'package:sven_hr/Screens/Login/login_screen.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_screen.dart';
import 'package:sven_hr/Screens/app_settings/app_settings_screen.dart';
import 'package:sven_hr/Screens/app_settings/server_connection_screen.dart';
import 'package:sven_hr/Screens/approval_inbox/approval_inbox_transaction_screen.dart';
import 'package:sven_hr/Screens/attendance_summary/attendance_summary_screen.dart';
import 'package:sven_hr/Screens/expense/expense_transaction_screen.dart';
import 'package:sven_hr/Screens/extra_work/extra_work_transaction_screen.dart';
import 'package:sven_hr/Screens/message_broadcaste/message_broadcaste_transaction_screen.dart';
import 'package:sven_hr/Screens/profile/change_password_screen.dart';
import 'package:sven_hr/Screens/profile/employee_profile_controller.dart';
import 'package:sven_hr/Screens/profile/employee_profile_screen.dart';
import 'package:sven_hr/Screens/time_sheet/time_sheet_screen.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/rounded_password_field.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/profile_screen_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/constants.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList> drawerList;
  String _employeePicLink = "";
  String _employeeNumber = "No Employee Name";
  SharedPreferences prefs = null;
  bool showSpinner = false;
  var newPasswordTextController;
  var oldPasswordTextController;
  var confirmedPasswordTextController;
  EmployeeProfileController _employeeProfileController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getEmployeeDetails();
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   this.setdDrawerListArray();
    // });
  }

  void getEmployeeDetails() async {
    prefs = await SharedPreferences.getInstance();
    _employeeNumber = prefs.getString(Const.SHARED_KEY_EMPLOYEE_NUMBER) ?? "";
    _employeePicLink =
        prefs.getString(Const.SHARED_KEY_EMPLOYEE_PIC_LINK) ?? "";
  }

  void getProfileScreens() {
    if (LoginController.listOfProfileScreens != null) {
      for (ProfileScreenResponse screen
          in LoginController.listOfProfileScreens) {
        if (screen.screenName.compareTo(ProfilePage.id) == 0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.MY_PROFILE,
            labelName:
                AppTranslations.of(context).text(Const.LOCALE_KEY_PROFILE),
            icon: Icon(Icons.account_circle_outlined),
          );
          drawerList.add(item);
        } else if (screen.screenName.compareTo(VacationsTransaction.id) == 0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.VACATION,
            labelName:
                AppTranslations.of(context).text(Const.LOCALE_KEY_MY_VACTIONS),
            icon: Icon(Icons.card_travel),
          );
          drawerList.add(item);
        } else if (screen.screenName.compareTo(LeavesTransaction.id) == 0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.LEAVES,
            labelName:
                AppTranslations.of(context).text(Const.LOCALE_KEY_MY_LEAVES),
            icon: Icon(Icons.directions_run_outlined),
          );
          drawerList.add(item);
        } else if (screen.screenName
                .compareTo(ApprovalInboxTransactionScreen.id) ==
            0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.APPROVAL_INBOX,
            labelName: AppTranslations.of(context)
                .text(Const.LOCALE_KEY_APPROVAL_INBOX),
            icon: Icon(Icons.move_to_inbox_outlined),
          );
          drawerList.add(item);
        } else if (screen.screenName.compareTo(TimeSheetScreen.id) == 0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.TIME_SHEET,
            labelName:
                AppTranslations.of(context).text(Const.LOCALE_KEY_TIME_SHEET),
            icon: Icon(Icons.timer),
          );
          drawerList.add(item);
        } else if (screen.screenName.compareTo(AppSettingsScreen.id) == 0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.APP_SETTINGS,
            labelName:
                AppTranslations.of(context).text(Const.LOCALE_KEY_APP_SETTING),
            icon: Icon(Icons.settings_outlined),
          );
          drawerList.add(item);
        } else if (screen.screenName.compareTo(AttendanceSummaryScreen.id) ==
            0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.ATTENDANCE_SUMMARY,
            labelName: AppTranslations.of(context)
                .text(Const.LOCALE_KEY_ATTENDANCE_SUMMARY),
            icon: Icon(Icons.library_books_outlined),
          );
          drawerList.add(item);
        } else if (screen.screenName.compareTo(ExpenseTransactionScreen.id) ==
            0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.EXPENSE,
            labelName:
                AppTranslations.of(context).text(Const.LOCALE_KEY_MY_EXPENSE),
            icon: Icon(Icons.monetization_on_outlined),
          );
          drawerList.add(item);
        } else if (screen.screenName.compareTo(ExtraWorkTransactionScreen.id) ==
            0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.EXTRA_WORK,
            labelName: AppTranslations.of(context)
                .text(Const.LOCALE_KEY_MY_EXTRA_WORK),
            icon: Icon(Icons.work_outline_outlined),
          );
          drawerList.add(item);
        } else if (screen.screenName.compareTo(MessageBroadcasteScreen.id) ==
            0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.ANNOUNCEMENTS,
            labelName: AppTranslations.of(context)
                .text(Const.LOCALE_KEY_MY_ANNOUNCEMENTS),
            icon: Icon(Icons.announcement_outlined),
          );
          drawerList.add(item);
        } else if (screen.screenName.compareTo(ServerConnectionScreen.id) ==
            0) {
          DrawerList item = DrawerList(
            index: DrawerIndex.SERVER_CONNECTION,
            labelName: AppTranslations.of(context)
                .text(Const.LOCALE_KEY_SERVER_CONNECTION),
            icon: Icon(Icons.wifi_rounded),
          );
          drawerList.add(item);
        }
      }
    }
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: AppTranslations.of(context).text(Const.LOCALE_KEY_HOME),
        icon: Icon(Icons.home_outlined),
      ),
    ];
    getProfileScreens();
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

  @override
  Widget build(BuildContext context) {
    this.setDrawerListArray();
    return Scaffold(
      backgroundColor: AppTheme.white.withOpacity(0.1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(
                            1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.nearlyBlue.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: FadeInImage(
                                image: NetworkImage(_employeePicLink),
                                placeholder:
                                    AssetImage("assets/images/avatar.png"),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21, left: 44),
                    child: Text(
                      _employeeNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8, left: 4),
                  //   child: RichText(
                  //     text: TextSpan(children: [
                  //       WidgetSpan(
                  //         child: Icon(Icons.lock_open, size: 14,color: AppTheme.red,),
                  //       ),
                  //       TextSpan(
                  //           text: AppTranslations.of(context)
                  //                   .text(Const.LOCALE_KEY_CHANGE_PASSWORD),
                  //           style: TextStyle(color: AppTheme.kPrimaryColor),
                  //           recognizer: TapGestureRecognizer()
                  //             ..onTap = () async {
                  //               await _changePasswordDialog(context);
                  //             }),
                  //
                  //     ]),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xFFd4ecfc))),
            child: SizedBox(
              height: 0.5,
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.nearlyBlue.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList[index]);
              },
            ),
          ),
          // Divider(
          //   height: 1,
          //   color: AppTheme.nearlyBlue.withOpacity(0.6),
          // ),
          // Column(
          //   children: <Widget>[
          //     ListTile(
          //       title: Text(
          //         AppTranslations.of(context).text(Const.LOCALE_KEY_LOGOUT),
          //         style: TextStyle(
          //           fontFamily: AppTheme.fontName,
          //           fontWeight: FontWeight.w600,
          //           fontSize: 16,
          //           color: AppTheme.darkText,
          //         ),
          //         textAlign: TextAlign.left,
          //       ),
          //       trailing: Icon(
          //         Icons.power_settings_new,
          //         color: AppTheme.kPrimaryColor,
          //       ),
          //       onTap: () {
          //         Navigator.pop(context);
          //         Navigator.pushNamed(context, LoginScreen.id);
          //         prefs.clear();
          //       },
          //     ),
          //     SizedBox(
          //       height: MediaQuery.of(context).padding.bottom,
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : Colors.transparent,
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  MY_PROFILE,
  LEAVES,
  VACATION,
  TIME_SHEET,
  SALARY_INC_REQUEST,
  EXTRA_WORK,
  EXPENSE,
  BENEFIT_REQUEST,
  LOAN_REQUEST,
  CLOCK_RECORD,
  APPROVAL_INBOX,
  APP_SETTINGS,
  ATTENDANCE_SUMMARY,
  ANNOUNCEMENTS,
  SERVER_CONNECTION
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}
