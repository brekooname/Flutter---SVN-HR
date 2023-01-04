import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_screen.dart';
import 'package:sven_hr/Screens/approval_inbox/approval_inbox_controller.dart';
import 'package:sven_hr/Screens/custom_drawer/menue_top_bar.dart';
import 'package:sven_hr/Screens/custom_drawer/notification_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/approval_inbox_attachments_response.dart';
import 'package:sven_hr/models/response/approval_inbox_list_response.dart';
import 'package:sven_hr/models/response/approval_object_response.dart';
import 'package:sven_hr/models/response/notification_list_response.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class RequestDetailsScreen extends StatefulWidget {
  static String id = "RequestDetails";
  final ApprovalInboxListResponse approvalInboxItenm;

  RequestDetailsScreen({this.approvalInboxItenm}) {
    print(approvalInboxItenm);
  }

  @override
  _RequestDetailsScreenState createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  ApprovalObjectResponse _requestDetails;
  ApprovalInboxController _approvalInboxController;
  List<ApprovalInboxAttachmentsResponse> attachmentsList;

  bool showSpinner = false;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  num approvedAmount;
  @override
  void initState() {
    _requestDetails = ApprovalObjectResponse();
    _approvalInboxController = ApprovalInboxController();
    getApprovalInboxObject();
    getApprovalInboxAttachments();
    super.initState();
  }

  void getApprovalInboxObject() async {
    await _approvalInboxController
        .getApprovalInboxObject(this.widget.approvalInboxItenm.row_id)
        .then((value) {
      setState(() {
        print(value);
        _requestDetails = _approvalInboxController.requestDetails;
      });
    });
  }

  void getApprovalInboxAttachments() async {
    await _approvalInboxController
        .getApprovalInboxAttachments(this.widget.approvalInboxItenm.row_id)
        .then((value) {
      attachmentsList = _approvalInboxController.attachmentsList;
      setState(() {
        print(value);
      });
    });
  }

  void sendRequest(String action) async {
    buttonSendIsPressed = true;

    if (action.compareTo(Const.APPROVAL_INBOX_ACCTION_ACCEPT) == 0 &&
        _requestDetails.approvalInboxType != null &&
        _requestDetails.approvalInboxType
                .compareTo(Const.APPROVAL_INBOX_EXPENSE_TYPE) ==
            0 &&
        _requestDetails.expenseApprovedAmount == null) {
      ToastMessage.showWarningMsg(AppTranslations.of(context).text(
          Const.LOCALE_KEY_EXPENSE_APPROVED_AMOUNT +
              " " +
              Const.LOCALE_KEY_REQUIRED));
      return;
    }
    showSpinner = true;
    await _approvalInboxController
        .approvalInboxAction(
        requestInput: _requestDetails,
        action: action,)
        .then((value) {
      if (value == null) {
        ToastMessage.showErrorMsg(Const.REQUEST_FAILED);
      } else if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
        if (action.compareTo(Const.APPROVAL_INBOX_ACCTION_ACCEPT) == 0) {
          ToastMessage.showSuccessMsg(
              AppTranslations.of(context).text(Const.LOCALE_KEY_APRROVED_MSG));
        } else {
          ToastMessage.showSuccessMsg(
              AppTranslations.of(context).text(Const.LOCALE_KEY_REJECTED_MSG));
        }
        Navigator.pop(context, value);
      } else {
        ToastMessage.showErrorMsg(value);
      }
      buttonSendIsPressed = false;
      showSpinner = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        child: Scaffold(
            body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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
                                .text(Const.LOCALE_KEY_REQUEST_DETAILS),
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
                    Expanded(
                      flex: 3,
                      child: Card(
                        color: AppTheme.kPrimaryLightColor,
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  AppTheme.kPrimaryLightColor.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                this.widget.approvalInboxItenm.title_name !=
                                        null
                                    ? this.widget.approvalInboxItenm.title_name
                                    : "-",
                                style: TextStyle(
                                    color: AppTheme.kPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ListTile(
                                      title: Text(AppTranslations.of(context)
                                          .text(
                                              Const.LOCALE_KEY_EMPLOYEE_NAME)),
                                      subtitle: Text(
                                          _requestDetails.employeeName != null
                                              ? _requestDetails.employeeName
                                              : "-"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ListTile(
                                      title: Text(AppTranslations.of(context)
                                          .text(Const.LOCALE_KEY_REQUEST_DATE)),
                                      subtitle: Text(this
                                                  .widget
                                                  .approvalInboxItenm
                                                  .approval_request_date !=
                                              null
                                          ? this
                                              .widget
                                              .approvalInboxItenm
                                              .approval_request_date
                                          : "-"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ////-----------------------
                    if (_requestDetails.approvalInboxType != null &&
                        _requestDetails.approvalInboxType.compareTo(
                                Const.APPROVAL_INBOX_VACATION_TYPE) ==
                            0)
                      Expanded(
                        flex: 7,
                        child: Card(
                          color: AppTheme.kPrimaryLightColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.kPrimaryLightColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_FROM)),
                                        subtitle: Text(
                                            _requestDetails.startDate != null
                                                ? _requestDetails.startDate
                                                : "Date .."),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_TO)),
                                        subtitle: Text(
                                            _requestDetails.endDate != null
                                                ? _requestDetails.endDate
                                                : "Date .."),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_VACATION)),
                                        subtitle: Text(
                                            _requestDetails.vacationName != null
                                                ? _requestDetails.vacationName
                                                : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_LOCATION)),
                                        subtitle: Text(_requestDetails
                                                    .vacationLocation !=
                                                null
                                            ? _requestDetails.vacationLocation
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(
                                                Const.LOCALE_KEY_UNPAID_DAYS)),
                                        subtitle: Text(_requestDetails
                                                    .vacationUnPaidDays !=
                                                null
                                            ? _requestDetails.vacationUnPaidDays
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_PAID_DAYS)),
                                        subtitle: Text(_requestDetails
                                                    .vacationPaidDays !=
                                                null
                                            ? _requestDetails.vacationPaidDays
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(
                                                Const.LOCALE_KEY_NEW_BALANCE)),
                                        subtitle: Text(_requestDetails
                                                    .vacationNewBalance !=
                                                null
                                            ? _requestDetails.vacationNewBalance
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_PREVIOUS_BALANCE)),
                                        subtitle: Text(_requestDetails
                                                    .vacationPreviousBalance !=
                                                null
                                            ? _requestDetails
                                                .vacationPreviousBalance
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                            .LOCALE_KEY_VIEW_ATTACHMENT)),
                                        leading:  IconButton(
                                          hoverColor: AppTheme.kPrimaryColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ApprovalInboxAttachmentsListView(
                                                    attachmentsList: attachmentsList,
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

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (_requestDetails.approvalInboxType != null &&
                        _requestDetails.approvalInboxType
                                .compareTo(Const.APPROVAL_INBOX_LEAVE_TYPE) ==
                            0)
                      Expanded(
                        flex: 7,
                        child: Card(
                          color: AppTheme.kPrimaryLightColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.kPrimaryLightColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_FROM)),
                                        subtitle: Text(
                                            _requestDetails.startDate != null
                                                ? _requestDetails.startDate
                                                : "Date .."),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_TO)),
                                        subtitle: Text(
                                            _requestDetails.endDate != null
                                                ? _requestDetails.endDate
                                                : "Date .."),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_LEAVES)),
                                        subtitle: Text(
                                            _requestDetails.leaveId != null
                                                ? _requestDetails.leaveId
                                                : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_STATUS)),
                                        subtitle: Text(_requestDetails
                                                    .leaveRequestStatus !=
                                                null
                                            ? _requestDetails.leaveRequestStatus
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_LEAVE_START_TIME)),
                                        subtitle: Text(
                                            _requestDetails.leaveStartTime !=
                                                    null
                                                ? ApplicationController
                                                        .formatToHours(
                                                            _requestDetails
                                                                .leaveStartTime)
                                                    .toString()
                                                : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_LEAVE_END_TIME)),
                                        subtitle: Text(
                                            _requestDetails.leaveEndTime != null
                                                ? ApplicationController
                                                        .formatToHours(
                                                            _requestDetails
                                                                .leaveEndTime)
                                                    .toString()
                                                : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                            .LOCALE_KEY_VIEW_ATTACHMENT)),
                                        leading:  IconButton(
                                          hoverColor: AppTheme.kPrimaryColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ApprovalInboxAttachmentsListView(
                                                    attachmentsList: attachmentsList,
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

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                    if (_requestDetails.approvalInboxType != null &&
                        _requestDetails.approvalInboxType
                                .compareTo(Const.APPROVAL_INBOX_LOAN_TYPE) ==
                            0)
                      Expanded(
                        flex: 7,
                        child: Card(
                          color: AppTheme.kPrimaryLightColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.kPrimaryLightColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(
                                                Const.LOCALE_KEY_LOAN_AMOUNT)),
                                        subtitle: Text(
                                            _requestDetails.loanAmount != null
                                                ? _requestDetails.loanAmount
                                                    .toString()
                                                : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_LOAN_CURRENCY)),
                                        subtitle: Text(
                                            _requestDetails.loanCurrancy != null
                                                ? _requestDetails.loanCurrancy
                                                : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_LOAN_PAYMENT_METHOD)),
                                        subtitle: Text(_requestDetails
                                                    .loanPaymentMethod !=
                                                null
                                            ? _requestDetails.loanPaymentMethod
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_LOAN_PAYMENT_DUEDATE)),
                                        subtitle: Text(_requestDetails
                                                    .loanPaymentDueDate !=
                                                null
                                            ? _requestDetails.loanPaymentDueDate
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const.LOCALE_KEY_LOAN_TYPES)),
                                        subtitle: Text(
                                            _requestDetails.loanTypes != null
                                                ? _requestDetails.loanTypes
                                                    .toString()
                                                : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_LOAN_APPROVED_AMOUNT)),
                                        subtitle: Text(_requestDetails
                                                    .loanApprovedAmount !=
                                                null
                                            ? _requestDetails.loanApprovedAmount
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                            .LOCALE_KEY_VIEW_ATTACHMENT)),
                                        leading:  IconButton(
                                          hoverColor: AppTheme.kPrimaryColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ApprovalInboxAttachmentsListView(
                                                    attachmentsList: attachmentsList,
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

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (_requestDetails.approvalInboxType != null &&
                        _requestDetails.approvalInboxType.compareTo(
                                Const.APPROVAL_INBOX_EXTRA_WORK_TYPE) ==
                            0)
                      Expanded(
                        flex: 7,
                        child: Card(
                          color: AppTheme.kPrimaryLightColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.kPrimaryLightColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EXTRA_WORK_UNIT)),
                                        subtitle: Text(
                                            _requestDetails.extraWorkUnit !=
                                                    null
                                                ? _requestDetails.extraWorkUnit
                                                : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EXTRA_WORK_UNIT_QUANTITY)),
                                        subtitle: Text(_requestDetails
                                                    .extraWorkUnitQuantity !=
                                                null
                                            ? _requestDetails
                                                .extraWorkUnitQuantity
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EXTRA_WORK_DAY_TYPE)),
                                        subtitle: Text(_requestDetails
                                                    .extraWorkDayType !=
                                                null
                                            ? _requestDetails.extraWorkDayType
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EXTRA_WORK_REASON)),
                                        subtitle: Text(_requestDetails
                                                    .extraWorkReason !=
                                                null
                                            ? _requestDetails.extraWorkReason
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EXTRA_WORK_PAYROLL_CYCLE)),
                                        subtitle: Text(_requestDetails
                                                    .extraWorkPayrollCycleId !=
                                                null
                                            ? _requestDetails
                                                .extraWorkPayrollCycleDisplay
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EXTRA_WORK_REQUEST_DATE)),
                                        subtitle: Text(_requestDetails
                                                    .extraWorkRequestDate !=
                                                null
                                            ? _requestDetails
                                                .extraWorkRequestDate
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                            .LOCALE_KEY_VIEW_ATTACHMENT)),
                                        leading:  IconButton(
                                          hoverColor: AppTheme.kPrimaryColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ApprovalInboxAttachmentsListView(
                                                    attachmentsList: attachmentsList,
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

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (_requestDetails.approvalInboxType != null &&
                        _requestDetails.approvalInboxType
                                .compareTo(Const.APPROVAL_INBOX_EXPENSE_TYPE) ==
                            0)
                      Expanded(
                        flex: 7,
                        child: Card(
                          color: AppTheme.kPrimaryLightColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.kPrimaryLightColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EXPENSE_AMOUNT)),
                                        subtitle: Text(
                                            _requestDetails.expenseAmount !=
                                                    null
                                                ? _requestDetails.expenseAmount
                                                    .toString()
                                                : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EXPENSE_CURRANCY)),
                                        subtitle: Text(_requestDetails
                                                    .expenseCurrancy !=
                                                null
                                            ? _requestDetails.expenseCurrancy
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(
                                                Const.LOCALE_KEY_EXPENSE_DATE)),
                                        subtitle: Text(
                                            _requestDetails.expenseDate != null
                                                ? _requestDetails.expenseDate
                                                    .toString()
                                                : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EXPENSE_REQUEST_DATE)),
                                        subtitle: Text(_requestDetails
                                                    .expenseRequestDate !=
                                                null
                                            ? _requestDetails.expenseRequestDate
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFieldContainer(
                                        child: TextFormField(
                                          validator: (value) =>
                                              approvedAmount == null
                                                  ? AppTranslations.of(context)
                                                      .text(Const
                                                          .LOCALE_KEY_REQUIRED)
                                                  : null,
                                          keyboardType: TextInputType.number,
                                          cursorColor: AppTheme.kPrimaryColor,
                                          decoration: InputDecoration(
                                            hintText: AppTranslations.of(
                                                    context)
                                                .text(Const
                                                    .LOCALE_KEY_EXPENSE_APPROVED_AMOUNT),
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
                                              _requestDetails
                                                      .expenseApprovedAmount =
                                                  num.tryParse(value);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                            .LOCALE_KEY_VIEW_ATTACHMENT)),
                                        leading:  IconButton(
                                          hoverColor: AppTheme.kPrimaryColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ApprovalInboxAttachmentsListView(
                                                    attachmentsList: attachmentsList,
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

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (_requestDetails.approvalInboxType != null &&
                        _requestDetails.approvalInboxType.compareTo(
                                Const.APPROVAL_INBOX_DOCUEMNT_TYPE) ==
                            0)
                      Expanded(
                        flex: 7,
                        child: Card(
                          color: AppTheme.kPrimaryLightColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.kPrimaryLightColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_DOCUMENT_TYPE)),
                                        subtitle: Text(_requestDetails
                                                    .documentDocumentType !=
                                                null
                                            ? _requestDetails
                                                .documentDocumentType
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_DOCUMENT_REQUEST_DATE)),
                                        subtitle: Text(_requestDetails
                                                    .documentRequestdate !=
                                                null
                                            ? _requestDetails
                                                .documentRequestdate
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                            .LOCALE_KEY_VIEW_ATTACHMENT)),
                                        leading:  IconButton(
                                          hoverColor: AppTheme.kPrimaryColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ApprovalInboxAttachmentsListView(
                                                    attachmentsList: attachmentsList,
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

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (_requestDetails.approvalInboxType != null &&
                        _requestDetails.approvalInboxType
                                .compareTo(Const.APPROVAL_INBOX_BENEFIT_TYPE) ==
                            0)
                      Expanded(
                        flex: 7,
                        child: Card(
                          color: AppTheme.kPrimaryLightColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.kPrimaryLightColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EMP_BENEFIT_REQUEST_AMT)),
                                        subtitle: Text(_requestDetails
                                                    .empBenefitRequestAmt !=
                                                null
                                            ? _requestDetails
                                                .empBenefitRequestAmt
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EMP_BENEFIT_UNIT_PRICE)),
                                        subtitle: Text(_requestDetails
                                                    .empBenefitUnitPrice !=
                                                null
                                            ? _requestDetails
                                                .empBenefitUnitPrice
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EMP_BENEFIT_REQUEST_DATE)),
                                        subtitle: Text(_requestDetails
                                                    .empBenefitRequestDate !=
                                                null
                                            ? _requestDetails
                                                .empBenefitRequestDate
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_EMP_BENEFIT_TRANS_STATUS)),
                                        subtitle: Text(_requestDetails
                                                    .empBenefitTransStatus !=
                                                null
                                            ? _requestDetails
                                                .empBenefitTransStatus
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                            .LOCALE_KEY_VIEW_ATTACHMENT)),
                                        leading:  IconButton(
                                          hoverColor: AppTheme.kPrimaryColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ApprovalInboxAttachmentsListView(
                                                    attachmentsList: attachmentsList,
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

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (_requestDetails.approvalInboxType != null &&
                        _requestDetails.approvalInboxType.compareTo(
                                Const.APPROVAL_INBOX_LEAVE_ENCASHMENT_TYPE) ==
                            0)
                      Expanded(
                        flex: 7,
                        child: Card(
                          color: AppTheme.kPrimaryLightColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.kPrimaryLightColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_LEAVE_ENCASHMENT_FROM_DATE)),
                                        subtitle: Text(_requestDetails
                                                    .leaveEncashmentFromDate !=
                                                null
                                            ? _requestDetails
                                                .leaveEncashmentFromDate
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_LEAVE_ENCASHMENT_TO_DATE)),
                                        subtitle: Text(_requestDetails
                                                    .leaveEncashmentToDate !=
                                                null
                                            ? _requestDetails
                                                .leaveEncashmentToDate
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_LEAVE_ENCASHMENT_AMOUNT)),
                                        subtitle: Text(_requestDetails
                                                    .leaveEncashmentAmount !=
                                                null
                                            ? _requestDetails
                                                .leaveEncashmentAmount
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                            .LOCALE_KEY_VIEW_ATTACHMENT)),
                                        leading:  IconButton(
                                          hoverColor: AppTheme.kPrimaryColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ApprovalInboxAttachmentsListView(
                                                    attachmentsList: attachmentsList,
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

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (_requestDetails.approvalInboxType != null &&
                        _requestDetails.approvalInboxType.compareTo(
                                Const.APPROVAL_INBOX_SALARY_INC_TYPE) ==
                            0)
                      Expanded(
                        flex: 7,
                        child: Card(
                          color: AppTheme.kPrimaryLightColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.kPrimaryLightColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_SALARY_INC_REQUEST_AMOUNT)),
                                        subtitle: Text(_requestDetails
                                                    .salaryIncRequestAmount !=
                                                null
                                            ? _requestDetails
                                                .salaryIncRequestAmount
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_SALARY_INC_CURRENCY)),
                                        subtitle: Text(_requestDetails
                                                    .salaryIncCurrency !=
                                                null
                                            ? _requestDetails.salaryIncCurrency
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_SALARY_INC_CURRENT_SALARY)),
                                        subtitle: Text(_requestDetails
                                                    .salaryIncCurrentSalary !=
                                                null
                                            ? _requestDetails
                                                .salaryIncCurrentSalary
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_SALARY_INCR_TYPE)),
                                        subtitle: Text(_requestDetails
                                                    .salaryIncIncrType !=
                                                null
                                            ? _requestDetails.salaryIncIncrType
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_SALARY_INC_APPROVED_AMOUNT)),
                                        subtitle: Text(_requestDetails
                                                    .salaryIncApprovedAmount !=
                                                null
                                            ? _requestDetails
                                                .salaryIncApprovedAmount
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                                .LOCALE_KEY_SALARY_INC_REQUEST_DATE)),
                                        subtitle: Text(_requestDetails
                                                    .salaryIncRequestDate !=
                                                null
                                            ? _requestDetails
                                                .salaryIncRequestDate
                                                .toString()
                                            : "-"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text(Const
                                            .LOCALE_KEY_VIEW_ATTACHMENT)),
                                        leading:  IconButton(
                                          hoverColor: AppTheme.kPrimaryColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ApprovalInboxAttachmentsListView(
                                                    attachmentsList: attachmentsList,
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

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ///////----------------------
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                sendRequest(
                                    Const.APPROVAL_INBOX_ACCTION_ACCEPT);
                              },
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
                                        .text(Const.LOCALE_KEY_APPROVE),
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
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                sendRequest(Const.APPROVAL_INBOX_ACTION_REJECT);
                              },
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
                                        .text(Const.LOCALE_KEY_REJECT),
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
