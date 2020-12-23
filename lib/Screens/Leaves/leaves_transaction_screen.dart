import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/Leaves/leaves_controller.dart';
import 'package:sven_hr/Screens/Leaves/models/leave_list_item.dart';
import 'package:sven_hr/Screens/Vacations/models/vacation_list_item.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_controller.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/dao/vacation_type.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/leave_transaction_response.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class LeavesTransaction extends StatefulWidget {
  static final id = "LeavesTransaction";

  @override
  _LeavesTransactionState createState() => _LeavesTransactionState();
}

class _LeavesTransactionState extends State<LeavesTransaction>
    with TickerProviderStateMixin {
  AnimationController animationController;
  LovValue statusValue;
  LovValue typeValue;
  LeavesController _leavesController;
  List<LovValue> statusList;
  List<LovValue> typeList;
  String fromDate;
  String toDate;
  bool showSpinner = false;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _leavesController = LeavesController();
    LoadLeavesStatus();
    LoadLeaveType();
    getLastMonthVacationTransaction();
    super.initState();
  }

  void getLastMonthVacationTransaction() async {
    await _leavesController.getDefualtSearch().then((value) {
      setState(() {
        print(value);
      });
    });
  }

  void reset() {
    statusList.forEach((element) {
      element.isSelected = false;
    });
    typeList.forEach((element) {
      element.isSelected = false;
    });
  }

  void LoadLeavesStatus() async {
    statusList = List();

    await _leavesController.loadLeavesStatus().then((value) {
      setState(() {
        statusList.addAll(value);
        statusValue = statusList[0];
      });
    });
  }

  void LoadLeaveType() async {
    typeList = List();

    await _leavesController.loadLeavesType().then((value) {
      setState(() {
        typeList.addAll(value);
        typeValue = typeList[0];
      });
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName: AppTranslations.of(context).text(Const.LOCALE_KEY_LEAVES),
      screenWidget: LeaveScreen(),
    );
  }

  Widget LeaveScreen() {
    final format = DateFormat(Const.DATE_FORMAT);
    bool _isPressed = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                // color: AppTheme.kPrimaryLightColor.withOpacity(.6),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          AppTranslations.of(context)
                              .text(Const.LOCALE_KEY_FILTER_BY),
                          style: TextStyle(color: AppTheme.kPrimaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPressed = true;
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return MultiSelectionLOVListView(
                                      lovs: statusList,
                                    );
                                  });
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _isPressed
                                  ? AppTheme.kPrimaryColor.withOpacity(0.2)
                                  : AppTheme.nearlyWhite,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              border: Border.all(
                                  color: AppTheme.grey.withOpacity(0.2)),
                            ),
                            child: Center(
                                child: Text(
                              AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_STATUS),
                              style: TextStyle(color: AppTheme.kPrimaryColor),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPressed = true;
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return MultiSelectionLOVListView(
                                      lovs: typeList,
                                    );
                                  });
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _isPressed
                                  ? AppTheme.kPrimaryColor.withOpacity(0.2)
                                  : AppTheme.nearlyWhite,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              border: Border.all(
                                  color: AppTheme.grey.withOpacity(0.2)),
                            ),
                            child: Center(
                                child: Text(
                              AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_TYPE),
                              style: TextStyle(color: AppTheme.kPrimaryColor),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.autorenew,
                          color: AppTheme.kPrimaryColor,
                        ),
                        tooltip: 'Reset',
                        hoverColor: AppTheme.kPrimaryColor,
                        splashColor: AppTheme.kPrimaryColor,
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 0,
                          child: Text(
                              AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_FROM),
                              style: AppTheme.subtitle)),
                      Expanded(
                        child: DateTimeField(
                          textAlign: TextAlign.center,
                          style: AppTheme.subtitle,
                          format: format,
                          onChanged: (value) {
                            setState(() {
                              if (value != null)
                                fromDate = format.format(value);
                              else
                                fromDate = "";
                            });
                          },
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ),
                      Expanded(
                          flex: 0,
                          child: Text(
                              AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_TO),
                              style: AppTheme.subtitle)),
                      Expanded(
                        child: DateTimeField(
                          textAlign: TextAlign.center,
                          style: AppTheme.subtitle,
                          format: format,
                          onChanged: (value) {
                            setState(() {
                              if (value != null)
                                toDate = format.format(value);
                              else
                                toDate = "";
                            });
                          },
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: AppTheme.kPrimaryColor,
                        ),
                        tooltip: 'search',
                        hoverColor: AppTheme.kPrimaryColor,
                        splashColor: AppTheme.kPrimaryColor,
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          await _leavesController
                              .advancedSearch(
                                  fromDate, toDate, statusList, typeList)
                              .then((value) {
                            setState(() {
                              print(value);
                            });
                          });
                          setState(() {
                            showSpinner = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                    itemCount: _leavesController.leaveList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = _leavesController.leaveList.length > 10
                          ? 10
                          : _leavesController.leaveList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return LeavesView(
                        leaveListItem: _leavesController.leaveList[index],
                        animation: animation,
                        animationController: animationController,
                        callback: () {
                          // widget.callBack();
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

class LeavesView extends StatelessWidget {
  const LeavesView(
      {Key key,
      this.leaveListItem,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final LeaveTransactionResponse leaveListItem;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  Future _asyncConfirmDialog(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    return await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    AppTranslations.of(context)
                        .text(Const.LOCALE_KEY_EMPLOYMENT_CLOSE),
                    style: TextStyle(color: AppTheme.kPrimaryColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
            content: Container(
              color: AppTheme.white,
              height: size.height / 2,
              width: size.width / 2,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppTranslations.of(context)
                              .text(Const.LOCALE_KEY_LEAVE_DETAILS),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: AppTheme.kPrimaryColor,
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
                                .text(Const.LOCALE_KEY_TRANSACTION_STATUS)),
                            subtitle: Text(leaveListItem.trans_status != null
                                ? leaveListItem.trans_status_displayValue
                                    .toString()
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
                                .text(Const.LOCALE_KEY_REQUEST_DATE)),
                            subtitle: Text(leaveListItem.request_date != null
                                ? leaveListItem.request_date
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
                                .text(Const.LOCALE_KEY_TYPE)),
                            subtitle: Text(leaveListItem.leave_id != null
                                ? leaveListItem.leave_displayValue
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
                                .text(Const.LOCALE_KEY_NOTES)),
                            subtitle: Text(leaveListItem.remark != null
                                ? leaveListItem.remark.toString()
                                : "-"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_APPROVAL_INBOX) +
                              ": "),
                        ),
                      ],
                    ),
                    if (leaveListItem.approvalList != null)
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 100,
                            child: ListView.builder(
                              itemBuilder: (ctx, index) {
                                return Text(
                                  leaveListItem.approvalList[index]
                                              .employeeName !=
                                          null
                                      ? leaveListItem
                                          .approvalList[index].employeeName
                                      : "-",
                                  style: TextStyle(
                                    color: AppTheme.kPrimaryColor,
                                  ),
                                );
                              },
                              itemCount: leaveListItem.approvalList.length,
                            ),
                          ))
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppTheme.kPrimaryLightColor.withOpacity(0.4),
                ),
                width: double.infinity,
                height: 120,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      margin: MyApp.isEN
                          ? EdgeInsets.only(right: 15)
                          : EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 3,
                            color:
                                leaveListItem.getRightColor().withOpacity(0.2)),
                      ),
                      child: leaveListItem.getRightIcon(),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.swap_horizontal_circle,
                                color: leaveListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_STATUS),
                                  style: TextStyle(
                                      color: leaveListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  leaveListItem.request_status != null
                                      ? leaveListItem
                                          .request_status_displayValue
                                      : "-",
                                  style: TextStyle(
                                      color: leaveListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: leaveListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_FROM)+" :",
                                  style: TextStyle(
                                      color: leaveListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  leaveListItem.start_date != null
                                      ? leaveListItem.start_date
                                      : "-",
                                  style: TextStyle(
                                      color: leaveListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                  leaveListItem.start_time != null
                                      ? ApplicationController.formatToHours(
                                          leaveListItem.start_time)
                                      : "-",
                                  style: TextStyle(
                                      color: leaveListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3))
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: leaveListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_TO)+" :",
                                  style: TextStyle(
                                      color: leaveListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  leaveListItem.end_date != null
                                      ? leaveListItem.end_date
                                      : "-",
                                  style: TextStyle(
                                      color: leaveListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                  leaveListItem.end_time != null
                                      ? ApplicationController.formatToHours(
                                          leaveListItem.end_time)
                                      : "-",
                                  style: TextStyle(
                                      color: leaveListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3))
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: leaveListItem.getRightColor(),
                                      size: 25,
                                    ),
                                    tooltip: 'details',
                                    hoverColor: leaveListItem.getRightColor(),
                                    splashColor: leaveListItem.getRightColor(),
                                    onPressed: () {
                                      _asyncConfirmDialog(context);
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
