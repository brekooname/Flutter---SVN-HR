import 'package:flutter/material.dart';
import 'package:sven_hr/Screens/app_settings/server_connection_screen.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class TimeSheetDetailsListItem {
  num? startTime;
  num? endTime;
  String? status;
  String? projectName;
  num? workingHour;


  TimeSheetDetailsListItem({this.startTime, this.endTime, this.status,
      this.projectName, this.workingHour});

  Icon getRightIcon() {
    return Icon(
      Icons.timelapse_sharp,
      color: AppTheme.kPrimaryColor,
    );
  }

  Color getRightColor() {
    return ModernTheme.textColor;
  }

}
