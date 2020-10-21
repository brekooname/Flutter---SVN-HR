import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class LeaveListItem {
  LovValue status;
  LovValue type;
  String fromDate;
  String toDate;
  String name;
  String fromTime;
  String toTime;

  LeaveListItem({
    this.status,
    this.type,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.name,
  });

  Icon getRightIcon() {
    if (status != null && status.row_id != null) {
      if (status.row_id.compareTo(Const.LEAVE_REQUEST_APPROVED_STATUS) ==
          0) {
        return Icon(
          Icons.done_outline,
          color: AppTheme.approved,
        );
      } else if (status.row_id
          .compareTo(Const.LEAVE_REQUEST_CANCELED_STATUS) ==
          0) {
        return Icon(
          Icons.cancel,
          color: AppTheme.canceled,
        );
      } else if (status.row_id
          .compareTo(Const.LEAVE_REQUEST_REJECTED_STATUS) ==
          0) {
        return Icon(
          Icons.close,
          color: AppTheme.declined,
        );
      } else if (status.row_id
          .compareTo(Const.LEAVE_REQUEST_PENDING_STATUS) ==
          0) {
        return Icon(
          Icons.query_builder,
          color: AppTheme.pending,
        );
      }
    }
  }

  Color getRightColor() {
    if (status.row_id.compareTo(Const.LEAVE_REQUEST_APPROVED_STATUS) == 0) {
      return AppTheme.approved;
    } else if (status.row_id
        .compareTo(Const.LEAVE_REQUEST_CANCELED_STATUS) ==
        0) {
      return AppTheme.canceled;
    } else if (status.row_id
        .compareTo(Const.LEAVE_REQUEST_REJECTED_STATUS) ==
        0) {
      return AppTheme.declined;
    } else if (status.row_id.compareTo(Const.LEAVE_REQUEST_PENDING_STATUS) ==
        0) {
      return AppTheme.pending;
    }
  }
}
