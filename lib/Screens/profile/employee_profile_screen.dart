import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../../main.dart';
import '../app_settings/server_connection_screen.dart';

class ProfilePage extends StatefulWidget {
  static final String id = "employee_profile_screen";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName: AppTranslations.of(context)!.text(Const.LOCALE_KEY_PROFILE),
      screenWidget: ProfileScreen(),
    );
  }

  Widget ProfileScreen() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          UserInfo(),
         ],
      ),
    );
  }}

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
  SharedPreferences? prefs = null;

  @override
  void initState() {
    getEmployeeDetails();
    super.initState();
  }

  void getEmployeeDetails() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _employeeName = prefs!.getString(Const.SHARED_KEY_EMPLOYEE_NAME) ?? "";
      _employeePicLink =
          prefs!.getString(Const.SHARED_KEY_EMPLOYEE_PIC_LINK) ?? "";
      _employeePosition = prefs!.getString(Const.SHARED_KEY_POSITION) ?? "";
      _employeeDepartment = prefs!.getString(Const.SHARED_KEY_DEPARTMENT) ?? "";
      _employeeNumber = prefs!.getString(Const.SHARED_KEY_EMPLOYEE_NUMBER) ?? "";
       _employeeEmail = prefs!.getString(Const.SHARED_KEY_EMAIL) ?? "";
      _employeeTel = prefs!.getString(Const.SHARED_KEY_TELEPHONE_NUMBER) ?? "";
      _reportingManager =
          prefs!.getString(Const.SHARED_KEY_REPORTING_MANAGER) ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    Color complementaryBackgroundColor = Colors.grey.shade200; // A light grey color that complements the theme

    return Container(
       padding: EdgeInsets.all(15),
      child: Column(
         children: <Widget>[
          Card(
            elevation: 14, // Increased elevation for a prominent effect
            shadowColor: ModernTheme.accentColor.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient( // Gradient background
                  colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 111,
                    margin: EdgeInsets.only(top: 60),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: ModernTheme.accentColor.withOpacity(0.6),
                          offset: const Offset(2.0, 4.0),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 45,
                        // _employeePicLink.isNotEmpty
                        //     ? NetworkImage(_employeePicLink) as ImageProvider // Cast to ImageProvider
                        //     :
                        backgroundImage:AssetImage("assets/images/avatar.png"), // Placeholder image
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  // User information
                  Text(_employeeName, style: TextStyle(color: ModernTheme.textColor, fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center),
                  Text(_employeePosition, style: TextStyle(color: ModernTheme.textColor, fontSize: 18), textAlign: TextAlign.center),
                  Text(_employeeDepartment, style: TextStyle(color: ModernTheme.textColor, fontSize: 18), textAlign: TextAlign.center),
                  Divider(color: ModernTheme.accentColor, thickness: 1.5, ),
                  UserInfoListTile(Icons.perm_identity, Const.LOCALE_KEY_EMPLOYEE_NUMBER, _employeeNumber),
                  UserInfoListTile(Icons.email_outlined, Const.LOCALE_KEY_EMAIL, _employeeEmail),
                  UserInfoListTile(Icons.phone_outlined, Const.LOCALE_KEY_TELEPHONE_NUMBER, _employeeTel),
                  UserInfoListTile(Icons.account_circle_outlined, Const.LOCALE_KEY_REPORTING_MANAGER, _reportingManager),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget UserInfoListTile(IconData icon, String localeKey, String info) {
    return ListTile(
      leading: Icon(icon, color: ModernTheme.accentColor),
      title: Text(AppTranslations.of(context)!.text(localeKey), style: TextStyle(color: ModernTheme.textColor, fontWeight: FontWeight.w500)),
      subtitle: Text(info, style: TextStyle(color: ModernTheme.textColor)),
    );
  }

}
