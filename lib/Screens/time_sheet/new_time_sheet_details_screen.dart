import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sven_hr/Screens/Leaves/leaves_controller.dart';
import 'package:sven_hr/Screens/Vacations/picker_screen.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_controller.dart';
import 'package:sven_hr/Screens/time_sheet/time_sheet_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/components/single_selection_listview.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/localization/application.dart';
import 'package:sven_hr/models/response/employee_vacation_response.dart';
import 'package:sven_hr/models/response/project_list_response.dart';
import 'package:sven_hr/models/response/time_sheet_details_list_response.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class NewTimeSheetDetailsScreen extends StatefulWidget {
  static String id = "NewTimeSheetDetailsScreen";
  String timeSheetId;
  TimeSheetDetailsResponse detailId;

  NewTimeSheetDetailsScreen({@required this.timeSheetId, this.detailId});

  @override
  _NewTimeSheetDetailsScreenState createState() =>
      _NewTimeSheetDetailsScreenState();
}

class _NewTimeSheetDetailsScreenState extends State<NewTimeSheetDetailsScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  ProjectListResponse projectValue;
  TimeSheetController _timeSheetController;
  List<ProjectListResponse> projectListList;
  List<LovValue> statusList;
  LovValue statusValue;
  num startTime;
  num endTime;
  DateTime startDate;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  String description;
  bool showSpinner = false;
  var descriptionTextController = new TextEditingController();
  var startTimeController = new TextEditingController();
  var endTimeController = new TextEditingController();
  String timeSheetId;
  TimeSheetDetailsResponse detail;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
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
      startTimeController.text =
          ApplicationController.formatToHours(detail.start_time);
      endTimeController.text =
          ApplicationController.formatToHours(detail.end_time);
      startTime = detail.start_time;
      endTime = detail.end_time;

      description = detail.description;
      descriptionTextController.text = description;
    }
  }

  void LoadProjects() async {
    projectListList = List();

    await _timeSheetController.getProjectList().then((value) {
      setState(() {
        projectListList = _timeSheetController.projectList;
        if (detail != null) {
          for (ProjectListResponse pro in projectListList) {
            if (pro.row_id.compareTo(detail.project_id) == 0) {
              projectValue = pro;
              break;
            }
          }
        }
      });
    });
  }

  void LoadleavesType() async {
    statusList = List();

    await _timeSheetController.loadProjectsType().then((value) {
      setState(() {
        statusList.addAll(value);
        if (detail != null) {
          for (LovValue lov in statusList) {
            if (lov.row_id.compareTo(detail.status) == 0) {
              statusValue = lov;
              break;
            }
          }
        }
        ;
      });
    });
  }

  void saveTimeSheetValidation() async {
    if (statusValue != null &&
        projectValue != null &&
        startTime != null &&
        endTime != null) {
      await saveTimeSheetRequest();
    }
  }

  void saveTimeSheetRequest() async {
    buttonSendIsPressed = true;
    showSpinner = true;

    String detailId = null;
    if (detail != null) {
      detailId = detail.row_id;
    }

    await _timeSheetController
        .addNewTimeSheetDetails(
            startTime: startTime,
            endTime: endTime,
            status: statusValue.row_id,
            projectId: projectValue.row_id,
            description: description,
            rowId: detailId,
            timeSheetId: timeSheetId)
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
    final timeFormat = DateFormat(Const.TIME_FORMAT);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
        resizeToAvoidBottomInset: true,
//        resizeToAvoidBottomPadding: false,
        backgroundColor: AppTheme.nearlyWhite,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(

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
                              AppTranslations.of(context).text(
                                  Const.LOCALE_KEY_ADD_NEW_TIME_SHEET_DETAILS),
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
                          child: DateTimeField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.lock_clock,
                                color: AppTheme.kPrimaryColor,
                              ),
                              hintText: AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_LEAVE_START_TIME),
                              border: InputBorder.none,
                            ),
                            controller: startTimeController,
                            validator: (value) =>
                               startTime == null
                                    ? AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_REQUIRED)
                                    : null,
                            textAlign: TextAlign.left,
                            style: AppTheme.subtitle,
                            format: timeFormat,
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  startTime = ApplicationController
                                      .formatTimetoNum(value.hour,
                                          value.minute, value.minute);
                                  startTimeController.text =
                                      timeFormat.format(value);
                                }
                              });
                            },
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    currentValue ?? DateTime.now()),
                              );
                              return DateTimeField.convert(time);
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
                                Icons.lock_clock,
                                color: AppTheme.kPrimaryColor,
                              ),
                              hintText: AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_LEAVE_END_TIME),
                              border: InputBorder.none,
                            ),
                            controller: endTimeController,
                            validator: (value) =>
                            endTime == null
                                    ? AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_REQUIRED)
                                    : null,
                            textAlign: TextAlign.left,
                            style: AppTheme.subtitle,
                            format: timeFormat,
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  endTime = ApplicationController
                                      .formatTimetoNum(value.hour,
                                          value.minute, value.second);
                                  endTimeController.text =
                                      timeFormat.format(value);
                                }
                              });
                            },
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    currentValue ?? DateTime.now()),
                              );
                              return DateTimeField.convert(time);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 0,
                        child: TextFieldContainer(
                          child: SearchableDropdown.single(
                            underline: Padding(
                            padding: EdgeInsets.all(5),
                          ),
                            value: projectValue,
                            icon: Icon(
                              Icons.menu_open_sharp,
                              color: AppTheme.kPrimaryColor,

                            ),
                            clearIcon: Icon(
                              Icons.close_sharp,
                              color: AppTheme.kPrimaryColor,
                              size: 20,
                            ),
                            hint: Text(AppTranslations.of(context).text(
                                Const.LOCALE_KEY_TIME_PROJECT_NAME)),
                            isExpanded: true,
                            style:
                                TextStyle(color: AppTheme.kPrimaryColor),
                            items: projectListList.map<
                                    DropdownMenuItem<
                                        ProjectListResponse>>(
                                (ProjectListResponse value) {
                              return DropdownMenuItem<
                                  ProjectListResponse>(
                                value: value,
                                child: Text(
                                  value.name,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                projectValue = value;
                              });
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
                            hint: Text(AppTranslations.of(context)
                                .text(Const.LOCALE_KEY_STATUS)),
                            isExpanded: true,
                            style:
                                TextStyle(color: AppTheme.kPrimaryColor),
                            icon: Icon(
                              Icons.menu_open,
                              color: AppTheme.kPrimaryColor,
                              size: 20,
                            ),
                            value: statusValue,
                            validator: (value) => statusValue == null
                                ? AppTranslations.of(context)
                                    .text(Const.LOCALE_KEY_REQUIRED)
                                : null,
                            items: statusList
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
                                statusValue = value;
                              });
                            },
                            onTap: () {
                              print('pressed');
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFieldContainer(
                          child: TextField(
                            style: TextStyle(color: AppTheme.kPrimaryColor),
                            controller: descriptionTextController,
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
                                description = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              saveTimeSheetRequest();
                            }
                          },
                          child: Padding(
                            padding:  const EdgeInsets.symmetric(
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
                                      .text(Const.LOCALE_KEY_SAVE),
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
        ));
  }
}
