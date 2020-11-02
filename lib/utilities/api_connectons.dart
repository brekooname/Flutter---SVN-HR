class ApiConnections{

  ApiConnections._();

  // static const String url="http://176.67.58.26:19090/Sven/api";
//  static const String url="http://157.56.182.203:8080/NetsuiteHR/api";
  static const String url="http://192.168.20.23:8080/Sven/api";

  static const String login="/login";

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

  static const String  APPROVALS_INBOX_ACCEPT="/approvalInboxAccept";

  static const String  APPROVAL_INBOX_REJECT="/approvalInboxReject";

  static const String  GET_ALL_NOTIFICATION_LIST="/getListOfAllNotification";

  static const String  GET_NOTIFICATION_OBJECT="/getNotificationObject";

  static const String  CLOSE_NOTIFICATION="/closeNotification";

  static const String  GET_LAST_CHECK="/getLastCheck";

  static const String  NEW_CHECK="/checkV2";

  static const String  USER_VERIFICATION="/userVerification";
}