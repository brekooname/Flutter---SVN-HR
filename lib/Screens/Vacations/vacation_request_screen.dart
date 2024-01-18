import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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

import '../app_settings/server_connection_screen.dart';

class VacationRequestScreen extends StatefulWidget {
  static String id = "VacationRequestScreen";
  @override
  _VacationRequestScreenState createState() => _VacationRequestScreenState();
}

class _VacationRequestScreenState extends State<VacationRequestScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  LovValue? locationValue;
  VacationTransactionController? _vacationTransactionController;
  List<LovValue> locationList = []; // Instead of List<LovValue>? locationList;
  List<EmployeeVacationResponse> employeeVactionsList = []; // Instead of List<EmployeeVacationResponse>? employeeVactionsList;
  String? fromDate;
  String? toDate;
   EmployeeVacationResponse? selectedVacation=EmployeeVacationResponse();
  bool _vacationTypeValidate = false;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  String? notes;
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
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    _vacationTransactionController = VacationTransactionController();
    LoadVacationType();
    LoadEmployeeVacationsBalance();
    super.initState();
  }

  void LoadEmployeeVacationsBalance() async {
    employeeVactionsList = <EmployeeVacationResponse>[]; // Specify the type explicitly

    await _vacationTransactionController!
        .loadEmployeeVacationsBalance()
        .then((value) {
      setState(() {
        if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
          employeeVactionsList =
              _vacationTransactionController!.employeeVactions;
        }
      });
    });
  }

  void LoadVacationType() async {
    List<LovValue>? locationList=<LovValue>[];
    LovValue defualtValue = LovValue();
    defualtValue.display = 'Select Location';
    locationList.add(defualtValue);

    await _vacationTransactionController!.loadVacationLocation().then((value) {
      setState(() {
        locationList!.addAll(value!);
       locationValue = locationList[0];
      });
      print('locationList load lov '+locationList.first.display.toString());
    });
  }

  void sendVacationValidation() async {
    setState(() {
      vacationTextController.text.isEmpty
          ? _vacationTypeValidate = true
          : _vacationTypeValidate = false;
    });

    if (selectedVacation!.rec_attachment.compareTo("Y") == 0) {
      if (attachmentsPaths.length > 0) {
        sendVacationRequest();
      } else {
        ToastMessage.showSuccessMsg(Const.LOCALE_KEY_ATTACHMENTS_REQUIRED);
      }
    } else {
      sendVacationRequest();
    }
    }

  void sendVacationRequest() async {
    buttonSendIsPressed = true;
    showSpinner = true;

    await _vacationTransactionController
        !.sendVacationRequest(
            fromDate: fromDate,
            toDate: toDate,
            notes: notes,
            vacationId: selectedVacation!.row_id,
            locationId: locationValue!.row_id,
            filePaths: attachmentsPaths)
        .then((value) {
      if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
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
    animationController!.forward();
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
            employeeVacations: employeeVactionsList!,
          );
        });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat(Const.DATE_FORMAT);

    return Theme(
      data: ModernTheme.themeData,
      child: Scaffold(
        backgroundColor: Color(0xFF1b4963),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            decoration: BoxDecoration(gradient: ModernTheme.backgroundGradient),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTopBar(context),
                      _buildVacationTypeField(),
                      _buildLocationDropdown(),
                      _buildDateTimeField(
                        controller: fromDateController,
                        hintText: Const.LOCALE_KEY_FROM,
                        format: format,
                      ),
                      _buildDateTimeField(
                        controller: toDateController,
                        hintText: Const.LOCALE_KEY_TO,
                        format: format,
                      ),
                      _buildAttachmentField(context),
                      _buildNotesField(context),
                      _buildSubmitButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Perform the action after validation, e.g., sendExtraWorkValidation()
            sendVacationValidation();
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              AppTranslations.of(context)!.text(Const.LOCALE_KEY_SEND_Request),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: ModernTheme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotesField(BuildContext context) {
    return Container(height: 222,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ModernTheme.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        maxLines: null,
        keyboardType: TextInputType.multiline,
        cursorColor: ModernTheme.accentColor,
        decoration: InputDecoration(
          hintText: AppTranslations.of(context)!.text(Const.LOCALE_KEY_NOTES),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.note_add_outlined, color: ModernTheme.accentColor),
        ),
        onChanged: (value) {
          setState(() {
            notes = value;
          });
        },
      ),
    );
  }
  Widget _buildAttachmentField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ModernTheme.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: attachmentTextController,
        readOnly: true,
        cursorColor: ModernTheme.accentColor,
        decoration: InputDecoration(
          hintText: AppTranslations.of(context)!.text(Const.LOCALE_KEY_SELECT_ATTACHMENT),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(Icons.attach_file, color: ModernTheme.accentColor),
            onPressed: () async {
              String? _filePath =
              await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PickerScreen()));
              setState(() {
                attachmentTextController.text =
                    AppTranslations.of(context)!.text(
                      Const.LOCALE_KEY_ADD_MORE,);
                attachmentsPaths.add(_filePath!);
              });
            },
          ),
          prefixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye_outlined, color: ModernTheme.accentColor),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AttachmentsListView(
                      paths: attachmentsPaths,
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
  Widget _buildVacationTypeField() {
    return TextFieldContainer(
      child: TextFormField(
        style: TextStyle(color: ModernTheme.accentColor),
        controller: vacationTextController,
        readOnly: true,
        cursorColor: ModernTheme.accentColor,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 10),
          hintText: AppTranslations.of(context)!.text(Const.LOCALE_KEY_SELECT_TYPE),
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () async {
              selectedVacation = await _asyncConfirmDialog(context);
              vacationTextController.text = selectedVacation!.vacation_type_name;
            },
            icon: Icon(Icons.select_all_outlined, color: ModernTheme.accentColor),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUIRED);
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLocationDropdown() {
    return TextFieldContainer(
      child: DropdownButtonFormField<LovValue>(
        decoration: InputDecoration(border: InputBorder.none),
        hint: Text(AppTranslations.of(context)!.text(Const.LOCALE_KEY_SELECT_LOCATION)),
        isExpanded: true,
        style: TextStyle(color: ModernTheme.textColor),
        icon: Icon(Icons.menu_open, color: ModernTheme.accentColor),
        value: locationValue,
        validator: (value) => value == null ? AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUIRED) : null,
        items: locationList!.map<DropdownMenuItem<LovValue>>((LovValue value) {
          return DropdownMenuItem<LovValue>(
            value: value,
            child: Text(value.display.toString())
          );
        }).toList(),
        onChanged: (value) {
          locationValue = value;
        },
      ),
    );
  }

  Widget _buildDateTimeField({
    required TextEditingController controller,
    required String hintText,
    required DateFormat format,
  }) {
    return TextFieldContainer(
      child: DateTimeField(
        controller: controller,
        validator: (value) => value == null ? AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUIRED) : null,
        style: TextStyle(color: ModernTheme.accentColor),
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.calendar_today, color: ModernTheme.accentColor),
          hintText: AppTranslations.of(context)!.text(hintText),
          border: InputBorder.none,
        ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    );
  }
  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back, color: ModernTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: 16),
        Text(
          AppTranslations.of(context)!.text(Const.LOCALE_KEY_VACATION_REQUEST),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: ModernTheme.textColor,
          ),
        ),
      ],
    );
  }



}
