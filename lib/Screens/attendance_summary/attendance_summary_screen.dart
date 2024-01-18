import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/attendance_summary/attendance_summary_controller.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/attendance_summary_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class AttendanceSummaryScreen extends StatefulWidget {
  static final id = "AttendanceSummaryScreen";

  @override
  _AttendanceSummaryScreenState createState() =>
      _AttendanceSummaryScreenState();
}

class _AttendanceSummaryScreenState extends State<AttendanceSummaryScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  AttendanceSummaryController? _attendanceSummaryController;
  String? fromDate;
  String? toDate;
  bool showSpinner = false;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _attendanceSummaryController = AttendanceSummaryController();
    getLastAttendanceTransaction();
    super.initState();
  }

  void getLastAttendanceTransaction() async {
    await _attendanceSummaryController!.getDefualtSearch().then((value) {
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
      screenName:
          AppTranslations.of(context)!.text(Const.LOCALE_KEY_ATTENDANCE_SUMMARY),
      screenWidget: AttendanceScreen(),
    );
  }

  Widget AttendanceScreen() {
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
                    children: [
                      Expanded(
                          flex: 0,
                          child: Text(
                              AppTranslations.of(context)!
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
                              AppTranslations.of(context)!
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
                          await _attendanceSummaryController!
                              .getAttendanceSummaryTransaction(fromDate!, toDate!)
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
                    itemCount:
                        _attendanceSummaryController!.attendanceList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = _attendanceSummaryController
                      ! .attendanceList.length >
                              10
                          ? 10
                          : _attendanceSummaryController!
                              .attendanceList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController!.forward();

                      return AttendanceView(
                        attendanceItem: _attendanceSummaryController!
                            .attendanceList[index],
                        animation: animation,
                        animationController: animationController!,
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


class AttendanceView extends StatelessWidget {
  const AttendanceView(
      {Key? key,
      this.attendanceItem,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final AttendanceSummaryResponse? attendanceItem;
  final AnimationController? animationController;
  final Animation<dynamic>? animation;

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
                  color: AppTheme.kPrimaryLightColor.withOpacity(0.4),
                ),
                width: double.infinity,
                height: 90,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                                color: AppTheme.green,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  attendanceItem!.rec_date != null
                                      ? attendanceItem!.rec_date
                                      : '',
                                  style: TextStyle(
                                      color: AppTheme.green,
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  height: 25,
                                  margin: MyApp.isEN ? EdgeInsets.only(right: 5):EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        width: 3,
                                        color: AppTheme.green
                                            .withOpacity(0.2)),
                                  ),
                                  child:  Icon(
                                    Icons.arrow_circle_down_outlined,
                                    color: AppTheme.green,
                                    size: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(attendanceItem!.check_in!=null ?attendanceItem!.check_in:"-",
                                    style: TextStyle(
                                        color: AppTheme.green,
                                        fontSize: 13,
                                        letterSpacing: .3)),

                                SizedBox(
                                  width: 15,
                                ),

                                Container(
                                  width: 25,
                                  height: 25,
                                  margin: MyApp.isEN ? EdgeInsets.only(right: 5):EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        width: 3,
                                        color: AppTheme.red
                                            .withOpacity(0.2)),
                                  ),
                                  child:  Icon(
                                    Icons.arrow_circle_up_outlined,
                                    color: AppTheme.red,
                                    size: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                    attendanceItem!.check_out != null
                                        ? attendanceItem!.check_out
                                        : '-',
                                    style: TextStyle(
                                        color: AppTheme.red,
                                        fontSize: 13,
                                        letterSpacing: .3)),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 6,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 14),
                          //   child: Row(
                          //     children: <Widget>[
                          //
                          //       Container(
                          //         width: 25,
                          //         height: 25,
                          //         margin: MyApp.isEN ? EdgeInsets.only(right: 5):EdgeInsets.only(left: 5),
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(50),
                          //           border: Border.all(
                          //               width: 3,
                          //               color: AppTheme.red
                          //                   .withOpacity(0.2)),
                          //         ),
                          //         child:  Icon(
                          //           Icons.arrow_circle_up_outlined,
                          //           color: AppTheme.red,
                          //           size: 15,
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         width: 5,
                          //       ),
                          //       Text(
                          //           AppTranslations.of(context)
                          //                   .text(Const.LOCALE_KEY_REC_TIME) +
                          //               ": ",
                          //           style: TextStyle(
                          //               color: AppTheme.red,
                          //               fontSize: 13,
                          //               letterSpacing: .3)),
                          //       Text(
                          //           attendanceItem.rec_time_Out != null
                          //               ? attendanceItem.rec_time_Out
                          //               : '-',
                          //           style: TextStyle(
                          //               color: AppTheme.red,
                          //               fontSize: 13,
                          //               letterSpacing: .3)),
                          //     ],
                          //   ),
                          // ),
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
