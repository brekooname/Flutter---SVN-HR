import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sven_hr/Screens/time_sheet/time_sheet_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/project_list_response.dart';
import 'package:sven_hr/models/response/time_sheet_details_list_response.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';

class NewTimeSheetDetailsScreen extends StatefulWidget {
  static String id = "NewTimeSheetDetailsScreen";
  String? timeSheetId;
  TimeSheetDetailsResponse? detailId;

  NewTimeSheetDetailsScreen({@required this.timeSheetId, this.detailId});

  @override
  _NewTimeSheetDetailsScreenState createState() =>
      _NewTimeSheetDetailsScreenState();
}

class _NewTimeSheetDetailsScreenState extends State<NewTimeSheetDetailsScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  ProjectListResponse? projectValue;
  TimeSheetController? _timeSheetController;
  List<ProjectListResponse>? projectListList;
  List<LovValue>? statusList=<LovValue>[];
  LovValue? statusValue;
  num? startTime;
  num? endTime;
  DateTime? startDate;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  String? description;
  bool showSpinner = false;
  var descriptionTextController = new TextEditingController();
  var startTimeController = new TextEditingController();
  var endTimeController = new TextEditingController();
  String? timeSheetId;
  TimeSheetDetailsResponse? detail;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    timeSheetId = this.widget.timeSheetId;
    detail = this.widget.detailId;
    setData();
    _timeSheetController = TimeSheetController();
    LoadProjects();
    LoadleavesType();
    setCurrentDetails();
    super.initState();
  }

  void setCurrentDetails() {
    if (detail != null) {
      if (detail!.start_time != null) {
        startTimeController.text = ApplicationController.formatToHours(detail!.start_time.toInt());
        startTime = detail!.start_time;
      } else {
        // Handle null start_time
        startTimeController.text = ""; // Default or error value
        startTime = 0; // Default or error value
      }

      if (detail!.end_time != null) {
        endTimeController.text = ApplicationController.formatToHours(detail!.end_time.toInt());
        endTime = detail!.end_time;
      } else {
        // Handle null end_time
        endTimeController.text = ""; // Default or error value
        endTime = 0; // Default or error value
      }

      description = detail!.description;
      if (description != null) {
        descriptionTextController.text = description!;
      } else {
        // Handle null description
        descriptionTextController.text = ""; // Default or error value
        description = ""; // Default or error value
      }
    } else {
      // Handle null detail
      startTimeController.text = ""; // Default or error value
      endTimeController.text = ""; // Default or error value
      descriptionTextController.text = ""; // Default or error value
      startTime = 0; // Default or error value
      endTime = 0; // Default or error value
      description = ""; // Default or error value
    }
  }


  void LoadProjects() async {
    // Make sure _timeSheetController and its projectList are not null
    if (_timeSheetController != null && _timeSheetController!.projectList != null) {
      projectListList = <ProjectListResponse>[];

      await _timeSheetController!.getProjectList().then((value) {
        setState(() {
          projectListList = _timeSheetController!.projectList;

          // Check if detail and projectListList are not null
          if (detail != null && projectListList != null) {
            for (ProjectListResponse? pro in projectListList!) {
              if (pro != null && pro.row_id == detail!.project_id) {
                projectValue = pro;
                break;
              }
            }
          }
        });
      });
      print('projectListList new timesheet details '+projectListList.toString());
    }
  }


  void LoadleavesType() async {
    // Ensure _timeSheetController is not null
    if (_timeSheetController != null) {
      await _timeSheetController!.loadProjectsType().then((value) {
        if (value != null) {
          setState(() {
            // Initialize statusList if null
            statusList ??= <LovValue>[];
            statusList!.addAll(value);

            // Ensure detail is not null before accessing its properties
            if (detail != null) {
              for (LovValue lov in statusList!) {
                if (lov.row_id == detail!.status) {
                  statusValue = lov;
                  break;
                }
              }
            }
          });
        }
      });
    }
  }


  void saveTimeSheetValidation() async {
    saveTimeSheetRequest();
    }

  void saveTimeSheetRequest() async {
    buttonSendIsPressed = true;
    showSpinner = true;

    String? detailId;
    if (detail != null) {
      detailId = detail!.row_id;
    } else {
      print('Detail is null');
      detailId=null;
     }

    String? projectId;
    if (projectValue != null) {
      projectId = projectValue!.row_id;
    } else {
      print('ProjectValue is null');
      return;
    }

    await _timeSheetController
        !.addNewTimeSheetDetails(
            startTime: startTime,
            endTime: endTime,
            status: statusValue!.row_id,
            projectId: projectValue!.row_id,
            description: description,
            rowId: detailId,
            timeSheetId: timeSheetId)
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

  Widget build(BuildContext context) {
    final timeFormat = DateFormat(Const.TIME_FORMAT);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Theme(
      data: ModernTheme.themeData,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFF1b4963),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            decoration: BoxDecoration(gradient: ModernTheme.backgroundGradient),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: bottom),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    SizedBox(height: 20), // Added space at the top
                    _buildTopBar(context),
                    SizedBox(height: 20), // Added space after the top bar
                    _buildDateTimeField(
                      controller: startTimeController,
                      hintText: Const.LOCALE_KEY_LEAVE_START_TIME,
                      timeFormat: timeFormat,
                      iconData: Icons.lock_clock,
                    ),
                    SizedBox(height: 15), // Added space between fields
                    _buildDateTimeField(
                      controller: endTimeController,
                      hintText: Const.LOCALE_KEY_LEAVE_END_TIME,
                      timeFormat: timeFormat,
                      iconData: Icons.lock_clock,
                    ),
                    SizedBox(height: 15), // Added space between fields
                    _buildProjectDropdown(),
                    SizedBox(height: 15), // Added space between fields
                    _buildStatusDropdown(),
                    SizedBox(height: 15), // Added space between fields
                    _buildNotesField(context),
                    SizedBox(height: 30), // Added more space before the submit button
                    _buildSubmitButton(context),
                    SizedBox(height: 30), // Added space at the bottom
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: ModernTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: 16),
        Text(
          AppTranslations.of(context)!.text(Const.LOCALE_KEY_ADD_NEW_TIME_SHEET_DETAILS),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: ModernTheme.textColor,
          ),
        ),
      ],
    );
  }
  Widget _buildProjectDropdown() {
    return TextFieldContainer(
      child: DropdownSearch<ProjectListResponse>(
        compareFn: (item1, item2) => item1?.row_id == item2?.row_id,
        items: projectListList!,
        onChanged: (ProjectListResponse? newValue) {
          setState(() {
            projectValue = newValue;
          });
        },
        selectedItem: projectValue,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select Project",
            hintText: "Project Name",
            hintStyle: TextStyle(color: ModernTheme.accentColor),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            border: InputBorder.none,
          ),
        ),
        dropdownButtonProps: DropdownButtonProps(
          icon: Icon(Icons.menu_open_sharp, color: ModernTheme.accentColor),
        ),
        dropdownBuilder: (context, selectedItem) {
          return Text(
            selectedItem?.name ?? "Select Project",
            style: TextStyle(color: ModernTheme.accentColor),
          );
        },
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          itemBuilder: (context, item, isSelected) {
            return ListTile(
              title: Text(
                item.name,
                style: TextStyle(color: ModernTheme.accentColor),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget _buildStatusDropdown() {
    return TextFieldContainer(
      child: DropdownButtonFormField<LovValue>(
        decoration: InputDecoration(border: InputBorder.none),
        hint: Text(AppTranslations.of(context)!.text(Const.LOCALE_KEY_STATUS)),
        isExpanded: true,
        style: TextStyle(color: ModernTheme.accentColor),
        icon: Icon(Icons.menu_open, color: ModernTheme.accentColor),
        value: statusValue,
        items: statusList!.map<DropdownMenuItem<LovValue>>((LovValue value) {
          return DropdownMenuItem<LovValue>(
            value: value,
            child: Text(value.display, style: TextStyle(color: ModernTheme.accentColor)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            statusValue = value;
          });
        },
      ),
    );
  }

  Widget _buildNotesField(BuildContext context) {
    return Container(
      height: 122,
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
            description = value;
          });
        },
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
            _formKey.currentState!.save();
            saveTimeSheetRequest(); // Use the existing logic for saving the timesheet
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


  Widget _buildDateTimeField({
    required TextEditingController controller,
    required String hintText,
    required DateFormat timeFormat,
    required IconData iconData,
  }) {
    return TextFieldContainer(
      child: DateTimeField(
        decoration: InputDecoration(
          suffixIcon: Icon(iconData, color: ModernTheme.accentColor),
          hintText: AppTranslations.of(context)!.text(hintText),
          border: InputBorder.none,
        ),
        controller: controller,
        validator: (value) => value == null ? AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUIRED) : null,
        format: timeFormat,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    );
  }

}
