import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/Screens/time_sheet/models/time_sheet_header_list_item.dart';
import 'package:sven_hr/Screens/time_sheet/time_sheet_controller.dart';
import 'package:sven_hr/Screens/time_sheet/time_sheet_details_transaction_screen.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/single_selection_listview.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/time_sheet_header_transaction_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class TimeSheetScreen extends StatefulWidget {
  static String id = "TimeSheetScreen";
  @override
  _TimeSheetScreenState createState() => _TimeSheetScreenState();
}

class _TimeSheetScreenState extends State<TimeSheetScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  TimeSheetController _timeSheetController;
  List<TimeSheetHeaderListItem> _timeSheetHeaderListItem;
  List<TimeSheetHeaderTransactionResponse> _timeSheetHeaderList;
  DateFormat format = DateFormat(Const.DATE_FORMAT);

  String fromDate;
  String startDate = "";
  String toDate;
  bool showSpinner = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _timeSheetController = TimeSheetController();
    _timeSheetHeaderListItem = List();
    _timeSheetHeaderList = List();
    getLastLastHeaderTransaction();
    super.initState();
  }

  void getLastLastHeaderTransaction() async {
    await _timeSheetController.getDefualtSearch().then((value) {
      setState(() {
        _timeSheetHeaderListItem = _timeSheetController.timeSheetHeaderListItem;
        _timeSheetHeaderList = _timeSheetController.timeSheetHeaderList;
      });
    });
  }

  void getSelfTimeSheetHeaderTransaction() async {
    await _timeSheetController
        .getSelfTimeSheetHeaderTransaction(fromDate, toDate)
        .then((value) {
      setState(() {
        _timeSheetHeaderListItem = _timeSheetController.timeSheetHeaderListItem;
        _timeSheetHeaderList = _timeSheetController.timeSheetHeaderList;
      });
    });
  }

  void addNewTimeSheetHeader() async {
    showSpinner = true;
    await _timeSheetController
        .addNewTimeSheetHeader(startDate: startDate, rowId: null)
        .then((value) {
      if (value == null) {
        ToastMessage.showErrorMsg(Const.REQUEST_FAILED);
      } else if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
        ToastMessage.showSuccessMsg(Const.REQUEST_SENT_SUCCESSFULLY);
        Navigator.of(context, rootNavigator: true).pop(value);
      } else {
        ToastMessage.showErrorMsg(value);
      }
      showSpinner = false;
      setState(() {});
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName: AppTranslations.of(context).text(Const.LOCALE_KEY_TIME_SHEET),
      screenWidget: TimeSheetScreen(),
    );
  }

  Future _asyncConfirmDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: AppTheme.kPrimaryColor,
                ),
                tooltip: 'select',
                hoverColor: AppTheme.kPrimaryColor,
                splashColor: AppTheme.kPrimaryColor,
                onPressed: () async {
                  await addNewTimeSheetHeader();
                },
              ),
            ],
            content: Container(
              color: AppTheme.white,
              height: 100,
              width: 200.0,
              child: Column(
                children: [
                  Expanded(
                      flex: 0,
                      child: Text(
                          AppTranslations.of(context)
                              .text(Const.LOCALE_KEY_ADD_NEW_TIME_SHEET),
                          style: AppTheme.subtitle)),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 0,
                          child: Text(
                              AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_START_DATE),
                              style: AppTheme.subtitle)),
                      Expanded(
                        child: DateTimeField(
                          textAlign: TextAlign.center,
                          style: AppTheme.subtitle,
                          format: format,
                          onChanged: (value) {
                            setState(() {
                              if (value != null)
                                startDate = format.format(value);
                              else
                                startDate = "";
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
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget TimeSheetScreen() {
    final format = DateFormat(Const.DATE_FORMAT);
    bool _isPressed = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
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
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
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
                      SizedBox(
                        width: 20,
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
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IconButton(
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
                            getSelfTimeSheetHeaderTransaction();
                            setState(() {
                              showSpinner = false;
                            });
                          },
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: AppTheme.kPrimaryColor,
                          ),
                          tooltip: 'search',
                          hoverColor: AppTheme.kPrimaryColor,
                          splashColor: AppTheme.kPrimaryColor,
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            String result = await _asyncConfirmDialog(context);
                            if (result != null &&
                                result.compareTo(Const.SYSTEM_SUCCESS_MSG) ==
                                    0) {
                              await getLastLastHeaderTransaction();
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          },
                        ),
                        flex: 1,
                      )
                    ],
                  )
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
                    itemCount: _timeSheetHeaderListItem.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = _timeSheetHeaderListItem.length > 10
                          ? 10
                          : _timeSheetHeaderListItem.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return TimeSheetView(
                        headerListItem: _timeSheetHeaderListItem[index],
                        animation: animation,
                        animationController: animationController,
                        callback: () {},
                        header: _timeSheetHeaderList[index],
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

class TimeSheetView extends StatelessWidget {
  const TimeSheetView(
      {Key key,
      this.headerListItem,
      this.animationController,
      this.animation,
      this.callback,
      this.header})
      : super(key: key);

  final VoidCallback callback;
  final TimeSheetHeaderListItem headerListItem;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final TimeSheetHeaderTransactionResponse header;
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
                height: 160,
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
                            color: headerListItem
                                .getRightColor()
                                .withOpacity(0.2)),
                      ),
                      child: headerListItem.getRightIcon(),
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
                                Icons.calendar_today,
                                color: headerListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_START_DATE),
                                  style: TextStyle(
                                      color: headerListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  headerListItem.startDate != null
                                      ? headerListItem.startDate
                                      : '',
                                  style: TextStyle(
                                      color: headerListItem.getRightColor(),
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
                                Icons.work_outline,
                                color: headerListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_WORKING_HOUR),
                                  style: TextStyle(
                                      color: headerListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  headerListItem.workingHour != null
                                      ? headerListItem.workingHour.toStringAsFixed(3)
                                      : '',
                                  style: TextStyle(
                                      color: headerListItem.getRightColor(),
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
                                color: headerListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_SHIFT_TYPE_HOUR),
                                  style: TextStyle(
                                      color: headerListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  headerListItem.shiftTypeHour != null
                                      ? headerListItem.shiftTypeHour.toString()
                                      : '',
                                  style: TextStyle(
                                      color: headerListItem.getRightColor(),
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
                                Icons.rotate_90_degrees_ccw,
                                color: headerListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_DIFFERENCE_HOUR),
                                  style: TextStyle(
                                      color: headerListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  headerListItem.differenceHour != null
                                      ? headerListItem.differenceHour.toStringAsFixed(3)
                                      : '',
                                  style: TextStyle(
                                      color: headerListItem.getRightColor(),
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
                                      Icons.arrow_forward_ios,
                                      color: headerListItem.getRightColor(),
                                      size: 25,
                                    ),
                                    tooltip: 'search',
                                    hoverColor: headerListItem.getRightColor(),
                                    splashColor: headerListItem.getRightColor(),
                                    onPressed: () async {
                                      Navigator.of(context)
                                          .push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TimeSheetDetailsTransactionScreen(
                                                        header.row_id)),
                                          )
                                          .then((value) =>
                                              {if (value != null) {}});
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
