import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/custom_drawer/notification_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/notifications_object_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../app_settings/server_connection_screen.dart';

class NotificationDetailsScreen extends StatefulWidget {
  static String? id = "NotificationDetails";
  final String? approvalInboxId;

  NotificationDetailsScreen({this.approvalInboxId});

  @override
  _NotificationDetailsScreenState createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  NotificationObjectResponse? _notificationDetail;
  NotificationController? _notificationController;

  bool showSpinner = false;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  @override
  void initState() {
    _notificationDetail = NotificationObjectResponse();
    _notificationController = NotificationController();
    geNotificationObject();
    super.initState();
  }

  void geNotificationObject() async {
    var response = await _notificationController!.geNotificationObject(this.widget.approvalInboxId!);
    if (!mounted) return;
    setState(() {
      print(response);
      _notificationDetail = _notificationController!.notificationDetail;
    });
  }

  @override
  void dispose() {
    // Your subscription/controller disposing logic here
    super.dispose();
  }

  void closeNotification() async {
    buttonSendIsPressed = true;
    showSpinner = true;

    await _notificationController!
        .closeNotification(notifId: _notificationDetail!.row_id)
        .then((value) {
      if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
      // ToastMessage.showSuccessMsg(Const.VACATION_SENT_SUCCESSFULLY);
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
    if (_notificationDetail!.message == null) {
      // Show loading indicator while data is being fetched
      return Scaffold(
        appBar: AppBar(backgroundColor: ModernTheme.gradientStart),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(0.22),
          title: Text(
            AppTranslations.of(context)!.text(Const.LOCALE_KEY_NOTIFICATION_DETAILS),
            style: TextStyle(color: ModernTheme.textColor),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ModernTheme.textColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: ModernTheme.backgroundGradient),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildNotificationCard(),
                         _buildActionButton(context),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard() {
    return Card(
      color: ModernTheme.gradientStart.withOpacity(0.95), // Softened color for the card
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _notificationDetail?.message ?? "-",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ModernTheme.accentColor),
            ),
            SizedBox(height: 10),
            Text(
              'Issue Date: ' + (_notificationDetail?.issue_date ?? "-"),
              style: TextStyle(fontSize: 16, color: ModernTheme.accentColor),
            ),
            Divider(color: ModernTheme.accentColor, thickness: 1, height: 20),
            _buildDetailRow(icon: Icons.fact_check, title: 'Status:', value: _notificationDetail?.requestStatus ?? "-"),
            _buildDetailRow(icon: Icons.badge, title: 'Employee Number:', value: _notificationDetail?.employeeNumber ?? "-"),
            _buildDetailRow(icon: Icons.person, title: 'Employee Name:', value: _notificationDetail?.employeeName ?? "-"),
            _buildDetailRow(icon: Icons.work, title: 'Employment Class:', value: _notificationDetail?.employmentClass ?? "-"),
            _buildDetailRow(icon: Icons.touch_app, title: 'Action By:', value: _notificationDetail?.action_user_name ?? "-"),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Icon(icon, color: ModernTheme.accentColor.withOpacity(0.8), size: 20), // Slightly subdued icon color
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ModernTheme.accentColor),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: ModernTheme.accentColor),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ModernTheme.accentColor), // Button color
        foregroundColor: MaterialStateProperty.all(ModernTheme.textColor), // Text color
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
        elevation: MaterialStateProperty.all(5), // Slight elevation for a subtle shadow
      ),
      onPressed: closeNotification,
      child: Text(
        AppTranslations.of(context)!.text(Const.LOCALE_KEY_EMPLOYMENT_CLOSE),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
