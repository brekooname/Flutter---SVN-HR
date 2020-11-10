import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/Screens/time_sheet/new_time_sheet_details_screen.dart';
import 'package:sven_hr/Screens/time_sheet/time_sheet_controller.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/time_sheet_details_list_response.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import 'models/time_sheet_details_list_item.dart';

class TimeSheetDetailsTransactionScreen extends StatefulWidget {
  static String id = "TimeSheetDetailsTransactionScreen";
  String timeSheetId;

  TimeSheetDetailsTransactionScreen(this.timeSheetId);

  @override
  _TimeSheetDetailsTransactionScreenState createState() =>
      _TimeSheetDetailsTransactionScreenState();
}

class _TimeSheetDetailsTransactionScreenState
    extends State<TimeSheetDetailsTransactionScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  TimeSheetController _timeSheetController;
  List<TimeSheetDetailsListItem> _detalisListItem;
  List<TimeSheetDetailsResponse> _detalisList;
  DateFormat format = DateFormat(Const.DATE_FORMAT);
  String timeSheetId;
  String startTime;
  String endTime = "";
  bool showSpinner = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _timeSheetController = TimeSheetController();
    _detalisListItem = List();
    _detalisList = List();
    timeSheetId = this.widget.timeSheetId;
    getDetailsTransaction();
    super.initState();
  }

  void getDetailsTransaction() async {
    await _timeSheetController
        .getTimeSheetDetailsTransaction(timeSheetId)
        .then((value) {
      setState(() {
        _detalisListItem = _timeSheetController.detalisListItem;
        _detalisList = _timeSheetController.detalisList;
      });
    });
  }

  void addNewTimeSheetHeader() async {
    // showSpinner = true;
    //     // await _timeSheetController
    //     //     .addNewTimeSheetHeader(startDate: startDate, rowId: null)
    //     //     .then((value) {
    //     //   if (value == null) {
    //     //     ToastMessage.showErrorMsg(Const.REQUEST_FAILED);
    //     //   } else if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
    //     //     ToastMessage.showSuccessMsg(Const.VACATION_SENT_SUCCESSFULLY);
    //     //     Navigator.of(context, rootNavigator: true).pop(value);
    //     //   } else {
    //     //     ToastMessage.showErrorMsg(value);
    //     //   }
    //     //   showSpinner = false;
    //     //   setState(() {});
    //     // });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TimeSheetDetailsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget TimeSheetDetailsScreen() {
    final format = DateFormat(Const.DATE_FORMAT);
    bool _isPressed = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
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
                      Flexible(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppTheme.kPrimaryColor,
                          ),
                          tooltip: 'search',
                          hoverColor: AppTheme.kPrimaryColor,
                          splashColor: AppTheme.kPrimaryColor,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                        flex: 1,
                      ),

                      Expanded(
                        child: Text(AppTranslations.of(context)
                            .text(Const.LOCALE_KEY_TIME_SHEET_DETAILS),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: AppTheme.kPrimaryColor,
                          ),

                        ),
                        flex: 4,
                      ),
                      Flexible(
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: AppTheme.red,semanticLabel: "test",
                          ),
                          tooltip: 'add',
                          hoverColor: AppTheme.kPrimaryColor,
                          splashColor: AppTheme.kPrimaryColor,
                          onPressed: () async {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewTimeSheetDetailsScreen(
                                        timeSheetId: timeSheetId,
                                      )),
                            )
                                .then((value) => {getDetailsTransaction()});
                          },
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Divider(color: AppTheme.kPrimaryLightColor,height: 5,)
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
                    itemCount: _detalisListItem.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = _detalisListItem.length > 10
                          ? 10
                          : _detalisListItem.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return TimeSheetDetailsView(
                        detailsListItem: _detalisListItem[index],
                        animation: animation,
                        animationController: animationController,
                        callback: () {},
                        detail: _detalisList[index],
                        editDetails: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewTimeSheetDetailsScreen(
                                          timeSheetId: timeSheetId,
                                          detailId: _detalisList[index],
                                        )),
                              )
                              .then((value) => {getDetailsTransaction()});
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

class TimeSheetDetailsView extends StatelessWidget {
  const TimeSheetDetailsView(
      {Key key,
      this.detailsListItem,
      this.animationController,
      this.animation,
      this.callback,
      this.detail,
      this.editDetails})
      : super(key: key);

  final VoidCallback callback;
  final TimeSheetDetailsListItem detailsListItem;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final TimeSheetDetailsResponse detail;
  final Function editDetails;

  Future _asyncConfirmDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppTheme.kPrimaryColor,
                ),
                tooltip: 'select',
                hoverColor: AppTheme.kPrimaryColor,
                splashColor: AppTheme.kPrimaryColor,
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
            content: Container(
              color: AppTheme.white,
              height: 300,
              width: 200.0,
              child: Column(
                children: [
                  Expanded(
                      flex: 0,
                      child: Text(
                          AppTranslations.of(context)
                              .text(Const.LOCALE_KEY_NOTES),
                          style: AppTheme.subtitle)),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: TextFieldContainer(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(detail.description),
                    )),
                  ),
                ],
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
                height: 180,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                            color: detailsListItem
                                .getRightColor()
                                .withOpacity(0.2)),
                      ),
                      child: detailsListItem.getRightIcon(),
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
                                Icons.lock_clock,
                                color: detailsListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_LEAVE_START_TIME),
                                  style: TextStyle(
                                      color: detailsListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  detailsListItem.startTime != null
                                      ? ApplicationController.formatToHours(
                                          detailsListItem.startTime)
                                      : '',
                                  style: TextStyle(
                                      color: detailsListItem.getRightColor(),
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
                                Icons.lock_clock,
                                color: detailsListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_LEAVE_END_TIME),
                                  style: TextStyle(
                                      color: detailsListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  detailsListItem.endTime != null
                                      ? ApplicationController.formatToHours(
                                          detailsListItem.endTime)
                                      : '',
                                  style: TextStyle(
                                      color: detailsListItem.getRightColor(),
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
                                Icons.hourglass_bottom,
                                color: detailsListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_WORKING_HOUR),
                                  style: TextStyle(
                                      color: detailsListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  detailsListItem.workingHour != null
                                      ? detailsListItem.workingHour.toStringAsFixed(3)
                                      : '',
                                  style: TextStyle(
                                      color: detailsListItem.getRightColor(),
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
                                Icons.filter_tilt_shift_sharp,
                                color: detailsListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_STATUS),
                                  style: TextStyle(
                                      color: detailsListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  detailsListItem.status != null
                                      ? detailsListItem.status.toString()
                                      : '',
                                  style: TextStyle(
                                      color: detailsListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.dynamic_feed,
                                color: detailsListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_TIME_PROJECT_NAME),
                                  style: TextStyle(
                                      color: detailsListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Expanded(
                                child: Text(
                                    detailsListItem.projectName != null
                                        ? detailsListItem.projectName.toString()
                                        : '',
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: detailsListItem.getRightColor(),
                                        fontSize: 13,
                                        letterSpacing: .3)),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: detailsListItem.getRightColor(),
                                      size: 25,
                                    ),
                                    tooltip: 'search',
                                    hoverColor: detailsListItem.getRightColor(),
                                    splashColor:
                                        detailsListItem.getRightColor(),
                                    onPressed: editDetails),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.notes,
                                      color: detailsListItem.getRightColor(),
                                      size: 25,
                                    ),
                                    tooltip: 'search',
                                    hoverColor: detailsListItem.getRightColor(),
                                    splashColor:
                                        detailsListItem.getRightColor(),
                                    onPressed: () {
                                      _asyncConfirmDialog(context);
                                    }),
                              ],
                            ),
                          )
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
