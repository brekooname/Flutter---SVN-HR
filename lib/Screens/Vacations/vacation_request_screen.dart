import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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

class VacationRequestScreen extends StatefulWidget {
  static String id = "VacationRequestScreen";
  @override
  _VacationRequestScreenState createState() => _VacationRequestScreenState();
}

class _VacationRequestScreenState extends State<VacationRequestScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  LovValue locationValue;
  VacationTransactionController _vacationTransactionController;
  List<LovValue> locationList;
  String fromDate;
  String toDate;
  List<EmployeeVacationResponse> employeeVactionsList;
  EmployeeVacationResponse selectedVacation;
  bool _vacationTypeValidate = false;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  String notes;
  bool showSpinner = false;
  var vacationTextController = new TextEditingController();
  var attachmentTextController = new TextEditingController();
  var fromDateController = new TextEditingController();
  var toDateController = new TextEditingController();
  List<String> attachmentsPaths = List();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    _vacationTransactionController = VacationTransactionController();
    LoadVacationType();
    LoadEmployeeVacationsBalance();
    super.initState();
  }

  void LoadEmployeeVacationsBalance() async {
    employeeVactionsList = List();

    await _vacationTransactionController
        .loadEmployeeVacationsBalance()
        .then((value) {
      setState(() {
        if (value != null && value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
          employeeVactionsList =
              _vacationTransactionController.employeeVactions;
        }
      });
    });
  }

  void LoadVacationType() async {
    locationList = List();
    // LovValue defualtValue = LovValue();
    // defualtValue.display = 'Select Location';
    // locationList.add(defualtValue);

    await _vacationTransactionController.loadVacationLocation().then((value) {
      setState(() {
        locationList.addAll(value);
        // locationValue = locationList[0];
      });
    });
  }

  void sendVacationValidation() async {
    setState(() {
      vacationTextController.text.isEmpty
          ? _vacationTypeValidate = true
          : _vacationTypeValidate = false;
    });

    if (selectedVacation != null &&
        locationValue != null &&
        fromDate != null &&
        toDate != null) {
      if (selectedVacation.rec_attachment != null &&
          selectedVacation.rec_attachment.compareTo("Y") == 0) {
        if (attachmentsPaths != null && attachmentsPaths.length > 0) {
          await sendVacationRequest();
        } else {
          ToastMessage.showSuccessMsg(Const.LOCALE_KEY_ATTACHMENTS_REQUIRED);
        }
      } else {
        await sendVacationRequest();
      }
    }
  }

  void sendVacationRequest() async {
    buttonSendIsPressed = true;
    showSpinner = true;

    await _vacationTransactionController
        .sendVacationRequest(
            fromDate: fromDate,
            toDate: toDate,
            notes: notes,
            vacationId: selectedVacation.row_id,
            locationId: locationValue.row_id,
            filePaths: attachmentsPaths)
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

  Future _asyncConfirmDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (ctx) {
          return SingleSelectionListView(
            employeeVacations: employeeVactionsList,
          );
        });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat(Const.DATE_FORMAT);

    return Scaffold(
        backgroundColor: AppTheme.nearlyWhite,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
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
                                    .text(Const.LOCALE_KEY_VACATION_REQUEST),
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
                            child: TextFormField(
                              style: AppTheme.subtitle,
                              controller: vacationTextController,
                              readOnly: true,
                              cursorColor: AppTheme.kPrimaryColor,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(fontSize: 10),
                                hintText: AppTranslations.of(context)
                                    .text(Const.LOCALE_KEY_SELECT_TYPE),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    setState(() {});
                                    selectedVacation =
                                        await _asyncConfirmDialog(context);
                                    if (selectedVacation != null)
                                      vacationTextController.text =
                                          selectedVacation.vacation_type_name;
                                  },
                                  icon: Icon(
                                    Icons.select_all_outlined,
                                    color: AppTheme.kPrimaryColor,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_REQUIRED);
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFieldContainer(
                            child: DropdownButtonFormField<LovValue>(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                 ),
                              hint: Text(AppTranslations.of(context).text(
                                  Const.LOCALE_KEY_SELECT_LOCATION)),
                              isExpanded: true,
                              style: TextStyle(
                                  color: AppTheme.kPrimaryColor),
                              icon: Icon(
                                Icons.menu_open,
                                color: AppTheme.kPrimaryColor,
                                size: 25,
                              ),
                              value: locationValue,
                              validator: (value) => value == null
                                  ? AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_REQUIRED)
                                  : null,
                              items: locationList
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
                                  locationValue = value;
                                });
                              },
                              onTap: () {
                                print('pressed');
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFieldContainer(
                            child: DateTimeField(
                              controller: fromDateController,
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
                                    .text(Const.LOCALE_KEY_FROM),
                                border: InputBorder.none,
                              ),
                              format: format,
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    fromDate = format.format(value);
                                    toDateController.text = fromDate;
                                    toDate = fromDate;
                                  } else {
                                    fromDate = "";
                                    toDate = "";
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
                        Flexible(
                          flex: 1,
                          child: TextFieldContainer(
                            child: DateTimeField(
                              controller: toDateController,
                              validator: (value) => value == null
                                  ? AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_REQUIRED)
                                  : null,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: AppTheme.kPrimaryColor,
                                ),
                                hintText: AppTranslations.of(context)
                                    .text(Const.LOCALE_KEY_TO),
                                border: InputBorder.none,
                              ),
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
                          flex: 1,
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
                                        .text(Const.LOCALE_KEY_SEND_VACATION),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      letterSpacing: 0.0,
                                      color: AppTheme.nearlyWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
