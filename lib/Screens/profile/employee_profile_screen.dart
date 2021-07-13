import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../../main.dart';

class ProfilePage extends StatefulWidget {
  static final String id = "employee_profile_screen";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName: AppTranslations.of(context).text(Const.LOCALE_KEY_PROFILE),
      screenWidget: ProfileScreen(),
    );
  }

  Widget ProfileScreen() {
    return ListView(
      children: <Widget>[
        UserInfo(),
      ],
    );
  }
}

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String _employeeName = "";
  String _employeePicLink = "";
  String _employeePosition = "";
  String _employeeDepartment = "";
  String _employeeNumber = "";
  String _employeeEmail = "";
  String _employeeTel = "";
  String _reportingManager = "";
  SharedPreferences prefs = null;

  @override
  void initState() {
    getEmployeeDetails();
    super.initState();
  }

  void getEmployeeDetails() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _employeeName = prefs.getString(Const.SHARED_KEY_EMPLOYEE_NAME) ?? "";
      _employeePicLink =
          prefs.getString(Const.SHARED_KEY_EMPLOYEE_PIC_LINK) ?? "";
      _employeePosition = prefs.getString(Const.SHARED_KEY_POSITION) ?? "";
      _employeeDepartment = prefs.getString(Const.SHARED_KEY_DEPARTMENT) ?? "";
      _employeeNumber = prefs.getString(Const.SHARED_KEY_EMPLOYEE_NUMBER) ?? "";
      _employeeEmail = prefs.getString(Const.SHARED_KEY_EMAIL) ?? "";
      _employeeTel = prefs.getString(Const.SHARED_KEY_TELEPHONE_NUMBER) ?? "";
      _reportingManager =
          prefs.getString(Const.SHARED_KEY_REPORTING_MANAGER) ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Card(
            // color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.kPrimaryLightColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                      height: 90,
                      margin: EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.nearlyBlue.withOpacity(0.6),
                              offset: const Offset(2.0, 4.0),
                              blurRadius: 8),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.kPrimaryLightColor,
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(60.0)),
                            child: FadeInImage(
                                image: NetworkImage(_employeePicLink),
                                placeholder:
                                    AssetImage("assets/images/avatar.png"))),
                      )),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(
                    _employeeName,
                    style: TextStyle(
                        color: AppTheme.kPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(
                    _employeePosition,
                    style: TextStyle(
                        color: AppTheme.kPrimaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(
                    _employeeDepartment,
                    style: TextStyle(
                        color: AppTheme.kPrimaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      AppTranslations.of(context).text(
                        Const.LOCALE_KEY_USER_INFORMATION,
                      ),
                      style: TextStyle(
                        color: AppTheme.kPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Divider(
                    color: AppTheme.kPrimaryColor,
                  ),
                  Container(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        leading: Icon(
                          Icons.perm_identity,
                          color: AppTheme.kPrimaryColor,
                        ),
                        title: Text(AppTranslations.of(context)
                            .text(Const.LOCALE_KEY_EMPLOYEE_NUMBER)),
                        subtitle: Text(
                          _employeeNumber,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email_outlined,
                          color: AppTheme.kPrimaryColor,
                        ),
                        title: Text(AppTranslations.of(context)
                            .text(Const.LOCALE_KEY_EMAIL)),
                        subtitle: Text(
                          _employeeEmail,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone_outlined,
                          color: AppTheme.kPrimaryColor,
                        ),
                        title: Text(AppTranslations.of(context).text(
                          Const.LOCALE_KEY_TELEPHONE_NUMBER,
                        )),
                        subtitle: Text(
                          _employeeTel,
                          textDirection: TextDirection.ltr,
                          textAlign:
                              MyApp.isEN ? TextAlign.left : TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.account_circle_outlined,
                          color: AppTheme.kPrimaryColor,
                        ),
                        title: Text(AppTranslations.of(context)
                            .text(Const.LOCALE_KEY_REPORTING_MANAGER)),
                        subtitle: Text(
                          _reportingManager,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
