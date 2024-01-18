import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/extra_work_transaction_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';
import 'extra_work_controller.dart';

class ExtraWorkTransactionScreen extends StatefulWidget {
  static final id = "ExtraWorkTransactionScreen";

  @override
  _ExtraWorkTransactionScreenState createState() =>
      _ExtraWorkTransactionScreenState();
}

class _ExtraWorkTransactionScreenState extends State<ExtraWorkTransactionScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  ExtraWorkController? _extraWorkController;
  String? fromDate;
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
    _extraWorkController = ExtraWorkController();
    getLastExpenseTransaction();
    super.initState();
  }

  void getLastExpenseTransaction() async {
    await _extraWorkController!.getDefualtSearch(context).then((value) {
      setState(() {
        print(value);
      });
    });
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

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName:
          AppTranslations.of(context)!.text(Const.LOCALE_KEY_MY_EXTRA_WORK),
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
                        child: _buildDateField(
                          context,
                          'From',
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
                          'To',
                              (value) => setState(() {
                            toDate = value != null ? format.format(value) : "";
                          }),
                          format,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        tooltip: 'search',
                        hoverColor: AppTheme.kPrimaryColor,
                        splashColor: AppTheme.kPrimaryColor,
                        onPressed: () async {
                          if (fromDate == null || toDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please select both 'from date' and 'to date' to search.",
                                  style: TextStyle(color: ModernTheme.textColor),
                                ),
                                backgroundColor: ModernTheme.accentColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            );
                            return;
                          }
                          else{
                            setState(() {
                            hasShownNoDataDialog = false; // Reset the dialog flag on new search

                            showSpinner = true;
                          });
                          await _extraWorkController!
                              .getExtraWorkTransaction(fromDate!, toDate!)
                              .then((value) {
                            if (_extraWorkController!.extraWorkList.isEmpty) {
                              if (!hasShownNoDataDialog) {
                                showNoDataDialog(context);
                                hasShownNoDataDialog = true;
                              }
                            }
                          });
                          setState(() {
                            showSpinner = false;
                          });}

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
                    itemCount: _extraWorkController!.extraWorkList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          _extraWorkController!.extraWorkList.length > 10
                              ? 10
                              : _extraWorkController!.extraWorkList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController!.forward();

                      return ExtraWorkView(
                        extraWorkListItem:
                            _extraWorkController!.extraWorkList[index],
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
          initialValue: label == "From" ? DateFormat("yyyy-MM-dd").parse(fromDate!) : DateFormat("yyyy-MM-dd").parse(toDate!),

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

class ExtraWorkView extends StatelessWidget {
  const ExtraWorkView(
      {Key? key,
        this.extraWorkListItem,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final ExtraWorkTransactionResponse? extraWorkListItem;
  final AnimationController? animationController;
  final Animation<dynamic>? animation;

  Future _asyncConfirmDialog(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    return await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: ModernTheme.accentColor, // Using accent color for background
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ModernTheme.gradientStart,
                  onPrimary: ModernTheme.gradientEnd,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: ModernTheme.accentColor.withOpacity(0.5),
                  elevation: 10,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      AppTranslations.of(context)!.text(Const.LOCALE_KEY_EMPLOYMENT_CLOSE),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ModernTheme.accentColor, // Maintaining accent color for text
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
            content: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: ModernTheme.backgroundGradient, // Using the background gradient
                borderRadius: BorderRadius.circular(15),
              ),
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
                        AppTranslations.of(context)!
                            .text(Const.LOCALE_KEY_EXTRA_WORK_DETAILS),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          letterSpacing: 0.27,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,

                        child: ListTile(
                          title: Text(AppTranslations.of(context)!
                              .text(Const.LOCALE_KEY_EXTRA_WORK_DAY_TYPE),style: TextStyle( fontWeight: FontWeight.w600,        color: ModernTheme.textColor,),),
                          subtitle: Text(extraWorkListItem!.day_type != null
                              ? extraWorkListItem!.day_type_display_value
                              .toString()
                              : "-",style: TextStyle(        color: ModernTheme.textColor,),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: Text(AppTranslations.of(context)!
                              .text(Const.LOCALE_KEY_EXPENSE_APPROVE_DATE),style: TextStyle( fontWeight: FontWeight.w600,        color: ModernTheme.textColor,),),
                          subtitle: Text(
                              extraWorkListItem!.approval_date != null
                                  ? extraWorkListItem!.approval_date.toString()
                                  : "-",style: TextStyle(        color: ModernTheme.textColor,),),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: Text(AppTranslations.of(context)!
                              .text(Const.LOCALE_KEY_EXTRA_WORK_UNIT),style: TextStyle(    fontWeight: FontWeight.w600,     color: ModernTheme.textColor,),),
                          subtitle: Text(extraWorkListItem!.unit != null
                              ? extraWorkListItem!.unit_display_value
                              .toString()
                              : "-",style: TextStyle(        color: ModernTheme.textColor,),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: Text(AppTranslations.of(context)!.text(
                              Const.LOCALE_KEY_EXTRA_WORK_UNIT_QUANTITY),style: TextStyle(  fontWeight: FontWeight.w600,       color: ModernTheme.textColor,),),
                          subtitle: Text(
                              extraWorkListItem!.unit_quantity != null
                                  ? extraWorkListItem!.unit_quantity.toString()
                                  : "-",style: TextStyle(        color: ModernTheme.textColor,),),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: Text(AppTranslations.of(context)!
                              .text(Const.LOCALE_KEY_NOTES),style: TextStyle(     fontWeight: FontWeight.w600,    color: ModernTheme.textColor,),),
                          subtitle: Text(
                              extraWorkListItem!.extra_details != null
                                  ? extraWorkListItem!.extra_details
                                  : "-",style: TextStyle(        color: ModernTheme.textColor,),),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(AppTranslations.of(context)!
                            .text(Const.LOCALE_KEY_APPROVAL_INBOX) +
                            ": ",style: TextStyle(    fontWeight: FontWeight.w600,     color: ModernTheme.textColor,),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                            height: 100,
                            child: ListView.builder(
                              itemBuilder: (ctx, index) {
                                return Text(
                                  extraWorkListItem!.approvalList[index]
                                      .employeeName !=
                                      null
                                      ? extraWorkListItem!
                                      .approvalList[index].employeeName
                                      : "-",
                                  style: TextStyle(        color: ModernTheme.textColor,),
                                );
                              },
                              itemCount: extraWorkListItem!.approvalList.length,
                            ),
                          ))
                    ],
                  )
                ],
              ),
              ),
            ),
          );
        }
    );
  }

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
                height: 140,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildIcon(extraWorkListItem),
                    Expanded(child: _buildExtraWorkInfo(context, extraWorkListItem)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildRow(IconData icon, String label, String value) {
    return Row(
      children: <Widget>[
        Icon(icon, color: extraWorkListItem!.getRightColor(), size: 20),
        SizedBox(width: 5),
        Text(label, style: TextStyle(color: extraWorkListItem!.getRightColor(), fontSize: 13, letterSpacing: .3)),
        Text(value, style: TextStyle(color: extraWorkListItem!.getRightColor(), fontSize: 13, letterSpacing: .3)),
      ],
    );
  }

  _buildExtraWorkInfo(BuildContext? context, ExtraWorkTransactionResponse? extraWorkListItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          extraWorkListItem!.day_type_display_value,
          style: TextStyle(color: extraWorkListItem.getRightColor(), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 6),
        _buildRow(Icons.adjust, AppTranslations.of(context!)!.text(Const.LOCALE_KEY_STATUS),
            extraWorkListItem.status_display_value),
        _buildRow(Icons.calendar_today, AppTranslations.of(context)!.text(Const.LOCALE_KEY_EXTRA_WORK_REQUEST_DATE),
            extraWorkListItem.request_date),

        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.more_horiz, color: ModernTheme.accentColor, size: 25),
                tooltip: 'Details',
                onPressed: () => _asyncConfirmDialog(context),
              ),
            ],
          ),
        ),
      ],
    );
  }



  _buildIcon(ExtraWorkTransactionResponse? extraWorkListItem) {
    return Container(
      width: 50,
      height: 50,
      margin: MyApp.isEN ? EdgeInsets.only(right: 15) : EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: extraWorkListItem!.getRightColor()!,
        ),
      ),
      child: Center(
        child: extraWorkListItem.getRightIcon(),
      ),
    );
  }
}
