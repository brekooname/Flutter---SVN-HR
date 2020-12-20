class ApiConnections{

  ApiConnections._();

  // static const String url="http://176.67.58.26:19090/Sven/api";
 // static const String host="http://157.56.182.203:8080";
 //  static const String url=host+"/NetsuiteHR/api";
  static const String host="http://192.168.20.23:8080";
  static const String url=host+"/Sven/api";

  static const String login="/newlogin";

  static const bool NetSuiteFlag=false;

  static const String vacation_transaction="/getFilteredVacation2";

  static const String lov_values="/getCustomLovValues";

  static const String Vacations_type="/getVacations";

  static const String  Employee_Vacations="/getEmployeeVacations";

  static const String  Add_New_Vacations="/addVacationRequest2";

  static const String  UPLOAD_FILE="/fileupload";

  static const String PROFILE_SCREEN="/getListOfProfileScreen";

  static const String LEAVES_TRANSACTION="/getFilteredLeaveRequestsV2";

  static const String  ADD_NEW_LEAVE="/addLeaveRequestV2";

  static const String  GET_APPROVALS_LIST="/getApprovals";

  static const String  GET_APPROVAL_INBOX="/getApprovalObject";

  static const String  APPROVALS_INBOX_ACCEPT="/approvalInboxAcceptV2";

  static const String  APPROVAL_INBOX_REJECT="/approvalInboxReject";

  static const String  GET_ALL_NOTIFICATION_LIST="/getListOfAllNotification";

  static const String  GET_NOTIFICATION_OBJECT="/getNotificationObject";

  static const String  CLOSE_NOTIFICATION="/closeNotification";

  static const String  GET_LAST_CHECK="/getLastCheck";

  static const String  NEW_CHECK="/checkV2";

  static const String  USER_VERIFICATION="/userVerification";

  static const String  TIME_SHEET_HEADER_TRANSACTION="/getListFiltredTimesheets";

  static const String  ADD_TIME_SHEET_HEADER_REQUEST="/addTimesheetHeaderRequest";

  static const String  GET_TIME_SHEET_DETAILS_LIST="/getlistOfTimesheetDetails";

  static const String  GET_PROJECTS_lIST="/getlistOfProjects";

  static const String  ADD_TIME_SHEET_DETAILS="/addTimesheetDetailsRequestV2";

  static const String  ADD_NEW_LOCATION="/addNewLocation";

  static const String  ADD_NEW_NETWORK="/addNewNetwork";

  static const String  CHANGE_PASSWORD="/changePassword";

  static const String  ADD_EXTRA_WORK="/addExtraWorkRequestV2";

  static const String  ADD_EXPENSE="/addExpenseRequestV2";

  static const String  GET_LIST_OF_ATTACHMENTS="/getListOfAttachments";

  static const String  DOWN_LOAD_FILE="/downloadFile";

  static const String  GET_EXPENSE_TRANSACTION="/getExpenseRequestTransaction";

  static const String  GET_ATTENDANCE_SUMMARY="/getMyAttendSummaryV2";

  static const String  GET_EXTRA_WORK_TRANSACTION="/getExtraWorkTransaction";

}