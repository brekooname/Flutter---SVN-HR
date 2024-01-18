import 'package:flutter/material.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class LeaveListItem {
  LovValue? status;
  LovValue? type;
  String? fromDate;
  String? toDate;
  String? name;
  String? fromTime;
  String? toTime;

  LeaveListItem({
    this.status,
    this.type,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.name,
  });

  Icon? getRightIcon() {
    if (status!.row_id.compareTo(Const.LEAVE_REQUEST_APPROVED_STATUS) ==
        0) {
      return Icon(
        Icons.done_outline,
        color: AppTheme.green,
      );
    } else if (status!.row_id
        .compareTo(Const.LEAVE_REQUEST_CANCELED_STATUS) ==
        0) {
      return Icon(
        Icons.cancel,
        color: AppTheme.blue_dark,
      );
    } else if (status!.row_id
        .compareTo(Const.LEAVE_REQUEST_REJECTED_STATUS) ==
        0) {
      return Icon(
        Icons.close,
        color: AppTheme.red,
      );
    } else if (status!.row_id
        .compareTo(Const.LEAVE_REQUEST_PENDING_STATUS) ==
        0) {
      return Icon(
        Icons.query_builder,
        color: AppTheme.orange,
      );
    }
    }

  Color? getRightColor() {
    if (status!.row_id.compareTo(Const.LEAVE_REQUEST_APPROVED_STATUS) == 0) {
      return AppTheme.green;
    } else if (status!.row_id
        .compareTo(Const.LEAVE_REQUEST_CANCELED_STATUS) ==
        0) {
      return AppTheme.blue_dark;
    } else if (status!.row_id
        .compareTo(Const.LEAVE_REQUEST_REJECTED_STATUS) ==
        0) {
      return AppTheme.red;
    } else if (status!.row_id.compareTo(Const.LEAVE_REQUEST_PENDING_STATUS) ==
        0) {
      return AppTheme.orange;
    }
  }
}
