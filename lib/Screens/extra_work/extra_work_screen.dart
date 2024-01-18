import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/Vacations/picker_screen.dart';
import 'package:sven_hr/Screens/extra_work/extra_work_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';

class ExtraWorkScreen extends StatefulWidget {
  static String id = "ExtraWorkScreen";
  @override
  _ExtraWorkScreenState createState() => _ExtraWorkScreenState();
}

class _ExtraWorkScreenState extends State<ExtraWorkScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  ExtraWorkController? _extraWorkController;
  List<LovValue>? dayTypeList;
  LovValue? dayTypeValue;
  List<LovValue>? unitList;
  LovValue? unitValue;
  num? unitQuantity;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  String? notes;
  bool showSpinner = false;
  List<String> attachmentsPaths = [];
  String? date2;
  var attachmentTextController = new TextEditingController();
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    _extraWorkController = ExtraWorkController();
    loadUnit();
    loadDayType();
    super.initState();
  }

  void loadDayType() async {
    dayTypeList = [];

    await _extraWorkController!.loadDayType().then((value) {
      setState(() {
        // Check if value is not null and add only non-null items
        if (value != null) {
          dayTypeList!.addAll(value.where((item) => item != null).cast<LovValue>());
        }
      });
    });
  }


  void loadUnit() async {
    unitList = [];

    await _extraWorkController!.loadUnit().then((value) {
      setState(() {
        unitList!.addAll(value!);
      });
    });
  }

  void sendExtraWorkValidation() async {
    sendExtraWorkRequest();
  }

  void sendExtraWorkRequest() async {
    buttonSendIsPressed = true;
    showSpinner = true;

    await _extraWorkController
    !.sendExtraWorkRequest(
      dayType: dayTypeValue!.row_id,
      unit: unitValue!.row_id,
      unitQuantity: unitQuantity!,
      notes: notes!,
      filePaths: attachmentsPaths,
      extra_work_date: '2022-12-25',
    )
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat(Const.DATE_FORMAT);

    return Theme(
      data: ModernTheme.themeData,
      child: Scaffold(
        backgroundColor: Color(0xFF1b4963),
        body: Container(
          decoration: BoxDecoration(gradient: ModernTheme.backgroundGradient),
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: <Widget>[
                      _buildTopBar(context),
                      _buildDropdownField(
                        context: context,
                        currentValue: dayTypeValue,
                        items: dayTypeList,
                        hint: Const.LOCALE_KEY_EXTRA_WORK_DAY_TYPE,
                        onChanged: (newValue) {
                          setState(() {
                            dayTypeValue = newValue;
                          });                        },
                      ),

                      _buildDropdownField(
                        context: context,
                        currentValue: unitValue,
                        items: unitList,
                        hint: Const.LOCALE_KEY_EXTRA_WORK_UNIT,
                        onChanged: (newValue) {
                          setState(() {
                            unitValue = newValue;
                          });
                        },
                      ),

                      _buildUnitQuantityField(context),
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
            sendExtraWorkValidation();
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

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back, color: ModernTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: 16),
        Text(
          AppTranslations.of(context)!.text(Const.LOCALE_KEY_EXTRA_WORK_REQUEST),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: ModernTheme.textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildUnitQuantityField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ModernTheme.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(style: TextStyle(color: ModernTheme.textColor),
        keyboardType: TextInputType.number,
        cursorColor: ModernTheme.accentColor,
        decoration: InputDecoration(

          hintText: AppTranslations.of(context)!.text(Const.LOCALE_KEY_EXTRA_WORK_UNIT_QUANTITY),
          border: InputBorder.none,
          // Add other decoration properties if necessary
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUIRED);
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            unitQuantity = num.tryParse(value);
          });
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required LovValue? currentValue,
    required List<LovValue>? items,
    required String hint,
    required ValueChanged<LovValue?> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: ModernTheme.gradientEnd.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<LovValue>(
        decoration: InputDecoration(border: OutlineInputBorder(  // This adds a border around the TextField
          borderSide: BorderSide(
            color: ModernTheme.gradientEnd,    // You can change the border color here
            width: 1.0,            // You can change the border width here
          ),
        ),
        ),
        hint: Text(AppTranslations.of(context)!.text(hint)),
        isExpanded: true,
        style: TextStyle(color: Colors.white),
        icon: Icon(Icons.arrow_drop_down, color: ModernTheme.accentColor),
        value: currentValue,
        validator: (value) => value == null ? AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUIRED) : null,
        dropdownColor: ModernTheme.gradientStart, // Set the dropdown background color
        items: items?.map((value) {
          return DropdownMenuItem<LovValue>(
            value: value,
            child: Text(
              value.display,
              style: TextStyle(color: Colors.white), // Ensuring text is white for visibility
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

}
