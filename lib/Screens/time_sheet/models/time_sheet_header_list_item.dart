import 'package:flutter/material.dart';
import 'package:sven_hr/Screens/app_settings/server_connection_screen.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class TimeSheetHeaderListItem {
  String? startDate;
  num? workingHour;
  num? shiftTypeHour;
  num? differenceHour;


  TimeSheetHeaderListItem({this.startDate, this.workingHour, this.shiftTypeHour,
      this.differenceHour});

  Icon getRightIcon() {
    return Icon(
      Icons.timelapse_outlined,
      color: AppTheme.blue_dark,
    );
  }

  Color getRightColor() {
    return ModernTheme.textColor;
  }

}
