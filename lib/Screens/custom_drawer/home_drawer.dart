import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/Leaves/leaves_transaction_screen.dart';
import 'package:sven_hr/Screens/Login/login_controller.dart';
import 'package:sven_hr/Screens/Login/login_screen.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_screen.dart';
import 'package:sven_hr/Screens/approval_inbox/approval_inbox_transaction_screen.dart';
import 'package:sven_hr/Screens/profile/employee_profile_screen.dart';
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
  SharedPreferences prefs=null;
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
    _employeePicLink = prefs.getString(Const.SHARED_KEY_EMPLOYEE_PIC_LINK) ?? "";
  }

  void getProfileScreens(){
    if(LoginController.listOfProfileScreens!=null){
      for(ProfileScreenResponse screen in LoginController.listOfProfileScreens){
        if(screen.screenName.compareTo(ProfilePage.id)==0){
          DrawerList item=DrawerList(
            index: DrawerIndex.MY_PROFILE,
            labelName: AppTranslations.of(context)
                .text(Const.LOCALE_KEY_PROFILE),
            icon: Icon(Icons.account_circle),
          );
          drawerList.add(item);
        }else if(screen.screenName.compareTo(VacationsTransaction.id)==0){
          DrawerList item= DrawerList(
            index: DrawerIndex.VACATION,
            labelName:AppTranslations.of(context)
                .text(Const.LOCALE_KEY_VACATION),
            icon: Icon(Icons.new_releases),
          );
          drawerList.add(item);
        }else if(screen.screenName.compareTo(LeavesTransaction.id)==0){
          DrawerList item= DrawerList(
            index: DrawerIndex.LEAVES,
            labelName: AppTranslations.of(context)
                .text(Const.LOCALE_KEY_LEAVES),
            icon: Icon(Icons.directions_run),
          );
          drawerList.add(item);
        }else if(screen.screenName.compareTo(ApprovalInboxTransactionScreen.id)==0){
          DrawerList item= DrawerList(
            index: DrawerIndex.APPROVAL_INBOX,
            labelName: AppTranslations.of(context)
                .text(Const.LOCALE_KEY_APPROVAL_INBOX),
            icon: Icon(Icons.approval),
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
        labelName: AppTranslations.of(context)
            .text(Const.LOCALE_KEY_HOME),
        icon: Icon(Icons.home),
      ),


      // DrawerList(
      //   index: DrawerIndex.TIME_SHEET,
      //   labelName: AppTranslations.of(context)
      //       .text(Const.LOCALE_KEY_TIME_SHEET),
      //   icon: Icon(Icons.timeline),
      // ),
      // DrawerList(
      //   index: DrawerIndex.SALARY_INC_REQUEST,
      //   labelName: AppTranslations.of(context)
      //       .text(Const.LOCALE_KEY_SALARY_INCREMENT_REQUEST),
      //   icon: Icon(Icons.monetization_on),
      // ),
      // DrawerList(
      //   index: DrawerIndex.EXTRA_WORK_REQUEST,
      //   labelName: AppTranslations.of(context)
      //       .text(Const.LOCALE_KEY_EXTRA_WORK_REQUEST),
      //   icon: Icon(Icons.text_rotation_angledown),
      // ),
      // DrawerList(
      //   index: DrawerIndex.EXPENSE_REQUEST,
      //   labelName: AppTranslations.of(context)
      //       .text(Const.LOCALE_KEY_EXPENSE_REQUEST),
      //   icon: Icon(Icons.explicit),
      // ),
      // DrawerList(
      //   index: DrawerIndex.BENEFIT_REQUEST,
      //   labelName: AppTranslations.of(context)
      //       .text(Const.LOCALE_KEY_BENEFIT_REQUEST),
      //   icon: Icon(Icons.fiber_smart_record),
      // ),
      // DrawerList(
      //   index: DrawerIndex.LOAN_REQUEST,
      //   labelName: AppTranslations.of(context)
      //       .text(Const.LOCALE_KEY_LOAN_REQUEST),
      //   icon: Icon(Icons.local_activity),
      // ),
      // DrawerList(
      //   index: DrawerIndex.CLOCK_RECORD,
      //   labelName: AppTranslations.of(context)
      //       .text(Const.LOCALE_KEY_CLOCK_RECORD),
      //   icon: Icon(Icons.alarm),
      // ),
    ];
    getProfileScreens();
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(60.0)),
                                child: FadeInImage(
                                    image: NetworkImage(_employeePicLink),
                                    placeholder: AssetImage(
                                        "assets/images/avatar.png")
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      _employeeNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
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
          Divider(
            height: 1,
            color: AppTheme.nearlyBlue.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  AppTranslations.of(context)
                      .text(Const.LOCALE_KEY_LOGOUT),
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: AppTheme.kPrimaryColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, LoginScreen.id);
                  prefs.clear();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
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
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
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
  EXTRA_WORK_REQUEST,
  EXPENSE_REQUEST,
  BENEFIT_REQUEST,
  LOAN_REQUEST,
  CLOCK_RECORD,
  APPROVAL_INBOX
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
