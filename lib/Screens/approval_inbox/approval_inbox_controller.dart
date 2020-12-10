import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/approval_inbox/models/approval_inbox_item_list.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/models/request/approval_inbox_attachments_request.dart';
import 'package:sven_hr/models/request/approval_inbox_input_base_request.dart';
import 'package:sven_hr/models/request/approval_inbox_input_request.dart';
import 'package:sven_hr/models/request/approval_object_request.dart';
import 'package:sven_hr/models/request/base_request.dart';
import 'package:sven_hr/models/response/approval_inbox_attachments_base_response.dart';
import 'package:sven_hr/models/response/approval_inbox_attachments_response.dart';
import 'package:sven_hr/models/response/approval_inbox_list_base_response.dart';
import 'package:sven_hr/models/response/approval_inbox_list_response.dart';
import 'package:sven_hr/models/response/approval_object_base_response.dart';
import 'package:sven_hr/models/response/approval_object_response.dart';
import 'package:sven_hr/services/download_file.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

class ApprovalInboxController {
  List<ApprovalInboxListItem> _approvalList;
  List<ApprovalInboxListResponse> _inboxlList;
  ApprovalObjectResponse _requestDetails;
  List<ApprovalInboxAttachmentsResponse> _attachmentsList;

  List<ApprovalInboxAttachmentsResponse> get attachmentsList =>
      _attachmentsList;

  set attachmentsList(List<ApprovalInboxAttachmentsResponse> value) {
    _attachmentsList = value;
  }

  List<ApprovalInboxListItem> get approvalList => _approvalList;
  set approvalList(List<ApprovalInboxListItem> value) {
    _approvalList = value;
  }

  List<ApprovalInboxListResponse> get inboxlList => _inboxlList;

  set inboxlList(List<ApprovalInboxListResponse> value) {
    _inboxlList = value;
  }

  ApprovalObjectResponse get requestDetails => _requestDetails;

  set requestDetails(ApprovalObjectResponse value) {
    _requestDetails = value;
  }

  Future<String> getLastApprovalInboxTransaction() async {
    approvalList = List();
    _inboxlList = List();
    BaseRequest request = BaseRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";
    request.tokenID = tokenId;

    if (request != null) {
      var url = ApiConnections.url + ApiConnections.GET_APPROVALS_LIST;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        ApprovalInboxListBaseResponse baseResponse =
            ApprovalInboxListBaseResponse.fromJson(userData);
        // add returned vacation to vacation list item view
        if (baseResponse.listOfApprovals != null) {
          for (ApprovalInboxListResponse inbox
              in baseResponse.listOfApprovals) {
            ApprovalInboxListItem item = ApprovalInboxListItem(
                requestDate: inbox.approval_request_date,
                titleName: inbox.title_name,
                status: inbox.request_response_displayValue);

            approvalList.add(item);
            _inboxlList.add(inbox);
          }
        }
        print("Finshed");
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  Future<String> getApprovalInboxObject(String approvalInboxId) async {
    _requestDetails = ApprovalObjectResponse();
    ApprovalObjectRequest request = ApprovalObjectRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";
    BaseRequest baseRequest = BaseRequest();
    baseRequest.tokenID = tokenId;
    request.tokenWrapper = baseRequest;
    request.par_row_id = approvalInboxId;

    if (request != null) {
      var url = ApiConnections.url + ApiConnections.GET_APPROVAL_INBOX;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        ApprovalObjectBaseResponse baseResponse =
            ApprovalObjectBaseResponse.fromJson(userData);
        // add returned vacation to vacation list item view
        if (baseResponse.approvalInboxObject != null) {
          requestDetails = baseResponse.approvalInboxObject;
        }
        print("Finshed");
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  Future<String> approvalInboxAction(
      {ApprovalObjectResponse requestInput, String action}) async {
    final prefs = await SharedPreferences.getInstance();
    String tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID);
    var url;
    if (action.compareTo(Const.APPROVAL_INBOX_ACCTION_ACCEPT) == 0) {
      url = ApiConnections.url + ApiConnections.APPROVALS_INBOX_ACCEPT;
    } else {
      url = ApiConnections.url + ApiConnections.APPROVAL_INBOX_REJECT;
    }
    ApprovalInboxInputRequest inboxInputRequest = ApprovalInboxInputRequest();
    inboxInputRequest.approvedInboxId = requestInput.approvalInboxID;
    inboxInputRequest.payrolCycle = requestInput.extraWorkPayrollCycleId;
    if (requestInput.expenseApprovedAmount != null)
      inboxInputRequest.approvedAmount =
          requestInput.expenseApprovedAmount.toDouble();

    // if(requestInput.approvalInboxType!=null){
    //   if(requestInput.approvalInboxType.compareTo(Const.APPROVAL_INBOX_LOAN_TYPE)==0){
    //
    //     inboxInputRequest.approvedAmount = requestInput.loanApprovedAmount;
    //     inboxInputRequest.installmentAmount = requestInput.loanAmount;
    //     inboxInputRequest.paymentDueDate = requestInput.approvalInboxID;
    //     inboxInputRequest.payrolCycle = requestInput.approvalInboxID;
    //   }else  if(requestInput.approvalInboxType.compareTo(Const.APPROVAL_INBOX_EXPENSE_TYPE)==0){
    //
    //     inboxInputRequest.approvedAmount = requestInput.expenseApprovedAmount;
    //     inboxInputRequest.installmentAmount = requestInput.expenseAmount;
    //     inboxInputRequest.paymentDueDate = requestInput.expenseDate;
    //     inboxInputRequest.payrolCycle = requestInput.approvalInboxID;
    //   }
    // }

    ApprovalInboxInputBaseRequest request = ApprovalInboxInputBaseRequest(
        tokenId: tokenId, approvalObject: inboxInputRequest);
    NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
    var userData = await helper.getData();
    if (userData != null &&
        userData[Const.SYSTEM_RESPONSE_CODE] != null &&
        userData[Const.SYSTEM_RESPONSE_CODE]
                .compareTo(Const.SYSTEM_SUCCESS_MSG) ==
            0) {
      return Const.SYSTEM_SUCCESS_MSG;
    } else {
      print(userData[Const.SYSTEM_MSG_CODE]);
      return userData[Const.SYSTEM_MSG_CODE];
    }
  }

  Future<String> getApprovalInboxAttachments(String approvalInboxId) async {
    attachmentsList = List();

    ApprovalInboxAttachmentsRequest request = ApprovalInboxAttachmentsRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";

    request.token_id = tokenId;
    request.approval_inbox_row_id = approvalInboxId;

    if (request != null) {
      var url = ApiConnections.url + ApiConnections.GET_LIST_OF_ATTACHMENTS;
      NetworkHelper helper = NetworkHelper(url: url, map: request.toJson());
      var userData = await helper.getData();
      if (userData != null &&
          userData[Const.SYSTEM_MSG_CODE] != null &&
          userData[Const.SYSTEM_MSG_CODE].compareTo(Const.SYSTEM_SUCCESS_MSG) ==
              0) {
        ApprovalInboxAttachmentsBaseResponse baseResponse =
            ApprovalInboxAttachmentsBaseResponse.fromJson(userData);
        // add returned vacation to vacation list item view
        if (baseResponse.listOfAttachments != null) {
          attachmentsList = baseResponse.listOfAttachments;
        }
        print("Finshed");
        return Const.SYSTEM_SUCCESS_MSG;
      } else {
        ToastMessage.showErrorMsg(userData[Const.SYSTEM_MSG_CODE]);
      }
    }
  }

  Future<String> downloadFile(String attachId, String attachName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString(Const.SHARED_KEY_TOKEN_ID) ?? "";

    if (attachId != null) {
      var url = ApiConnections.url + ApiConnections.DOWN_LOAD_FILE;
      DownloadFile helper = DownloadFile(
          url: url,
          attach_rowId: attachId,
          token_id: tokenId,
          attach_name: attachName);
     File file= await helper.downloadFile();
     if(file!=null) {
      await OpenFile.open(file.path);
       return Const.SYSTEM_SUCCESS_MSG;
     }

    }
  }
}
