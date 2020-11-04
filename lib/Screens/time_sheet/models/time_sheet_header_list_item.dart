import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class TimeSheetHeaderListItem {
  String startDate;
  num workingHour;
  num shiftTypeHour;
  num differenceHour;


  TimeSheetHeaderListItem({this.startDate, this.workingHour, this.shiftTypeHour,
      this.differenceHour});

  Icon getRightIcon() {
    return Icon(
      Icons.timelapse_outlined,
      color: AppTheme.canceled,
    );
  }

  Color getRightColor() {
    return AppTheme.canceled;
  }

}
