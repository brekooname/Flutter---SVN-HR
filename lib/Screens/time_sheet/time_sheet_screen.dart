import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/Screens/time_sheet/models/time_sheet_header_list_item.dart';
import 'package:sven_hr/Screens/time_sheet/time_sheet_controller.dart';
import 'package:sven_hr/Screens/time_sheet/time_sheet_details_transaction_screen.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/time_sheet_header_transaction_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';

class TimeSheetScreen extends StatefulWidget {
  static String id = "TimeSheetScreen";
  @override
  _TimeSheetScreenState createState() => _TimeSheetScreenState();
}

class _TimeSheetScreenState extends State<TimeSheetScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  TimeSheetController? _timeSheetController;
  List<TimeSheetHeaderListItem>? _timeSheetHeaderListItem;
  List<TimeSheetHeaderTransactionResponse>? _timeSheetHeaderList;
  DateFormat format = DateFormat(Const.DATE_FORMAT);

  String? fromDate;
  String startDate = "";
  String? toDate;
  bool showSpinner = false;
  bool hasShownNoDataDialog = false; // Add this flag

  @override
  void initState() {
    final DateFormat format = DateFormat("yyyy-MM-dd");
    DateTime now = DateTime.now();
    DateTime lastWeek = now.subtract(Duration(days: 7));

    toDate = format.format(now); // Sets fromDate to today's date
    fromDate = format.format(lastWeek);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _timeSheetController = TimeSheetController();
    _timeSheetHeaderListItem = <TimeSheetHeaderListItem>[];
    _timeSheetHeaderList = <TimeSheetHeaderTransactionResponse>[];
    getLastLastHeaderTransaction();
    super.initState();
  }

  void getLastLastHeaderTransaction() async {
    await _timeSheetController!.getDefualtSearch(context).then((value) {
      setState(() {
        _timeSheetHeaderListItem = _timeSheetController!.timeSheetHeaderListItem;
        _timeSheetHeaderList = _timeSheetController!.timeSheetHeaderList;
      });
    });
  }

  void getSelfTimeSheetHeaderTransaction() async {

    await _timeSheetController!
        .getSelfTimeSheetHeaderTransaction(fromDate!, toDate!)
        .then((value) {
      setState(() {
        _timeSheetHeaderListItem = _timeSheetController!.timeSheetHeaderListItem;
        _timeSheetHeaderList = _timeSheetController!.timeSheetHeaderList;
      });
    });
  }

  void addNewTimeSheetHeader() async {
    showSpinner = true;
    await _timeSheetController!
        .addNewTimeSheetHeader(startDate: startDate, rowId: null)
        .then((value) {
      if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
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
      screenName: AppTranslations.of(context)!.text(Const.LOCALE_KEY_TIME_SHEET),
      screenWidget: TimeSheetScreen(),
    );
  }

  Future _asyncConfirmDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false, // Prevents closing the dialog by tapping outside

      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: ModernTheme.backgroundColor,
          title: Text(
            AppTranslations.of(context)!.text(Const.LOCALE_KEY_ADD_NEW_TIME_SHEET),
            style: TextStyle(
              color: ModernTheme.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size to fit content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTranslations.of(context)!.text(Const.LOCALE_KEY_START_DATE),
                style: TextStyle(
                  color: ModernTheme.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              DateTimeField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ModernTheme.textColor,
                  fontWeight: FontWeight.bold,
                ),
                format: format,
                onChanged: (value) {
                  setState(() {
                    startDate = value != null ? format.format(value) : "";
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
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    // Assuming 'showSpinner' is the boolean controlling the spinner
                    showSpinner = false;
                  });
                }
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: ModernTheme.textColor),
              ),
            ),

            IconButton(
              icon: Icon(
                Icons.send,
                color: ModernTheme.textColor,
              ),
              tooltip: 'select',
              onPressed: () async {
                  addNewTimeSheetHeader();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  Widget TimeSheetScreen() {
    final format = DateFormat(Const.DATE_FORMAT);
    bool _isPressed = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),

              boxShadow: [
                BoxShadow(
                  color: ModernTheme.accentColor.withOpacity(0.4),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                          context,
                          AppTranslations.of(context)!.text(Const.LOCALE_KEY_FROM),
                              (value) => setState(() {
                            fromDate = value != null ? format.format(value) : "";
                          }),
                          format,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildDateField(
                          context,
                          AppTranslations.of(context)!.text(Const.LOCALE_KEY_TO),
                              (value) => setState(() {
                            toDate = value != null ? format.format(value) : "";
                          }),
                          format,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        tooltip: 'search',
                        hoverColor: ModernTheme.accentColor,
                        splashColor: ModernTheme.accentColor,
                        onPressed: () async {
                          setState(() {
                            hasShownNoDataDialog = false; // Reset the dialog flag on new search

                            showSpinner = true;
                          });
                          await _timeSheetController!
                              .getSelfTimeSheetHeaderTransaction(fromDate!, toDate!)
                              .then((value) {

                            if (_timeSheetController!.timeSheetHeaderList.isEmpty) {
                            if (_timeSheetController!.timeSheetHeaderListItem.isEmpty) {

                              if (!hasShownNoDataDialog) {
                                showNoDataDialog(context);
                                hasShownNoDataDialog = true;
                              }
                            }
                            }
                            else
                          setState(() {
                          _timeSheetHeaderListItem = _timeSheetController!.timeSheetHeaderListItem;
                          _timeSheetHeaderList = _timeSheetController!.timeSheetHeaderList;
                          });
                          });



                          setState(() {
                            showSpinner = false;
                          });
                        },
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                              color: Colors.white
                          ),
                          tooltip: 'add',
                          hoverColor: AppTheme.kPrimaryColor,
                          splashColor: ModernTheme.accentColor,
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            String? result = await _asyncConfirmDialog(context);
                            if (result!.compareTo(Const.SYSTEM_SUCCESS_MSG) ==
                                0) {
                              getLastLastHeaderTransaction();
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          },
                        ),
                        flex: 1,
                      )
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
                    itemCount: _timeSheetHeaderListItem!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = _timeSheetHeaderListItem!.length > 10
                          ? 10
                          : _timeSheetHeaderListItem!.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController!.forward();

                      return TimeSheetView(
                        headerListItem: _timeSheetHeaderListItem![index],
                        animation: animation,
                        animationController: animationController!,
                        callback: () {},
                        header: _timeSheetHeaderList![index],
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
  void showNoDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: ModernTheme.backgroundColor, // Use your preferred background color
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.info_outline,
                  color: ModernTheme.accentColor, // Use your preferred accent color
                  size: 50.0, // Icon size
                ),
                SizedBox(height: 20.0),
                Text(
                  'No Data Found',
                  style: TextStyle(
                    color: ModernTheme.textColor, // Use your preferred text color
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'No results match your search criteria. Please try again.',
                  style: TextStyle(
                    color: ModernTheme.textColor, // Use your preferred text color
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ModernTheme.accentColor, // Use your preferred accent color
                    elevation: 5, // Button elevation
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateField(BuildContext context, String label, Function(DateTime?) onChanged, DateFormat format) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label, style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold)),        DateTimeField(style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold),
          format: format,
          initialValue: label == AppTranslations.of(context)!.text(Const.LOCALE_KEY_FROM) ? DateFormat("yyyy-MM-dd").parse(fromDate!) : DateFormat("yyyy-MM-dd").parse(toDate!),

          onShowPicker: (context, currentValue) async {
            var date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
            );
            onChanged(date);
            return date;
          },

        ),
      ],
    );
  }

}

class TimeSheetView extends StatelessWidget {
  const TimeSheetView(
      {Key? key,
      this.headerListItem,
      this.animationController,
      this.animation,
      this.callback,
      this.header})
      : super(key: key);

  final VoidCallback? callback;
  final TimeSheetHeaderListItem? headerListItem;
  final AnimationController? animationController;
  final Animation<dynamic>? animation;
  final TimeSheetHeaderTransactionResponse? header;
  @override
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext? context, Widget? child) {
        return FadeTransition(
          opacity: animation as Animation<double>,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
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
                            color: ModernTheme.accentColor
                                .withOpacity(0.2)),
                      ),
                      child: headerListItem!.getRightIcon(),
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
                                color: ModernTheme.accentColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context!)!
                                      .text(Const.LOCALE_KEY_START_DATE),
                                  style: TextStyle(
                                      color: ModernTheme.accentColor,
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  headerListItem!.startDate != null
                                      ? headerListItem!.startDate!
                                      : '',
                                  style: TextStyle(
                                      color: ModernTheme.accentColor,
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
                                color: ModernTheme.accentColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)!
                                      .text(Const.LOCALE_KEY_WORKING_HOUR),
                                  style: TextStyle(
                                      color: ModernTheme.accentColor,
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  headerListItem!.workingHour != null
                                      ? headerListItem!.workingHour!.toStringAsFixed(3)
                                      : '',
                                  style: TextStyle(
                                      color: ModernTheme.accentColor,
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
                                color: ModernTheme.accentColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)!
                                      .text(Const.LOCALE_KEY_SHIFT_TYPE_HOUR),
                                  style: TextStyle(
                                      color: ModernTheme.accentColor,
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  headerListItem!.shiftTypeHour != null
                                      ? headerListItem!.shiftTypeHour.toString()
                                      : '',
                                  style: TextStyle(
                                      color: ModernTheme.accentColor,
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
                                color: ModernTheme.accentColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppTranslations.of(context)!
                                      .text(Const.LOCALE_KEY_DIFFERENCE_HOUR),
                                  style: TextStyle(
                                      color: ModernTheme.accentColor,
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  headerListItem!.differenceHour != null
                                      ? headerListItem!.differenceHour!.toStringAsFixed(3)
                                      : '',
                                  style: TextStyle(
                                      color: ModernTheme.accentColor,
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
                                      color: ModernTheme.accentColor,
                                      size: 25,
                                    ),
                                    tooltip: 'search',
                                    hoverColor: headerListItem!.getRightColor(),
                                    splashColor: headerListItem!.getRightColor(),
                                    onPressed: () async {
                                      Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TimeSheetDetailsTransactionScreen(
                                                    header!.row_id)),
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
