import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/Leaves/leaves_controller.dart';
import 'package:sven_hr/Screens/Leaves/models/leave_list_item.dart';
import 'package:sven_hr/Screens/attendance_summary/attendance_summary_controller.dart';
import 'package:sven_hr/Screens/attendance_summary/models/attendance_list_item.dart';
import 'package:sven_hr/Screens/expense/expense_controller.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/dao/vacation_type.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/attendance_summary_response.dart';
import 'package:sven_hr/models/response/expense_transaction_response.dart';
import 'package:sven_hr/models/response/extra_work_transaction_response.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import 'extra_work_controller.dart';

class ExtraWorkTransactionScreen extends StatefulWidget {
  static final id = "ExtraWorkTransactionScreen";

  @override
  _ExtraWorkTransactionScreenState createState() =>
      _ExtraWorkTransactionScreenState();
}

class _ExtraWorkTransactionScreenState extends State<ExtraWorkTransactionScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  ExtraWorkController _extraWorkController;
  String fromDate;
  String toDate;
  bool showSpinner = false;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _extraWorkController = ExtraWorkController();
    getLastExpenseTransaction();
    super.initState();
  }

  void getLastExpenseTransaction() async {
    await _extraWorkController.getDefualtSearch().then((value) {
      setState(() {
        print(value);
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
      screenName: AppTranslations.of(context).text(Const.LOCALE_KEY_MY_EXTRA_WORK),
      screenWidget: ExtraWorkScreen(),
    );
  }

  Widget ExtraWorkScreen() {
    final format = DateFormat(Const.DATE_FORMAT);
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
                          await _extraWorkController
                              .getExtraWorkTransaction(fromDate, toDate)
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
                    itemCount: _extraWorkController.extraWorkList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                      _extraWorkController.extraWorkList.length > 10
                          ? 10
                          : _extraWorkController.extraWorkList.length;
                      final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return ExtraWorkView(
                        extraWorkListItem: _extraWorkController.extraWorkList[index],
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

class ExtraWorkView extends StatelessWidget {
  const ExtraWorkView(
      {Key key,
        this.extraWorkListItem,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback callback;
  final ExtraWorkTransactionResponse extraWorkListItem;
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
                              .text(Const.LOCALE_KEY_EXTRA_WORK_DETAILS),
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
                            title: Text(AppTranslations.of(context).text(
                                Const.LOCALE_KEY_EXTRA_WORK_DAY_TYPE)),
                            subtitle: Text(
                                extraWorkListItem.day_type != null
                                    ? extraWorkListItem.day_type_display_value.toString()
                                    : "-"),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            title: Text(AppTranslations.of(context)
                                .text(Const.LOCALE_KEY_EXPENSE_APPROVE_DATE)),
                            subtitle: Text(
                                extraWorkListItem.approval_date != null
                                    ? extraWorkListItem.approval_date.toString()
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
                                .text(Const.LOCALE_KEY_EXTRA_WORK_UNIT)),
                            subtitle: Text(extraWorkListItem.unit != null
                                ? extraWorkListItem.unit_display_value.toString()
                                : "-"),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            title: Text(AppTranslations.of(context)
                                .text(Const.LOCALE_KEY_EXTRA_WORK_UNIT_QUANTITY)),
                            subtitle: Text(extraWorkListItem.unit_quantity != null
                                ? extraWorkListItem.unit_quantity.toString()
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
                            subtitle: Text(extraWorkListItem.extra_details != null
                                ? extraWorkListItem.extra_details
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
                    if(extraWorkListItem.approvalList!=null)
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    return Text(
                                      extraWorkListItem
                                          .approvalList[index].employeeName !=
                                          null
                                          ? extraWorkListItem
                                          .approvalList[index].employeeName
                                          : "-",
                                      style: TextStyle(
                                        color: AppTheme.kPrimaryColor,
                                      ),
                                    );
                                  },
                                  itemCount: extraWorkListItem.approvalList.length,
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
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      margin: MyApp.isEN
                          ? EdgeInsets.only(right: 10)
                          : EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 3,
                            color: extraWorkListItem
                                .getRightColor()
                                .withOpacity(0.2)),
                      ),
                      child: extraWorkListItem.getRightIcon(),
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
                                Icons.adjust,
                                color: extraWorkListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_STATUS),
                                  style: TextStyle(
                                      color: extraWorkListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  extraWorkListItem.status != null
                                      ? extraWorkListItem.status_display_value
                                      : '',
                                  style: TextStyle(
                                      color: extraWorkListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: extraWorkListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context).text(Const
                                      .LOCALE_KEY_EXTRA_WORK_REQUEST_DATE) +
                                      ": ",
                                  style: TextStyle(
                                      color: extraWorkListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  extraWorkListItem.request_date != null
                                      ? extraWorkListItem.request_date
                                      : "-",
                                  style: TextStyle(
                                      color: extraWorkListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
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
                                      color: extraWorkListItem.getRightColor(),
                                      size: 25,
                                    ),
                                    tooltip: 'search',
                                    hoverColor: extraWorkListItem.getRightColor(),
                                    splashColor:
                                    extraWorkListItem.getRightColor(),
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
