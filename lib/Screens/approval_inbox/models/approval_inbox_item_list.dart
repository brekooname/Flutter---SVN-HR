import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class ApprovalInboxListItem {
  String? requestDate;
  String? titleName;
  String? status;


  ApprovalInboxListItem({this.requestDate, this.titleName,this.status});

  Icon? getRightIcon() {
    if (status!.compareTo(Const.REQUEST_RESPONSE_DISPLAYVALUE) ==
        0) {
      return Icon(
        Icons.new_releases_outlined,
        color: AppTheme.orange,
      );
    }
    }

  Color? getRightColor() {
    if (status!.compareTo(Const.REQUEST_RESPONSE_DISPLAYVALUE) == 0) {
      return AppTheme.orange;
    }
  }

}
