import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sven_hr/Screens/Leaves/leaves_controller.dart';
import 'package:sven_hr/Screens/Vacations/picker_screen.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_controller.dart';
import 'package:sven_hr/Screens/expense/expense_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/components/single_selection_listview.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/employee_vacation_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class ExpenseRequestScreen extends StatefulWidget {
  static String id = "ExpenseRequestScreen";
  @override
  _ExpenseRequestScreenState createState() => _ExpenseRequestScreenState();
}

class _ExpenseRequestScreenState extends State<ExpenseRequestScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  LovValue currencyValue;
  ExpenseController _expenseController;
  List<LovValue> currencyList;
  String expenseDate;
  num expenseAmount;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  String notes;
  bool showSpinner = false;
  // var vacationTextController = new TextEditingController();
  // var attachmentTextController = new TextEditingController();
  var expenseDateController = new TextEditingController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    _expenseController = ExpenseController();
    loadCurrency();
    super.initState();
  }

  void loadCurrency() async {
    currencyList = List();

    await _expenseController.loadCurrency().then((value) {
      setState(() {
        currencyList.addAll(value);
        // locationValue = locationList[0];
      });
    });
  }

  void sendExpenseValidation() async {
    if (currencyValue != null && expenseDate != null && expenseAmount != null) {
      await sendExpenseRequest();
    }
  }

  void sendExpenseRequest() async {
    buttonSendIsPressed = true;
    showSpinner = true;

    await _expenseController
        .sendExpenseRequest(
            currency: currencyValue.row_id,
            expenseDate: expenseDate,
            expenseAmount: expenseAmount,
            description: notes)
        .then((value) {
      if (value == null) {
        ToastMessage.showErrorMsg(Const.REQUEST_FAILED);
      } else if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
        ToastMessage.showSuccessMsg(Const.VACATION_SENT_SUCCESSFULLY);
        Navigator.pop(context);
      } else {
        ToastMessage.showErrorMsg(value);
      }
      buttonSendIsPressed = false;
      showSpinner = false;
      setState(() {});
    });
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat(Const.DATE_FORMAT);
    // final dateTimeFormat = DateFormat(Const.DATE_TIME_FORMAT);

    return Scaffold(
        backgroundColor: AppTheme.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: AppTheme.kPrimaryColor,
                                  ),
                                  tooltip: 'back',
                                  hoverColor: AppTheme.kPrimaryColor,
                                  splashColor: AppTheme.kPrimaryColor,
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_EXPENSE_REQUEST),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: AppTheme.kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 0,
                            child: TextFieldContainer(
                              child: SearchableDropdown.single(
                                underline: Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                value: currencyValue,
                                icon: Icon(
                                  Icons.menu_open_sharp,
                                  color: AppTheme.kPrimaryColor,
                                ),
                                clearIcon: Icon(
                                  Icons.close_sharp,
                                  color: AppTheme.kPrimaryColor,
                                  size: 20,
                                ),
                                hint: Text(AppTranslations.of(context)
                                    .text(Const.LOCALE_KEY_EXPENSE_CURRANCY)),
                                isExpanded: true,
                                style: TextStyle(color: AppTheme.kPrimaryColor),
                                items: currencyList
                                    .map<DropdownMenuItem<LovValue>>(
                                        (LovValue value) {
                                  return DropdownMenuItem<LovValue>(
                                    value: value,
                                    child: Text(
                                      value.display,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    currencyValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFieldContainer(
                              child: TextFormField(
                                validator: (value) => expenseAmount == null
                                    ? AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_REQUIRED)
                                    : null,
                                keyboardType: TextInputType.number,
                                cursorColor: AppTheme.kPrimaryColor,
                                decoration: InputDecoration(
                                  hintText: AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_EXPENSE_AMOUNT),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.format_list_numbered,
                                      color: AppTheme.kPrimaryColor,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    expenseAmount = num.tryParse(value);
                                  });
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFieldContainer(
                              child: DateTimeField(
                                controller: expenseDateController,
                                validator: (value) => value == null
                                    ? AppTranslations.of(context)
                                    .text(Const.LOCALE_KEY_REQUIRED)
                                    : null,
                                style: AppTheme.subtitle,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: AppTheme.kPrimaryColor,
                                  ),
                                  hintText: AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_EXPENSE_DATE),
                                  border: InputBorder.none,
                                ),
                                format: format,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      expenseDate = format.format(value);

                                    }
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
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFieldContainer(
                              child: TextField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                cursorColor: AppTheme.kPrimaryColor,
                                decoration: InputDecoration(
                                  hintText: AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_NOTES),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.note_add_outlined,
                                      color: AppTheme.kPrimaryColor,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    notes = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  sendExpenseValidation();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: buttonSendIsPressed
                                        ? AppTheme.nearlyWhite.withOpacity(0.1)
                                        : AppTheme.nearlyBlue,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: AppTheme.nearlyBlue
                                              .withOpacity(0.5),
                                          offset: const Offset(1.1, 1.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppTranslations.of(context)
                                          .text(Const.LOCALE_KEY_SEND_LEAVE),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        color: AppTheme.nearlyWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
