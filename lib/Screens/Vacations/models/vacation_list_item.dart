import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class VacationListItem {
  LovValue status;
  LovValue type;
  String fromDate;
  String toDate;
  String name;
  // Icon icon;
  // Color color;
  VacationListItem({
    this.status,
    this.type,
    this.fromDate,
    this.toDate,
    this.name,
  });

  Icon getRightIcon() {
    if (status != null && status.row_id != null) {
      if (status.row_id.compareTo(Const.VACATION_REQUEST_APPROVED_STATUS) ==
          0) {
        return Icon(
          Icons.done_outline,
          color: AppTheme.approved,
        );
      } else if (status.row_id
              .compareTo(Const.VACATION_REQUEST_CANCELED_STATUS) ==
          0) {
        return Icon(
          Icons.cancel,
          color: AppTheme.canceled,
        );
      } else if (status.row_id
              .compareTo(Const.VACATION_REQUEST_DECLINED_STATUS) ==
          0) {
        return Icon(
          Icons.close,
          color: AppTheme.declined,
        );
      } else if (status.row_id
              .compareTo(Const.VACATION_REQUEST_PENDING_STATUS) ==
          0) {
        return Icon(
          Icons.query_builder,
          color: AppTheme.pending,
        );
      }
    }
  }

  Color getRightColor() {
    if (status.row_id.compareTo(Const.VACATION_REQUEST_APPROVED_STATUS) == 0) {
      return AppTheme.approved;
    } else if (status.row_id
            .compareTo(Const.VACATION_REQUEST_CANCELED_STATUS) ==
        0) {
      return AppTheme.canceled;
    } else if (status.row_id
            .compareTo(Const.VACATION_REQUEST_DECLINED_STATUS) ==
        0) {
      return AppTheme.declined;
    } else if (status.row_id.compareTo(Const.VACATION_REQUEST_PENDING_STATUS) ==
        0) {
      return AppTheme.pending;
    }
  }

  // static List<VacationListItem> vacationList = <VacationListItem>[
  //   // VacationListItem(
  //   //   status: "Approved",
  //   //   type: "internal",
  //   //   fromDate: "16-9-2020",
  //   //   toDate: "16-9-2020",
  //   //   name: "Annual Vacation",
  //   //   color: AppTheme.approved,
  //   //   icon: Icon(
  //   //     Icons.done_outline,
  //   //     color: AppTheme.approved,
  //   //   ),
  //   // ),
  //   // VacationListItem(
  //   //   status: "Canceled",
  //   //   type: "internal",
  //   //   fromDate: "16-9-2020",
  //   //   toDate: "16-9-2020",
  //   //   name: "Annual Vacation",
  //   //   color: AppTheme.canceled,
  //   //   icon: Icon(
  //   //     Icons.cancel,
  //   //     color: AppTheme.canceled,
  //   //   ),
  //   // ),
  //   // VacationListItem(
  //   //   status: "Rejected",
  //   //   type: "internal",
  //   //   fromDate: "16-9-2020",
  //   //   toDate: "16-9-2020",
  //   //   name: "Annual Vacation",
  //   //   color: AppTheme.rejected,
  //   //   icon: Icon(
  //   //     Icons.close,
  //   //     color: AppTheme.rejected,
  //   //   ),
  //   // ),
  //   // VacationListItem(
  //   //   status: "Pending",
  //   //   type: "internal",
  //   //   fromDate: "16-9-2020",
  //   //   toDate: "16-9-2020",
  //   //   name: "Annual Vacation",
  //   //   color: AppTheme.pending,
  //   //   icon: Icon(
  //   //     Icons.query_builder,
  //   //     color: AppTheme.pending,
  //   //   ),
  //   // ),
  // ];
}
