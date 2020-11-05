import 'package:sven_hr/Screens/Leaves/leaves_transaction_screen.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_screen.dart';
import 'package:sven_hr/Screens/app_settings/app_settings_screen.dart';
import 'package:sven_hr/Screens/approval_inbox/approval_inbox_transaction_screen.dart';
import 'package:sven_hr/Screens/profile/employee_profile_screen.dart';
import 'package:sven_hr/Screens/time_sheet/time_sheet_screen.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/Screens/custom_drawer/drawer_user_controller.dart';
import 'package:sven_hr/Screens/custom_drawer/home_drawer.dart';

import 'package:flutter/material.dart';
import 'package:sven_hr/Screens/Home/home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  static final String id = "NavigationHomeScreen";
  Widget screenView;
  DrawerIndex drawerIndex;

  NavigationHomeScreen({this.screenView, this.drawerIndex});

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState(screenView,drawerIndex);
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;


  _NavigationHomeScreenState(this.screenView, this.drawerIndex){
    this.drawerIndex=drawerIndex;
    this.screenView=screenView;
  }

  @override
  void initState() {
    // this.widget.drawerIndex = DrawerIndex.HOME;
    // this.widget.screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex:  drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView:  screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.LEAVES) {
        setState(() {
          screenView = LeavesTransaction();
        });
      } else if (drawerIndex == DrawerIndex.VACATION) {
        setState(() {
          screenView = VacationsTransaction();
        });
      } else if (drawerIndex == DrawerIndex.MY_PROFILE) {
        setState(() {
          screenView = ProfilePage();
        });
      }else if (drawerIndex == DrawerIndex.APPROVAL_INBOX) {
        setState(() {
          screenView = ApprovalInboxTransactionScreen();
        });
      }
      else if (drawerIndex == DrawerIndex.TIME_SHEET) {
        setState(() {
          screenView = TimeSheetScreen();
        });
      } else if (drawerIndex == DrawerIndex.APP_SETTINGS) {
        setState(() {
          screenView = AppSettingsScreen();
        });
      }else {
        //do in your way......
      }
    }
  }
}
