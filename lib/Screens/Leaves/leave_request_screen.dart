import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/Leaves/leaves_controller.dart';
import 'package:sven_hr/Screens/Vacations/picker_screen.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/components/single_selection_listview.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/employee_vacation_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class LeaveRequestScreen extends StatefulWidget {
  static String id = "LeaveRequestScreen";
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  LovValue typeValue;
  LeavesController _leavesController;
  List<LovValue> typesList;
  String fromDate;
  String toDate;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  String notes;
  bool showSpinner = false;
  var vacationTextController = new TextEditingController();
  var attachmentTextController = new TextEditingController();
  var fromDateController = new TextEditingController();
  var toDateController = new TextEditingController();
  List<String> attachmentsPaths = [];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    _leavesController = LeavesController();
    LoadleavesType();
    super.initState();
  }

  void LoadleavesType() async {
    typesList = List();

    await _leavesController.loadLeavesType().then((value) {
      setState(() {
        typesList.addAll(value);
        // locationValue = locationList[0];
      });
    });
  }

  void sendVacationValidation() async {
    if (typeValue != null && fromDate != null && toDate != null) {
      await sendLeaveRequest();
    }
  }

  void sendLeaveRequest() async {
    buttonSendIsPressed = true;
    showSpinner = true;

    await _leavesController
        .sendLeaveRequest(
            fromDate: fromDate,
            toDate: toDate,
            notes: notes,
            leaveId: typeValue.row_id,
            filePaths: attachmentsPaths)
        .then((value) {
      if (value == null) {
        ToastMessage.showErrorMsg(Const.REQUEST_FAILED);
      } else if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
        ToastMessage.showSuccessMsg(Const.REQUEST_SENT_SUCCESSFULLY);
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
    final dateTimeFormat = DateFormat(Const.DATE_TIME_FORMAT);

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
                                  tooltip: 'search',
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
                                      .text(Const.LOCALE_KEY_LEAVE_REQUEST),
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
                            flex: 1,
                            child: TextFieldContainer(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<LovValue>(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      hint: Text(AppTranslations.of(context)
                                          .text(Const.LOCALE_KEY_SELECT_TYPE)),
                                      isExpanded: true,
                                      style: TextStyle(
                                          color: AppTheme.kPrimaryColor),
                                      icon: Icon(
                                        Icons.menu_open,
                                        color: AppTheme.kPrimaryColor,
                                        size: 20,
                                      ),
                                      value: typeValue,
                                      validator: (value) => value == null
                                          ? AppTranslations.of(context)
                                              .text(Const.LOCALE_KEY_REQUIRED)
                                          : null,
                                      items: typesList
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
                                          typeValue = value;
                                        });
                                      },
                                      onTap: () {
                                        print('pressed');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFieldContainer(
                              child: DateTimeField(
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: AppTheme.kPrimaryColor,
                                  ),
                                  hintText: AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_FROM),
                                  border: InputBorder.none,
                                ),
                                controller: fromDateController,
                                validator: (value) => value == null
                                    ? AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_REQUIRED)
                                    : null,
                                textAlign: TextAlign.left,
                                style: AppTheme.subtitle,
                                format: dateTimeFormat,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      fromDate = value.toString();
                                      toDateController.text =
                                          dateTimeFormat.format(value);
                                      toDate = fromDate;
                                    } else {
                                      fromDate = "";
                                      toDate = "";
                                    }
                                  });
                                },
                                onShowPicker: (context, currentValue) async {
                                  final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                  if (date != null) {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    return DateTimeField.combine(date, time);
                                  } else {
                                    return currentValue;
                                  }
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFieldContainer(
                              child: DateTimeField(
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: AppTheme.kPrimaryColor,
                                  ),
                                  hintText: AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_TO),
                                  border: InputBorder.none,
                                ),
                                controller: toDateController,
                                validator: (value) => value == null
                                    ? AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_REQUIRED)
                                    : null,
                                textAlign: TextAlign.left,
                                style: AppTheme.subtitle,
                                format: dateTimeFormat,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      toDate = value.toString();
                                      toDateController.text =
                                          dateTimeFormat.format(value);
                                    } else
                                      toDate = "";
                                  });
                                },
                                onShowPicker: (context, currentValue) async {
                                  final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                  if (date != null) {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    return DateTimeField.combine(date, time);
                                  } else {
                                    return currentValue;
                                  }
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFieldContainer(
                              child: TextField(
                                controller: attachmentTextController,
                                readOnly: true,
                                cursorColor: AppTheme.kPrimaryColor,
                                decoration: InputDecoration(
                                  hintText: AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_SELECT_ATTACHMENT),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    hoverColor: AppTheme.kPrimaryColor,
                                    onPressed: () async {
                                      // Navigator.of(context).pushNamed<PickedFile>(PickerScreen.id).then((PickedFile result){
                                      //   setState(() {
                                      //     if(result!=null){
                                      //       attachmentTextController.text=result.path;
                                      //     }
                                      //   });
                                      // });
                                      // var result = await Navigator.pushNamed(
                                      //     context, PickerScreen.id);
                                      String _filePath =
                                          await Navigator.push<String>(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PickerScreen()));
                                      setState(() {
                                        if (_filePath != null) {
                                          attachmentTextController.text =
                                              AppTranslations.of(context).text(
                                                  Const.LOCALE_KEY_ADD_MORE);
                                          attachmentsPaths.add(_filePath);
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.attach_file,
                                      color: AppTheme.kPrimaryColor,
                                    ),
                                  ),
                                  prefixIcon: IconButton(
                                    hoverColor: AppTheme.kPrimaryColor,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AttachmentsListView(
                                              paths: attachmentsPaths,
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppTheme.kPrimaryColor,
                                    ),
                                  ),
                                ),
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
                                  sendVacationValidation();
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
