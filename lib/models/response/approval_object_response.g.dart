// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_object_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalObjectResponse _$ApprovalObjectResponseFromJson(
    Map<String, dynamic> json) {
  return ApprovalObjectResponse()
    ..row_id = json['row_id'] as String
    ..approvalInboxType = json['approvalInboxType'] as String
    ..approvalInboxID = json['approvalInboxID'] as String
    ..employee_id = json['employee_id'] as String
    ..employeeName = json['employeeName'] as String
    ..vacationName = json['vacationName'] as String
    ..vacationLocation = json['vacationLocation'] as String
    ..vacationTransactionPeriod = json['vacationTransactionPeriod'] as int
    ..vacationTransactionReason = json['vacationTransactionReason'] as String
    ..startDate = json['startDate'] as String
    ..endDate = json['endDate'] as String
    ..vacationPlannedFlag = json['vacationPlannedFlag'] as String
    ..vacationLinkedVacationID = json['vacationLinkedVacationID'] as String
    ..vacationRequestChannel = json['vacationRequestChannel'] as String
    ..vacationHolidayDays = json['vacationHolidayDays'] as int
    ..vacationRemarks = json['vacationRemarks'] as String
    ..leaveId = json['leaveId'] as String
    ..leaveRequestStatus = json['leaveRequestStatus'] as String
    ..leaveTransactionStatus = json['leaveTransactionStatus'] as String
    ..leaveApprovedBy = json['leaveApprovedBy'] as String
    ..leaveStartTime = json['leaveStartTime'] as int
    ..leaveEndTime = json['leaveEndTime'] as int
    ..leaveNotes = json['leaveNotes'] as String
    ..loanTypes = json['loanTypes'] as String
    ..loanStatus = json['loanStatus'] as String
    ..loanCurrancy = json['loanCurrancy'] as String
    ..loanAmount = json['loanAmount'] as num
    ..loanRequestDate = json['loanRequestDate'] as String
    ..loanPaymentMethod = json['loanPaymentMethod'] as String
    ..loanInstallmentMethod = json['loanInstallmentMethod'] as String
    ..loanInstallmentStartDate = json['loanInstallmentStartDate'] as String
    ..loanApprovedAmount = json['loanApprovedAmount'] as num
    ..loanPaymentDueDate = json['loanPaymentDueDate'] as String
    ..extraWorkUnit = json['extraWorkUnit'] as String
    ..extraWorkUnitQuantity = json['extraWorkUnitQuantity'] as num
    ..extraWorkDayType = json['extraWorkDayType'] as String
    ..extraWorkReason = json['extraWorkReason'] as String
    ..extraWorkPayrollCycle = json['extraWorkPayrollCycle'] as String
    ..extraWorkRequestDate = json['extraWorkRequestDate'] as String
    ..expenseCurrancy = json['expenseCurrancy'] as String
    ..expenseAmount = json['expenseAmount'] as num
    ..expenseDate = json['expenseDate'] as String
    ..expenseRequestDate = json['expenseRequestDate'] as String
    ..expenseApprovedAmount = json['expenseApprovedAmount'] as num
    ..documentApprovedDate = json['documentApprovedDate'] as String
    ..documentDocumentType = json['documentDocumentType'] as String
    ..documentRequestdate = json['documentRequestdate'] as String
    ..empBenefitApproveDate = json['empBenefitApproveDate'] as String
    ..empBenefitTransStatus = json['empBenefitTransStatus'] as String
    ..empBenefitRequestAmt = json['empBenefitRequestAmt'] as num
    ..empBenefitRequestDate = json['empBenefitRequestDate'] as String
    ..empBenefitUnitPrice = json['empBenefitUnitPrice'] as String
    ..leaveEncashmentAmount = json['leaveEncashmentAmount'] as num
    ..leaveEncashmentLeave = json['leaveEncashmentLeave'] as String
    ..leaveEncashmentFromDate = json['leaveEncashmentFromDate'] as String
    ..leaveEncashmentToDate = json['leaveEncashmentToDate'] as String
    ..leaveEncashmentStatus = json['leaveEncashmentStatus'] as String
    ..salaryIncRequestDate = json['salaryIncRequestDate'] as String
    ..salaryIncCurrency = json['salaryIncCurrency'] as String
    ..salaryIncPayCycle = json['salaryIncPayCycle'] as String
    ..salaryIncNote = json['salaryIncNote'] as String
    ..salaryIncSerivecPeriod = json['salaryIncSerivecPeriod'] as String
    ..salaryIncCurrentSalary = json['salaryIncCurrentSalary'] as num
    ..salaryIncApprovedAmount = json['salaryIncApprovedAmount'] as num
    ..salaryIncIncrType = json['salaryIncIncrType'] as String
    ..salaryIncRequestAmount = json['salaryIncRequestAmount'] as num
    ..salaryIncRequestStatus = json['salaryIncRequestStatus'] as String
    ..salaryIncApprovedBy = json['salaryIncApprovedBy'] as String
    ..salaryIncApprovedDate = json['salaryIncApprovedDate'] as String
    ..vacationPaidDays = json['vacationPaidDays'] as num
    ..vacationUnPaidDays = json['vacationUnPaidDays'] as num
    ..vacationPreviousBalance = json['vacationPreviousBalance'] as num
    ..vacationNewBalance = json['vacationNewBalance'] as num
    ..extraWorkPayrollCycleDisplay =
        json['extraWorkPayrollCycleDisplay'] as String
    ..extraWorkPayrollCycleId = json['extraWorkPayrollCycleId'] as String;
}

Map<String, dynamic> _$ApprovalObjectResponseToJson(
        ApprovalObjectResponse instance) =>
    <String, dynamic>{
      'row_id': instance.row_id,
      'approvalInboxType': instance.approvalInboxType,
      'approvalInboxID': instance.approvalInboxID,
      'employee_id': instance.employee_id,
      'employeeName': instance.employeeName,
      'vacationName': instance.vacationName,
      'vacationLocation': instance.vacationLocation,
      'vacationTransactionPeriod': instance.vacationTransactionPeriod,
      'vacationTransactionReason': instance.vacationTransactionReason,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'vacationPlannedFlag': instance.vacationPlannedFlag,
      'vacationLinkedVacationID': instance.vacationLinkedVacationID,
      'vacationRequestChannel': instance.vacationRequestChannel,
      'vacationHolidayDays': instance.vacationHolidayDays,
      'vacationRemarks': instance.vacationRemarks,
      'leaveId': instance.leaveId,
      'leaveRequestStatus': instance.leaveRequestStatus,
      'leaveTransactionStatus': instance.leaveTransactionStatus,
      'leaveApprovedBy': instance.leaveApprovedBy,
      'leaveStartTime': instance.leaveStartTime,
      'leaveEndTime': instance.leaveEndTime,
      'leaveNotes': instance.leaveNotes,
      'loanTypes': instance.loanTypes,
      'loanStatus': instance.loanStatus,
      'loanCurrancy': instance.loanCurrancy,
      'loanAmount': instance.loanAmount,
      'loanRequestDate': instance.loanRequestDate,
      'loanPaymentMethod': instance.loanPaymentMethod,
      'loanInstallmentMethod': instance.loanInstallmentMethod,
      'loanInstallmentStartDate': instance.loanInstallmentStartDate,
      'loanApprovedAmount': instance.loanApprovedAmount,
      'loanPaymentDueDate': instance.loanPaymentDueDate,
      'extraWorkUnit': instance.extraWorkUnit,
      'extraWorkUnitQuantity': instance.extraWorkUnitQuantity,
      'extraWorkDayType': instance.extraWorkDayType,
      'extraWorkReason': instance.extraWorkReason,
      'extraWorkPayrollCycle': instance.extraWorkPayrollCycle,
      'extraWorkRequestDate': instance.extraWorkRequestDate,
      'expenseCurrancy': instance.expenseCurrancy,
      'expenseAmount': instance.expenseAmount,
      'expenseDate': instance.expenseDate,
      'expenseRequestDate': instance.expenseRequestDate,
      'expenseApprovedAmount': instance.expenseApprovedAmount,
      'documentApprovedDate': instance.documentApprovedDate,
      'documentDocumentType': instance.documentDocumentType,
      'documentRequestdate': instance.documentRequestdate,
      'empBenefitApproveDate': instance.empBenefitApproveDate,
      'empBenefitTransStatus': instance.empBenefitTransStatus,
      'empBenefitRequestAmt': instance.empBenefitRequestAmt,
      'empBenefitRequestDate': instance.empBenefitRequestDate,
      'empBenefitUnitPrice': instance.empBenefitUnitPrice,
      'leaveEncashmentAmount': instance.leaveEncashmentAmount,
      'leaveEncashmentLeave': instance.leaveEncashmentLeave,
      'leaveEncashmentFromDate': instance.leaveEncashmentFromDate,
      'leaveEncashmentToDate': instance.leaveEncashmentToDate,
      'leaveEncashmentStatus': instance.leaveEncashmentStatus,
      'salaryIncRequestDate': instance.salaryIncRequestDate,
      'salaryIncCurrency': instance.salaryIncCurrency,
      'salaryIncPayCycle': instance.salaryIncPayCycle,
      'salaryIncNote': instance.salaryIncNote,
      'salaryIncSerivecPeriod': instance.salaryIncSerivecPeriod,
      'salaryIncCurrentSalary': instance.salaryIncCurrentSalary,
      'salaryIncApprovedAmount': instance.salaryIncApprovedAmount,
      'salaryIncIncrType': instance.salaryIncIncrType,
      'salaryIncRequestAmount': instance.salaryIncRequestAmount,
      'salaryIncRequestStatus': instance.salaryIncRequestStatus,
      'salaryIncApprovedBy': instance.salaryIncApprovedBy,
      'salaryIncApprovedDate': instance.salaryIncApprovedDate,
      'vacationPaidDays': instance.vacationPaidDays,
      'vacationUnPaidDays': instance.vacationUnPaidDays,
      'vacationPreviousBalance': instance.vacationPreviousBalance,
      'vacationNewBalance': instance.vacationNewBalance,
      'extraWorkPayrollCycleDisplay': instance.extraWorkPayrollCycleDisplay,
      'extraWorkPayrollCycleId': instance.extraWorkPayrollCycleId,
    };
