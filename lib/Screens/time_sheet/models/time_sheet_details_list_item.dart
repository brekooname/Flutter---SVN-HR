import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class TimeSheetDetailsListItem {
  num startTime;
  num endTime;
  String status;
  String projectName;
  num workingHour;


  TimeSheetDetailsListItem({this.startTime, this.endTime, this.status,
      this.projectName, this.workingHour});

  Icon getRightIcon() {
    return Icon(
      Icons.timelapse_sharp,
      color: AppTheme.kPrimaryColor,
    );
  }

  Color getRightColor() {
    return AppTheme.kPrimaryColor;
  }

}
