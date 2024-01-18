// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_object_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalObjectResponse _$ApprovalObjectResponseFromJson(Map<String, dynamic> json) {
  return ApprovalObjectResponse()
    ..extra_work_date = json['extra_work_date'] as String? ?? 'default_extra_work_date'
    ..row_id = json['row_id'] as String? ?? 'default_row_id'
    ..approvalInboxType = json['approvalInboxType'] as String? ?? 'default_approvalInboxType'
    ..approvalInboxID = json['approvalInboxID'] as String? ?? 'default_approvalInboxID'
    ..employee_id = json['employee_id'] as String? ?? 'default_employee_id'
    ..employeeName = json['employeeName'] as String? ?? 'default_employeeName'
    ..vacationName = json['vacationName'] as String? ?? 'default_vacationName'
    ..vacationLocation = json['vacationLocation'] as String? ?? 'default_vacationLocation'
    ..vacationTransactionPeriod = json['vacationTransactionPeriod'] as num? ?? 0
    ..vacationTransactionReason = json['vacationTransactionReason'] as String? ?? 'default_vacationTransactionReason'
    ..startDate = json['startDate'] as String? ?? 'default_startDate'
    ..endDate = json['endDate'] as String? ?? 'default_endDate'
    ..vacationPlannedFlag = json['vacationPlannedFlag'] as String? ?? 'default_vacationPlannedFlag'
    ..vacationLinkedVacationID = json['vacationLinkedVacationID'] as String? ?? 'default_vacationLinkedVacationID'
    ..vacationRequestChannel = json['vacationRequestChannel'] as String? ?? 'default_vacationRequestChannel'
    ..vacationHolidayDays = json['vacationHolidayDays'] as num? ?? 0
    ..vacationRemarks = json['vacationRemarks'] as String? ?? 'default_vacationRemarks'
    ..leaveId = json['leaveId'] as String? ?? 'default_leaveId'
    ..leaveRequestStatus = json['leaveRequestStatus'] as String? ?? 'default_leaveRequestStatus'
    ..leaveTransactionStatus = json['leaveTransactionStatus'] as String? ?? 'default_leaveTransactionStatus'
    ..leaveApprovedBy = json['leaveApprovedBy'] as String? ?? 'default_leaveApprovedBy'
    ..leaveStartTime = json['leaveStartTime'] as num? ?? 0
    ..leaveEndTime = json['leaveEndTime'] as num? ?? 0
    ..leaveNotes = json['leaveNotes'] as String? ?? 'default_leaveNotes'
    ..loanTypes = json['loanTypes'] as String? ?? 'default_loanTypes'
    ..loanStatus = json['loanStatus'] as String? ?? 'default_loanStatus'
    ..loanCurrancy = json['loanCurrancy'] as String? ?? 'default_loanCurrancy'
    ..loanAmount = json['loanAmount'] as num? ?? 0
    ..loanRequestDate = json['loanRequestDate'] as String? ?? 'default_loanRequestDate'
    ..loanPaymentMethod = json['loanPaymentMethod'] as String? ?? 'default_loanPaymentMethod'
    ..loanInstallmentMethod = json['loanInstallmentMethod'] as String? ?? 'default_loanInstallmentMethod'
    ..loanInstallmentStartDate = json['loanInstallmentStartDate'] as String? ?? 'default_loanInstallmentStartDate'
    ..loanApprovedAmount = json['loanApprovedAmount'] as num? ?? 0
    ..loanPaymentDueDate = json['loanPaymentDueDate'] as String? ?? 'default_loanPaymentDueDate'
    ..extraWorkUnit = json['extraWorkUnit'] as String? ?? 'default_extraWorkUnit'
    ..extraWorkUnitQuantity = json['extraWorkUnitQuantity'] as num? ?? 0
    ..extraWorkDayType = json['extraWorkDayType'] as String? ?? 'default_extraWorkDayType'
    ..extraWorkReason = json['extraWorkReason'] as String? ?? 'default_extraWorkReason'
    ..extraWorkPayrollCycle = json['extraWorkPayrollCycle'] as String? ?? 'default_extraWorkPayrollCycle'
    ..extraWorkRequestDate = json['extraWorkRequestDate'] as String? ?? 'default_extraWorkRequestDate'
    ..expenseCurrancy = json['expenseCurrancy'] as String? ?? 'default_expenseCurrancy'
    ..expenseAmount = json['expenseAmount'] as num? ?? 0
    ..expenseDate = json['expenseDate'] as String? ?? 'default_expenseDate'
    ..expenseRequestDate = json['expenseRequestDate'] as String? ?? 'default_expenseRequestDate'
    ..expenseApprovedAmount = json['expenseApprovedAmount'] as num? ?? 0
    ..documentApprovedDate = json['documentApprovedDate'] as String? ?? 'default_documentApprovedDate'
    ..documentDocumentType = json['documentDocumentType'] as String? ?? 'default_documentDocumentType'
    ..documentRequestdate = json['documentRequestdate'] as String? ?? 'default_documentRequestdate'
    ..empBenefitApproveDate = json['empBenefitApproveDate'] as String? ?? 'default_empBenefitApproveDate'
    ..empBenefitTransStatus = json['empBenefitTransStatus'] as String? ?? 'default_empBenefitTransStatus'
    ..empBenefitRequestAmt = json['empBenefitRequestAmt'] as num? ?? 0
    ..empBenefitRequestDate = json['empBenefitRequestDate'] as String? ?? 'default_empBenefitRequestDate'
    ..empBenefitUnitPrice = json['empBenefitUnitPrice'] as String? ?? 'default_empBenefitUnitPrice'
    ..leaveEncashmentAmount = json['leaveEncashmentAmount'] as num? ?? 0
    ..leaveEncashmentLeave = json['leaveEncashmentLeave'] as String? ?? 'default_leaveEncashmentLeave'
    ..leaveEncashmentFromDate = json['leaveEncashmentFromDate'] as String? ?? 'default_leaveEncashmentFromDate'
    ..leaveEncashmentToDate = json['leaveEncashmentToDate'] as String? ?? 'default_leaveEncashmentToDate'
    ..leaveEncashmentStatus = json['leaveEncashmentStatus'] as String? ?? 'default_leaveEncashmentStatus'
    ..salaryIncRequestDate = json['salaryIncRequestDate'] as String? ?? 'default_salaryIncRequestDate'
    ..salaryIncCurrency = json['salaryIncCurrency'] as String? ?? 'default_salaryIncCurrency'
    ..salaryIncPayCycle = json['salaryIncPayCycle'] as String? ?? 'default_salaryIncPayCycle'
    ..salaryIncNote = json['salaryIncNote'] as String? ?? 'default_salaryIncNote'
    ..salaryIncSerivecPeriod = json['salaryIncSerivecPeriod'] as String? ?? 'default_salaryIncSerivecPeriod'
    ..salaryIncCurrentSalary = json['salaryIncCurrentSalary'] as num? ?? 0
    ..salaryIncApprovedAmount = json['salaryIncApprovedAmount'] as num? ?? 0
    ..salaryIncIncrType = json['salaryIncIncrType'] as String? ?? 'default_salaryIncIncrType'
    ..salaryIncRequestAmount = json['salaryIncRequestAmount'] as num? ?? 0
    ..salaryIncRequestStatus = json['salaryIncRequestStatus'] as String? ?? 'default_salaryIncRequestStatus'
    ..salaryIncApprovedBy = json['salaryIncApprovedBy'] as String? ?? 'default_salaryIncApprovedBy'
    ..salaryIncApprovedDate = json['salaryIncApprovedDate'] as String? ?? 'default_salaryIncApprovedDate'
    ..vacationPaidDays = json['vacationPaidDays'] as num? ?? 0
    ..vacationUnPaidDays = json['vacationUnPaidDays'] as num? ?? 0
    ..vacationPreviousBalance = json['vacationPreviousBalance'] as num? ?? 0
    ..vacationNewBalance = json['vacationNewBalance'] as num? ?? 0
    ..extraWorkPayrollCycleDisplay = json['extraWorkPayrollCycleDisplay'] as String? ?? 'default_extraWorkPayrollCycleDisplay'
    ..extraWorkPayrollCycleId = json['extraWorkPayrollCycleId'] as String? ?? 'default_extraWorkPayrollCycleId';
}


Map<String, dynamic> _$ApprovalObjectResponseToJson(
        ApprovalObjectResponse instance) =>
    <String, dynamic>{
      'extra_work_date': instance.extra_work_date,
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
