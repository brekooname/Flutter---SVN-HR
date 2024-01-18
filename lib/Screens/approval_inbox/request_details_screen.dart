import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/approval_inbox/approval_inbox_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/approval_inbox_attachments_response.dart';
import 'package:sven_hr/models/response/approval_inbox_list_response.dart';
import 'package:sven_hr/models/response/approval_object_response.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';

class RequestDetailsScreen extends StatefulWidget {
  static String id = "RequestDetails";
  final ApprovalInboxListResponse? approvalInboxItenm;

  RequestDetailsScreen({this.approvalInboxItenm}) {
    // print(approvalInboxItenm);
  }

  @override
  _RequestDetailsScreenState createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  ApprovalObjectResponse? _requestDetails;
  ApprovalInboxController? _approvalInboxController;
  List<ApprovalInboxAttachmentsResponse>? attachmentsList;

  bool showSpinner = false;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  num? approvedAmount;
  @override
  void initState() {
    _requestDetails = ApprovalObjectResponse();
    _approvalInboxController = ApprovalInboxController();
    getApprovalInboxObject();
    getApprovalInboxAttachments();
    super.initState();
  }

  void getApprovalInboxObject() async {
    await _approvalInboxController!
        .getApprovalInboxObject(this.widget.approvalInboxItenm!.row_id)
        .then((value) {
      setState(() {
        print(value);
        _requestDetails = _approvalInboxController!.requestDetails;
      });
    });
  }

  void getApprovalInboxAttachments() async {
    await _approvalInboxController!
        .getApprovalInboxAttachments(this.widget.approvalInboxItenm!.row_id)
        .then((value) {
      attachmentsList = _approvalInboxController!.attachmentsList;
      setState(() {
        print(value);
      });
    });
  }

  void sendRequest(String action) async {
    buttonSendIsPressed = true;

    if (action.compareTo(Const.APPROVAL_INBOX_ACCTION_ACCEPT) == 0 &&
        _requestDetails!.approvalInboxType
                .compareTo(Const.APPROVAL_INBOX_EXPENSE_TYPE) ==
            0 &&
        _requestDetails!.expenseApprovedAmount == null) {
      ToastMessage.showWarningMsg(AppTranslations.of(context)!.text(
          Const.LOCALE_KEY_EXPENSE_APPROVED_AMOUNT +
              " " +
              Const.LOCALE_KEY_REQUIRED));
      return;
    }
    showSpinner = true;
    await _approvalInboxController!
        .approvalInboxAction(
        requestInput: _requestDetails,
        action: action,)
        .then((value) {
      if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
      if (action.compareTo(Const.APPROVAL_INBOX_ACCTION_ACCEPT) == 0) {
        ToastMessage.showSuccessMsg(
            AppTranslations.of(context)!.text(Const.LOCALE_KEY_APRROVED_MSG));
      } else {
        ToastMessage.showSuccessMsg(
            AppTranslations.of(context)!.text(Const.LOCALE_KEY_REJECTED_MSG));
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(0.22),
          title: Text(
            AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUEST_DETAILS),
            style: TextStyle(color: ModernTheme.textColor),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ModernTheme.textColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: ModernTheme.gradientStart.withOpacity(0.85), // Light grey background
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 10),
            child: ListView(
              shrinkWrap: true,
              children: [

                _buildRequestDetailsCard(),
                if (_requestDetails!.approvalInboxType!.compareTo(Const.APPROVAL_INBOX_VACATION_TYPE) == 0)
                  _buildVacationDetailsCard(),
                if (_requestDetails!.approvalInboxType!.compareTo(Const.APPROVAL_INBOX_LEAVE_TYPE) == 0)
                  _buildLeaveDetailsCard(),
                _buildAttachmentSection(context),
                _buildApprovalButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildAttachmentSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ModernTheme.gradientEnd.withOpacity(0.5),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppTranslations.of(context)!.text(Const.LOCALE_KEY_VIEW_ATTACHMENT),
              style: TextStyle(
                color: ModernTheme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove_red_eye_outlined, color: ModernTheme.textColor),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => ApprovalInboxAttachmentsListView(attachmentsList: attachmentsList),
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _buildRequestDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ModernTheme.accentColor.withOpacity(0.5),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_EMPLOYEE_NAME),
            value: _requestDetails?.employeeName ?? "N/A",
          ),
          Divider(color: ModernTheme.textColor.withOpacity(0.3)),
          _buildDetailRow(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUEST_DATE),
            value: this.widget.approvalInboxItenm!.approval_request_date ?? "-",
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ModernTheme.textColor.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: ModernTheme.textColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
  Widget _buildLeaveDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ModernTheme.gradientEnd.withOpacity(0.5),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow2(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_FROM),
            value: _requestDetails!.startDate,
          ),
          Divider(color: ModernTheme.textColor.withOpacity(0.3)),
          _buildDetailRow2(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_TO),
            value: _requestDetails!.endDate,
          ),
           Divider(color: ModernTheme.textColor.withOpacity(0.3)),

          _buildDetailRow2(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_LEAVES),
            value: _requestDetails!.leaveId,
          ),



          Divider(color: ModernTheme.textColor.withOpacity(0.3)),

          _buildDetailRow2(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_STATUS),
            value: _requestDetails!.leaveRequestStatus,
          ),

          Divider(color: ModernTheme.textColor.withOpacity(0.3)),

          _buildDetailRow2(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_LEAVE_START_TIME),
            value: _requestDetails!.leaveStartTime.toString(),
          ),
         ],
      ),
    );
  }

  Widget _buildVacationDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ModernTheme.gradientEnd.withOpacity(0.5),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow2(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_FROM),
            value: _requestDetails!.startDate ?? "Date ..",
          ),
          Divider(color: ModernTheme.textColor.withOpacity(0.3)),
          _buildDetailRow2(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_TO),
            value: _requestDetails!.endDate ?? "Date ..",
          ),
          // Repeat the pattern for other vacation details
          Divider(color: ModernTheme.textColor.withOpacity(0.3)),
          _buildDetailRow2(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_VACATION),
            value: _requestDetails!.vacationName,
          ),
          Divider(color: ModernTheme.textColor.withOpacity(0.3)),
          _buildDetailRow2(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_LOCATION),
            value: _requestDetails!.vacationLocation,
          ),
          Divider(color: ModernTheme.textColor.withOpacity(0.3)),
          _buildDetailRow(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_UNPAID_DAYS),
            value: _requestDetails!.vacationUnPaidDays.toString(),
          ),
          Divider(color: ModernTheme.textColor.withOpacity(0.3)),
          _buildDetailRow(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_NEW_BALANCE),
            value: _requestDetails!.vacationNewBalance.toString(),
          ),
          Divider(color: ModernTheme.textColor.withOpacity(0.3)),
          _buildDetailRow(
            title: AppTranslations.of(context)!.text(Const.LOCALE_KEY_PREVIOUS_BALANCE),
            value: _requestDetails!.vacationPreviousBalance.toString(),
          ),
         ],
      ),
    );
  }

  Widget _buildDetailRow2({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ModernTheme.textColor, // Updated to match the notification card style
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: ModernTheme.textColor, // Updated color
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildApprovalButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildActionButton(
          context: context,
          label: Const.LOCALE_KEY_APPROVE,
          onTap: () => sendRequest(Const.APPROVAL_INBOX_ACCTION_ACCEPT),
          color: ModernTheme.accentColor,
        ),
        const SizedBox(width: 16),
        _buildActionButton(
          context: context,
          label: Const.LOCALE_KEY_REJECT,
          onTap: () => sendRequest(Const.APPROVAL_INBOX_ACTION_REJECT),
          color: Colors.red,
        ),
      ],
    );
  }
  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color], // Gradient effect
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              AppTranslations.of(context)!.text(label),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white, // White text for better contrast
              ),
            ),
          ),
        ),
      ),
    );
  }
}
