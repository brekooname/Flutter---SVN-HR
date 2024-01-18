import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/approval_inbox/approval_inbox_controller.dart';
import 'package:sven_hr/Screens/approval_inbox/models/approval_inbox_item_list.dart';
import 'package:sven_hr/Screens/approval_inbox/request_details_screen.dart';
import 'package:sven_hr/Screens/custom_drawer/home_drawer.dart';
import 'package:sven_hr/Screens/custom_drawer/notification_controller.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';
import '../navigation_home_screen.dart';

class ApprovalInboxTransactionScreen extends StatefulWidget {
  static String id = "ApprovalInboxTransaction";
  @override
  _ApprovalInboxTransactionScreenState createState() =>
      _ApprovalInboxTransactionScreenState();
}

class _ApprovalInboxTransactionScreenState
    extends State<ApprovalInboxTransactionScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  ApprovalInboxController? _approvalInboxController=ApprovalInboxController();
  bool showSpinner = false;
  NotificationController _notificationController = NotificationController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _approvalInboxController = ApprovalInboxController();
    getLastApprovalInboxTransaction();
    super.initState();
  }

  void getLastApprovalInboxTransaction() async {
    await _approvalInboxController!
        .getLastApprovalInboxTransaction()
        .then((value) {
      setState(() {
        print(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName:
          AppTranslations.of(context)!.text(Const.LOCALE_KEY_APPROVAL_INBOX),
      screenWidget: ApprovalInboxScreen(),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  Widget ApprovalInboxScreen() {
    bool _isPressed = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
          FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount: _approvalInboxController!.approvalList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          _approvalInboxController!.approvalList.length > 10
                              ? 10
                              : _approvalInboxController!.approvalList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController!.forward();

                      return ApprovalInboxView(
                        approvalInboxListItem:
                            _approvalInboxController!.approvalList[index],
                        animation: animation,
                        index: index,
                        approvalInboxController: _approvalInboxController!,
                        animationController: animationController!,
                        callback: () {

                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                    builder: (context) => RequestDetailsScreen(
                                          approvalInboxItenm:
                                              _approvalInboxController!
                                                  .inboxlList[index],
                                        )),
                              )
                              .then((value) => {

                                    if (value != null)
                                      {
                                        if (value.toString().compareTo(
                                                Const.SYSTEM_SUCCESS_MSG) ==
                                            0)
                                          {
                                            Navigator.pop(context),
                                            Navigator.of(context)
                                                .push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NavigationHomeScreen(
                                                              drawerIndex:
                                                                  DrawerIndex
                                                                      .APPROVAL_INBOX,
                                                              screenView:
                                                                  ApprovalInboxTransactionScreen())),
                                                )
                                                .then((value) =>
                                                    {if (value != null) {}})
                                          }
                                      }
                                  });

                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ApprovalInboxView extends StatelessWidget {
  const ApprovalInboxView(
      {Key? key,
      this.approvalInboxListItem,
      this.animationController,
      this.animation,
      this.callback,
      this.index,
      this.approvalInboxController})
      : super(key: key);

  final VoidCallback? callback;
  final ApprovalInboxListItem? approvalInboxListItem;
  final AnimationController? animationController;
  final Animation<dynamic>? animation;
  final int? index;
  final ApprovalInboxController? approvalInboxController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext? context, Widget? child) {
        return FadeTransition(
          opacity: animation as Animation<double>,
          child: Transform(
            transform: Matrix4.translationValues(100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback!();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      ModernTheme.gradientStart,
                      ModernTheme.textColor
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                ),
                width: double.infinity,
                height: 140,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Icon and title row
                    _buildIconAndTitle(approvalInboxListItem),
                    // Expanded to include status, date, and other details
                    Expanded(
                      child: _buildDetails(context!, approvalInboxListItem),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildIconAndTitle(ApprovalInboxListItem? item) {
    return Container(
      width: 50,
      height: 50,
      margin: MyApp.isEN ? EdgeInsets.only(right: 15) : EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
            width: 3,
            color: item!.getRightColor()!.withOpacity(0.2)),
      ),
      child: item.getRightIcon(),
    );
    // Add title widget here if needed
  }
  Widget _buildDetails(BuildContext context, ApprovalInboxListItem? item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Title
        Text(
          item!.titleName!,
          style: TextStyle(
            color: item.getRightColor(),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 6),

        // Status row
        Row(
          children: <Widget>[
            Icon(
              Icons.adjust,
              color: item.getRightColor(),
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              AppTranslations.of(context)!.text(Const.LOCALE_KEY_STATUS),
              style: TextStyle(
                color: item.getRightColor(),
                fontSize: 13,
                letterSpacing: .3,
              ),
            ),
            Text(
              item.status!,
              style: TextStyle(
                color: item.getRightColor(),
                fontSize: 13,
                letterSpacing: .3,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),

        // Request Date row
        Row(
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              color: item.getRightColor(),
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUEST_DATE),
              style: TextStyle(
                color: item.getRightColor(),
                fontSize: 13,
                letterSpacing: .3,
              ),
            ),
            Text(
              item.requestDate!,
              style: TextStyle(
                color: item.getRightColor(),
                fontSize: 13,
                letterSpacing: .3,
              ),
            ),
          ],
        ),
        // Add more details as needed
      ],
    );
  }

}
