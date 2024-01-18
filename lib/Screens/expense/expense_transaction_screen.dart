import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/expense/expense_controller.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/expense_transaction_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';

class ExpenseTransactionScreen extends StatefulWidget {
  static final id = "ExpenseTransactionScreen";

  @override
  _ExpenseTransactionScreenState createState() =>
      _ExpenseTransactionScreenState();
}

class _ExpenseTransactionScreenState extends State<ExpenseTransactionScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  ExpenseController? _expenseController;
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
    fromDate = format.format(lastWeek); // Sets toDate to last week's date
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _expenseController = ExpenseController();
    getLastExpenseTransaction();
    super.initState();
  }

  void getLastExpenseTransaction() async {
    await _expenseController!.getDefualtSearch(context).then((value) {
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
      screenName: AppTranslations.of(context)!.text(Const.LOCALE_KEY_MY_EXPENSE),
      screenWidget: ExpenseScreen(),
    );
  }

  Widget ExpenseScreen() {
    final format = DateFormat(Const.DATE_FORMAT);
    bool _isPressed = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),decoration: BoxDecoration(
            // color: AppTheme.kPrimaryLightColor.withOpacity(.6),
              borderRadius: BorderRadius.circular(30)),
       child: Padding(
         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      await _expenseController!
                          .getExpenseTransaction(fromDate!, toDate!)
                          .then((value) {
                            if (_expenseController!.expenseList.isEmpty) {
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
                    }

                    },
                ),
              ],
            ),
            // Additional components (e.g., filter buttons) can be added here
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
                    itemCount: _expenseController!.expenseList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          _expenseController!.expenseList.length > 10
                              ? 10
                              : _expenseController!.expenseList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController!.forward();

                      return ExpenseView(
                        expenseListItem: _expenseController!.expenseList[index],
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

  Widget _buildFilterButton(BuildContext context, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: ModernTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ModernTheme.gradientEnd),
        ),
        child: Text(
          label,
          style: TextStyle(color: ModernTheme.textColor),
        ),
      ),
    );
  }
  Widget _buildDateField(BuildContext context, String label, Function(DateTime?) onChanged, DateFormat format) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
        DateTimeField(
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          format: format,
          initialValue: label == "From"
              ? DateFormat("yyyy-MM-dd").parse(fromDate!)
              : DateFormat("yyyy-MM-dd").parse(toDate!),
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
          decoration: InputDecoration(
            border: OutlineInputBorder( // Updated border
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ModernTheme.accentColor),
            ),
            filled: true,
            fillColor: ModernTheme.backgroundColor.withOpacity(0.24), // Dark Blue as the fill color
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

class ExpenseView extends StatelessWidget {
  const ExpenseView({
    Key? key,
    this.expenseListItem,
    this.animationController,
    this.animation,
    this.callback
  }) : super(key: key);

  final VoidCallback? callback;
  final ExpenseTransactionResponse? expenseListItem;
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
            backgroundColor: ModernTheme.accentColor, // Using the accent color for background
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ModernTheme.gradientStart, // Using gradient start color
                  onPrimary: ModernTheme.gradientEnd, // Using gradient end color
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
                gradient: ModernTheme.backgroundGradient, // Using background gradient
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
                        AppTranslations.of(context)!.text(Const.LOCALE_KEY_EXPENSE_DETAILS),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.blueGrey, // Matching the color as in the first dialog
                        ),
                      ),
                    ),                    _buildDetailTile(context, Const.LOCALE_KEY_EXPENSE_APPROVED_AMOUNT,
                        expenseListItem!.approved_amount?.toString() ?? "-"),
                    _buildDetailTile(context, Const.LOCALE_KEY_EXPENSE_AMOUNT,
                        expenseListItem!.expense_amount?.toString() ?? "-"),
                    _buildDetailTile(context, Const.LOCALE_KEY_EXPENSE_CURRANCY,
                        expenseListItem!.currency_display_name ?? "-"),
                    _buildDetailTile(context, Const.LOCALE_KEY_EXPENSE_DATE,
                        expenseListItem!.expense_date ?? "-"),
                    _buildDetailTile(context, Const.LOCALE_KEY_EXPENSE_APPROVE_DATE,
                        expenseListItem!.approval_date ?? "-"),
                    _buildDetailTile(context, Const.LOCALE_KEY_NOTES,
                        expenseListItem!.description ?? "-"),
                  ],
                ),
              ),
            ),
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
                    _buildIcon(expenseListItem),
                    Expanded(child: _buildExpenseInfo(context!, expenseListItem)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(ExpenseTransactionResponse? expenseListItem) {
    return Container(
      width: 50,
      height: 50,
      margin: MyApp.isEN ? EdgeInsets.only(right: 15) : EdgeInsets.only(
          left: 15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: expenseListItem!.getRightColor()!,
        ),
      ),
      child: Center(
        child: expenseListItem.getRightIcon(),
      ),
    );
  }

  Widget _buildExpenseInfo(BuildContext context, ExpenseTransactionResponse? expenseListItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          expenseListItem!.status_display_name, // Assuming this is the name/title of the leave
          style: TextStyle(
            color: ModernTheme.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 6),
        _buildRow(
          Icons.swap_horizontal_circle,
          AppTranslations.of(context)!.text(Const.LOCALE_KEY_STATUS),
          expenseListItem.request_status ?? "-",
          context,
          expenseListItem.getRightColor(),
        ),
        _buildRow(
          Icons.calendar_today,
          AppTranslations.of(context)!.text(Const.LOCALE_KEY_FROM),
          expenseListItem.request_date ?? "-",
          context,
          expenseListItem.getRightColor(),
        ),
        // ... add more rows for other details like end date/time ...
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
  Widget _buildRow(IconData icon, String label, String value, BuildContext context, Color? color) {
    return Row(
      children: <Widget>[
        Icon(icon, color: color, size: 20),
        SizedBox(width: 5),
        Text(label, style: TextStyle(color: color, fontSize: 13, letterSpacing: .3)),
        Text(value, style: TextStyle(color: color, fontSize: 13, letterSpacing: .3)),
      ],
    );
  }

}
