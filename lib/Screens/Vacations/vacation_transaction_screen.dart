import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_controller.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/dao/vacation_type.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/vacation_transaction_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';

class VacationsTransaction extends StatefulWidget {
  static final id = "VacationsTransaction";
  @override
  _VacationsTransactionState createState() => _VacationsTransactionState();
}

class _VacationsTransactionState extends State<VacationsTransaction>
    with TickerProviderStateMixin {
  bool hasShownNoDataDialog = false; // Add this flag

  AnimationController? animationController;
  LovValue? statusValue;
  VacationType? typeValue;
  VacationTransactionController? _vacationTransactionController;
  List<LovValue>? statusList;
  List<VacationType>? typeList;
  String? fromDate;
  String? toDate;
  bool showSpinner = false;
  @override
  void initState() {
    final DateFormat format = DateFormat("yyyy-MM-dd");
    DateTime now = DateTime.now();
    DateTime lastWeek = now.subtract(Duration(days: 7));

    toDate = format.format(now); // Sets fromDate to today's date
    fromDate = format.format(lastWeek); // Sets toDate to last week's date

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _vacationTransactionController = VacationTransactionController();
    LoadVacationStatus();
    LoadVacationType();
    getLastMonthVacationTransaction();
    super.initState();
  }

  void getLastMonthVacationTransaction() async {
    // setState(() {
    //   showSpinner=true;
    // });
    await _vacationTransactionController!.getDefualtSearch(context).then((value) {
      setState(() {
        showSpinner = false;
      });
    });
  }

  void reset() {
    statusList!.forEach((element) {
      element.isSelected = false;
    });
    typeList!.forEach((element) {
      element.isSelected = false;
    });
  }

  void LoadVacationStatus() async {
    statusList = [];

    await _vacationTransactionController!.loadVacationStatus().then((value) {
      setState(() {
        statusList!.addAll(value!);
        statusValue = statusList![0];
      });
    });
  }

  void LoadVacationType() async {
    typeList = [];

    await _vacationTransactionController!.loadVacationTypes().then((value) {
      setState(() {
        typeList!.addAll(value!);
        typeValue = typeList![0];
      });
    });
  }

  Future<bool> getData() async {
    // await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName: AppTranslations.of(context)!.text(Const.LOCALE_KEY_VACATION),
      screenWidget: VacationScreen(),
    );
  }

  @override
  dispose() {
    animationController!.dispose(); // you need this
    super.dispose();
  }

  Widget VacationScreen() {
    final format = DateFormat(Const.DATE_FORMAT);
    bool _isPressed = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),



            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFilterButton(context, 'Status', () {
                        setState(() {
                          _isPressed = true;
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return MultiSelectionLOVListView(
                                  lovs: statusList!,
                                );
                              });
                        });
                      }),
                      _buildFilterButton(context, 'Type', () {
                        setState(() {
                          _isPressed = true;
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return MultiSelectionTypeListView(
                                  types: typeList!,
                                );
                              });
                        });
                      }),
                      IconButton(
                        icon: Icon(Icons.refresh, color: Colors.white),
                        tooltip: 'Reset',
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildDateField(
                          context,
                          'From',
                              (value) => setState(() => fromDate = value),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildDateField(
                          context,
                          'To',
                              (value) => setState(() => toDate = value),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        tooltip: 'Search',
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
    await _vacationTransactionController
    !.advancedSearch(
    fromDate!, toDate!, statusList!, typeList!,context)
        .then((value) {
      if (_vacationTransactionController!.vacationList.isEmpty) {
        if (!hasShownNoDataDialog) {
          showNoDataDialog(context);
          hasShownNoDataDialog = true;
        }
        }
    setState(() {
    print(value);
    });
    });
    setState(() {
    showSpinner = false;
    });
    }}





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
              if (_vacationTransactionController!.vacationList.length==0||!snapshot.hasData) {

                return const SizedBox();
              } else {

                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount:
                        _vacationTransactionController!.vacationList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = _vacationTransactionController
                                  !.vacationList.length >
                              10
                          ? 10
                          : _vacationTransactionController!.vacationList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((0.5 / count) * index, 0.5,
                                      curve: Curves.fastOutSlowIn)));
                      animationController!.forward();

                      return VacationView(
                        vacationListItem:
                            _vacationTransactionController!.vacationList[index],
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


  Widget _buildDateField(BuildContext context, String label, Function(String) onChanged,) {
    final DateFormat format = DateFormat("yyyy-MM-dd");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label, style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
        DateTimeField(
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold
        ),
          format: format,
          initialValue: label == "From" ? DateFormat("yyyy-MM-dd").parse(fromDate!) : DateFormat("yyyy-MM-dd").parse(toDate!),

          onShowPicker: (context, currentValue) async {
            var date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (date != null) onChanged(format.format(date));
            return date;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ModernTheme.accentColor),
            ),
            filled: true,iconColor: Colors.white,
            fillColor: ModernTheme.backgroundColor.withOpacity(0.24), // Dark Blue as the fill color
           ),


        ),
      ],
    );
  }
  Widget _buildFilterButton(BuildContext context, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: ModernTheme.backgroundColor, // Complementary lighter blue for the button
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ModernTheme.gradientEnd), // Use gradientEnd color for the border
        ),


        child: Text(
          label,
          style: TextStyle(color:
          ModernTheme.textColor,
          ),
        ),
      ),
    );
  }
}

class VacationView extends StatelessWidget {
  const VacationView(
      {Key? key,
      this.vacationListItem,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final VacationTransactionResponse? vacationListItem;
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
            backgroundColor: ModernTheme.accentColor,
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
                        color: ModernTheme.accentColor,
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
                  gradient: ModernTheme.backgroundGradient,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: size.height / 2,
                width: size.width / 2,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          AppTranslations.of(context)!.text(Const.LOCALE_KEY_VACATION_DETAILS),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      _buildDetailTile(
                          context,
                          Const.LOCALE_KEY_TRANSACTION_STATUS,
                          vacationListItem!.trans_status != null
                              ? vacationListItem!.trans_status_displayValue.toString()
                              : "-"
                      ),
                      _buildDetailTile(
                          context,
                          Const.LOCALE_KEY_REQUEST_DATE,
                          vacationListItem!.request_date ?? "-"
                      ),
                      _buildDetailTile(
                          context,
                          Const.LOCALE_KEY_TYPE,
                          vacationListItem!.vacation_location != null
                              ? vacationListItem!.vacation_location_displayValue
                              : "-"
                      ),
                      _buildDetailTile(
                          context,
                          Const.LOCALE_KEY_NOTES,
                          vacationListItem!.remark ?? "-"
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          AppTranslations.of(context)!.text(Const.LOCALE_KEY_APPROVAL_INBOX) + ":",
                          style: TextStyle(
                            color: ModernTheme.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                     ],
                  ),
                ),
              )




          );
        }
    );
  }
  Widget _buildDetailTile(BuildContext context, String localeKey, String detail) {
    return ListTile(
      title: Text(
        AppTranslations.of(context)!.text(localeKey),
        style: TextStyle(color: ModernTheme.textColor, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        detail,
        style: TextStyle(color: ModernTheme.textColor),
      ),
    );
  }
  Widget _buildRow(IconData icon, String label, String value) {
    return Row(
      children: <Widget>[
        Icon(icon, color:  vacationListItem?.getRightColor(), size: 20),
        SizedBox(width: 5),
        Text(label, style: TextStyle(color:  vacationListItem?.getRightColor(), fontSize: 13, letterSpacing: .3)),
        Text(value, style: TextStyle(color:  vacationListItem?.getRightColor(), fontSize: 13, letterSpacing: .3)),
      ],
    );
  }
  Widget _buildVacationInfo(BuildContext context, VacationTransactionResponse? vacationListItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          vacationListItem!.vacation_Name,
          style: TextStyle(color: vacationListItem.getRightColor(), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 6),
        _buildRow(Icons.adjust, AppTranslations.of(context)!.text(Const.LOCALE_KEY_STATUS),
            vacationListItem.request_status_displayValue),
        _buildRow(Icons.calendar_today, AppTranslations.of(context)!.text(Const.LOCALE_KEY_FROM),
            vacationListItem.start_date),
        _buildRow(Icons.calendar_today, AppTranslations.of(context)!.text(Const.LOCALE_KEY_TO),
            vacationListItem.end_date),
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
  Widget _buildIcon(VacationTransactionResponse? vacationListItem) {
    return Container(
      width: 50,
      height: 50,
      margin: MyApp.isEN ? EdgeInsets.only(right: 15) : EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: vacationListItem!.getRightColor()!,
        ),
      ),
      child: Center(
        child: vacationListItem.getRightIcon(),
      ),
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
                height: 130,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildIcon(vacationListItem),
                    Expanded(child: _buildVacationInfo(context!, vacationListItem)),
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
