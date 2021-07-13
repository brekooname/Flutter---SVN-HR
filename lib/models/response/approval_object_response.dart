import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/base_request.dart';

part 'approval_object_response.g.dart';

@JsonSerializable(nullable: false)
class ApprovalObjectResponse {
  ApprovalObjectResponse();

  factory ApprovalObjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ApprovalObjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalObjectResponseToJson(this);

  @JsonKey(name: 'row_id')
  String _row_id;

  @JsonKey(name: 'approvalInboxType')
  String _approvalInboxType;

  @JsonKey(name: 'approvalInboxID')
  String _approvalInboxID;

  @JsonKey(name: 'employee_id')
  String _employee_id;

  @JsonKey(name: 'employeeName')
  String _employeeName;

  @JsonKey(name: 'vacationName')
  String _vacationName;

  @JsonKey(name: 'vacationLocation')
  String _vacationLocation;

  @JsonKey(name: 'vacationTransactionPeriod')
  num _vacationTransactionPeriod;

  @JsonKey(name: 'vacationTransactionReason')
  String _vacationTransactionReason;

  @JsonKey(name: 'startDate')
  String _startDate;

  @JsonKey(name: 'endDate')
  String _endDate;

  @JsonKey(name: 'vacationPlannedFlag')
  String _vacationPlannedFlag;

  @JsonKey(name: 'vacationLinkedVacationID')
  String _vacationLinkedVacationID;

  @JsonKey(name: 'vacationRequestChannel')
  String _vacationRequestChannel;

  @JsonKey(name: 'vacationHolidayDays')
  num _vacationHolidayDays;

  @JsonKey(name: 'vacationPaidDays')
  num _vacationPaidDays;

  @JsonKey(name: 'vacationUnPaidDays')
  num _vacationUnPaidDays;

  @JsonKey(name: 'vacationPreviousBalance')
  num _vacationPreviousBalance;

  @JsonKey(name: 'vacationNewBalance')
  num _vacationNewBalance;

  @JsonKey(name: 'vacationRemarks')
  String _vacationRemarks;

  @JsonKey(name: 'leaveId')
  String _leaveId;

  @JsonKey(name: 'leaveRequestStatus')
  String _leaveRequestStatus;

  @JsonKey(name: 'leaveTransactionStatus')
  String _leaveTransactionStatus;

  @JsonKey(name: 'leaveApprovedBy')
  String _leaveApprovedBy;

  @JsonKey(name: 'leaveStartTime')
  num _leaveStartTime;

  @JsonKey(name: 'leaveEndTime')
  num _leaveEndTime;

  @JsonKey(name: 'leaveNotes')
  String _leaveNotes;

  @JsonKey(name: 'loanTypes')
  String _loanTypes;

  @JsonKey(name: 'loanStatus')
  String _loanStatus;

  @JsonKey(name: 'loanCurrancy')
  String _loanCurrancy;

  @JsonKey(name: 'loanAmount')
  num _loanAmount;

  @JsonKey(name: 'loanRequestDate')
  String _loanRequestDate;

  @JsonKey(name: 'loanPaymentMethod')
  String _loanPaymentMethod;

  @JsonKey(name: 'loanInstallmentMethod')
  String _loanInstallmentMethod;

  @JsonKey(name: 'loanInstallmentStartDate')
  String _loanInstallmentStartDate;

  @JsonKey(name: 'loanApprovedAmount')
  num _loanApprovedAmount;

  @JsonKey(name: 'loanPaymentDueDate')
  String _loanPaymentDueDate;

  @JsonKey(name: 'extraWorkUnit')
  String _extraWorkUnit;

  @JsonKey(name: 'extraWorkUnitQuantity')
  num _extraWorkUnitQuantity;

  @JsonKey(name: 'extraWorkDayType')
  String _extraWorkDayType;

  @JsonKey(name: 'extraWorkReason')
  String _extraWorkReason;

  @JsonKey(name: 'extraWorkPayrollCycle')
  String _extraWorkPayrollCycle;

  @JsonKey(name: 'extraWorkPayrollCycleId')
  String _extraWorkPayrollCycleId;

  @JsonKey(name: 'extraWorkPayrollCycleDisplay')
  String _extraWorkPayrollCycleDisplay;

  @JsonKey(name: 'extraWorkRequestDate')
  String _extraWorkRequestDate;

  @JsonKey(name: 'expenseCurrancy')
  String _expenseCurrancy;

  @JsonKey(name: 'expenseAmount')
  num _expenseAmount;

  @JsonKey(name: 'expenseDate')
  String _expenseDate;

  @JsonKey(name: 'expenseRequestDate')
  String _expenseRequestDate;

  @JsonKey(name: 'expenseApprovedAmount')
  num _expenseApprovedAmount;

  @JsonKey(name: 'documentApprovedDate')
  String _documentApprovedDate;

  @JsonKey(name: 'documentDocumentType')
  String _documentDocumentType;

  @JsonKey(name: 'documentRequestdate')
  String _documentRequestdate;

  @JsonKey(name: 'empBenefitApproveDate')
  String _empBenefitApproveDate;

  @JsonKey(name: 'empBenefitTransStatus')
  String _empBenefitTransStatus;

  @JsonKey(name: 'empBenefitRequestAmt')
  num _empBenefitRequestAmt;

  @JsonKey(name: 'empBenefitRequestDate')
  String _empBenefitRequestDate;

  @JsonKey(name: 'empBenefitUnitPrice')
  String _empBenefitUnitPrice;

  @JsonKey(name: 'leaveEncashmentAmount')
  num _leaveEncashmentAmount;

  @JsonKey(name: 'leaveEncashmentLeave')
  String _leaveEncashmentLeave;

  @JsonKey(name: 'leaveEncashmentFromDate')
  String _leaveEncashmentFromDate;

  @JsonKey(name: 'leaveEncashmentToDate')
  String _leaveEncashmentToDate;

  @JsonKey(name: 'leaveEncashmentStatus')
  String _leaveEncashmentStatus;

  @JsonKey(name: 'salaryIncRequestDate')
  String _salaryIncRequestDate;

  @JsonKey(name: 'salaryIncCurrency')
  String _salaryIncCurrency;

  @JsonKey(name: 'salaryIncPayCycle')
  String _salaryIncPayCycle;

  @JsonKey(name: 'salaryIncNote')
  String _salaryIncNote;

  @JsonKey(name: 'salaryIncSerivecPeriod')
  String _salaryIncSerivecPeriod;

  @JsonKey(name: 'salaryIncCurrentSalary')
  num _salaryIncCurrentSalary;

  @JsonKey(name: 'salaryIncApprovedAmount')
  num _salaryIncApprovedAmount;

  @JsonKey(name: 'salaryIncIncrType')
  String _salaryIncIncrType;

  @JsonKey(name: 'salaryIncRequestAmount')
  num _salaryIncRequestAmount;

  @JsonKey(name: 'salaryIncRequestStatus')
  String _salaryIncRequestStatus;

  @JsonKey(name: 'salaryIncApprovedBy')
  String _salaryIncApprovedBy;

  @JsonKey(name: 'salaryIncApprovedDate')
  String _salaryIncApprovedDate;

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  String get approvalInboxType => _approvalInboxType;

  set approvalInboxType(String value) {
    _approvalInboxType = value;
  }

  String get approvalInboxID => _approvalInboxID;

  set approvalInboxID(String value) {
    _approvalInboxID = value;
  }

  String get employee_id => _employee_id;

  set employee_id(String value) {
    _employee_id = value;
  }

  String get employeeName => _employeeName;

  set employeeName(String value) {
    _employeeName = value;
  }

  String get vacationName => _vacationName;

  set vacationName(String value) {
    _vacationName = value;
  }

  String get vacationLocation => _vacationLocation;

  set vacationLocation(String value) {
    _vacationLocation = value;
  }

  num get vacationTransactionPeriod => _vacationTransactionPeriod;

  set vacationTransactionPeriod(num value) {
    _vacationTransactionPeriod = value;
  }

  String get vacationTransactionReason => _vacationTransactionReason;

  set vacationTransactionReason(String value) {
    _vacationTransactionReason = value;
  }

  String get startDate => _startDate;

  set startDate(String value) {
    _startDate = value;
  }

  String get endDate => _endDate;

  set endDate(String value) {
    _endDate = value;
  }

  String get vacationPlannedFlag => _vacationPlannedFlag;

  set vacationPlannedFlag(String value) {
    _vacationPlannedFlag = value;
  }

  String get vacationLinkedVacationID => _vacationLinkedVacationID;

  set vacationLinkedVacationID(String value) {
    _vacationLinkedVacationID = value;
  }

  String get vacationRequestChannel => _vacationRequestChannel;

  set vacationRequestChannel(String value) {
    _vacationRequestChannel = value;
  }

  num get vacationHolidayDays => _vacationHolidayDays;

  set vacationHolidayDays(num value) {
    _vacationHolidayDays = value;
  }

  String get vacationRemarks => _vacationRemarks;

  set vacationRemarks(String value) {
    _vacationRemarks = value;
  }

  String get leaveId => _leaveId;

  set leaveId(String value) {
    _leaveId = value;
  }

  String get leaveRequestStatus => _leaveRequestStatus;

  set leaveRequestStatus(String value) {
    _leaveRequestStatus = value;
  }

  String get leaveTransactionStatus => _leaveTransactionStatus;

  set leaveTransactionStatus(String value) {
    _leaveTransactionStatus = value;
  }

  String get leaveApprovedBy => _leaveApprovedBy;

  set leaveApprovedBy(String value) {
    _leaveApprovedBy = value;
  }

  num get leaveStartTime => _leaveStartTime;

  set leaveStartTime(num value) {
    _leaveStartTime = value;
  }

  num get leaveEndTime => _leaveEndTime;

  set leaveEndTime(num value) {
    _leaveEndTime = value;
  }

  String get leaveNotes => _leaveNotes;

  set leaveNotes(String value) {
    _leaveNotes = value;
  }

  String get loanTypes => _loanTypes;

  set loanTypes(String value) {
    _loanTypes = value;
  }

  String get loanStatus => _loanStatus;

  set loanStatus(String value) {
    _loanStatus = value;
  }

  String get loanCurrancy => _loanCurrancy;

  set loanCurrancy(String value) {
    _loanCurrancy = value;
  }

  num get loanAmount => _loanAmount;

  set loanAmount(num value) {
    _loanAmount = value;
  }

  String get loanRequestDate => _loanRequestDate;

  set loanRequestDate(String value) {
    _loanRequestDate = value;
  }

  String get loanPaymentMethod => _loanPaymentMethod;

  set loanPaymentMethod(String value) {
    _loanPaymentMethod = value;
  }

  String get loanInstallmentMethod => _loanInstallmentMethod;

  set loanInstallmentMethod(String value) {
    _loanInstallmentMethod = value;
  }

  String get loanInstallmentStartDate => _loanInstallmentStartDate;

  set loanInstallmentStartDate(String value) {
    _loanInstallmentStartDate = value;
  }

  num get loanApprovedAmount => _loanApprovedAmount;

  set loanApprovedAmount(num value) {
    _loanApprovedAmount = value;
  }

  String get loanPaymentDueDate => _loanPaymentDueDate;

  set loanPaymentDueDate(String value) {
    _loanPaymentDueDate = value;
  }

  String get extraWorkUnit => _extraWorkUnit;

  set extraWorkUnit(String value) {
    _extraWorkUnit = value;
  }

  num get extraWorkUnitQuantity => _extraWorkUnitQuantity;

  set extraWorkUnitQuantity(num value) {
    _extraWorkUnitQuantity = value;
  }

  String get extraWorkDayType => _extraWorkDayType;

  set extraWorkDayType(String value) {
    _extraWorkDayType = value;
  }

  String get extraWorkReason => _extraWorkReason;

  set extraWorkReason(String value) {
    _extraWorkReason = value;
  }

  String get extraWorkPayrollCycle => _extraWorkPayrollCycle;

  set extraWorkPayrollCycle(String value) {
    _extraWorkPayrollCycle = value;
  }

  String get extraWorkRequestDate => _extraWorkRequestDate;

  set extraWorkRequestDate(String value) {
    _extraWorkRequestDate = value;
  }

  String get expenseCurrancy => _expenseCurrancy;

  set expenseCurrancy(String value) {
    _expenseCurrancy = value;
  }

  num get expenseAmount => _expenseAmount;

  set expenseAmount(num value) {
    _expenseAmount = value;
  }

  String get expenseDate => _expenseDate;

  set expenseDate(String value) {
    _expenseDate = value;
  }

  String get expenseRequestDate => _expenseRequestDate;

  set expenseRequestDate(String value) {
    _expenseRequestDate = value;
  }

  num get expenseApprovedAmount => _expenseApprovedAmount;

  set expenseApprovedAmount(num value) {
    _expenseApprovedAmount = value;
  }

  String get documentApprovedDate => _documentApprovedDate;

  set documentApprovedDate(String value) {
    _documentApprovedDate = value;
  }

  String get documentDocumentType => _documentDocumentType;

  set documentDocumentType(String value) {
    _documentDocumentType = value;
  }

  String get documentRequestdate => _documentRequestdate;

  set documentRequestdate(String value) {
    _documentRequestdate = value;
  }

  String get empBenefitApproveDate => _empBenefitApproveDate;

  set empBenefitApproveDate(String value) {
    _empBenefitApproveDate = value;
  }

  String get empBenefitTransStatus => _empBenefitTransStatus;

  set empBenefitTransStatus(String value) {
    _empBenefitTransStatus = value;
  }

  num get empBenefitRequestAmt => _empBenefitRequestAmt;

  set empBenefitRequestAmt(num value) {
    _empBenefitRequestAmt = value;
  }

  String get empBenefitRequestDate => _empBenefitRequestDate;

  set empBenefitRequestDate(String value) {
    _empBenefitRequestDate = value;
  }

  String get empBenefitUnitPrice => _empBenefitUnitPrice;

  set empBenefitUnitPrice(String value) {
    _empBenefitUnitPrice = value;
  }

  num get leaveEncashmentAmount => _leaveEncashmentAmount;

  set leaveEncashmentAmount(num value) {
    _leaveEncashmentAmount = value;
  }

  String get leaveEncashmentLeave => _leaveEncashmentLeave;

  set leaveEncashmentLeave(String value) {
    _leaveEncashmentLeave = value;
  }

  String get leaveEncashmentFromDate => _leaveEncashmentFromDate;

  set leaveEncashmentFromDate(String value) {
    _leaveEncashmentFromDate = value;
  }

  String get leaveEncashmentToDate => _leaveEncashmentToDate;

  set leaveEncashmentToDate(String value) {
    _leaveEncashmentToDate = value;
  }

  String get leaveEncashmentStatus => _leaveEncashmentStatus;

  set leaveEncashmentStatus(String value) {
    _leaveEncashmentStatus = value;
  }

  String get salaryIncRequestDate => _salaryIncRequestDate;

  set salaryIncRequestDate(String value) {
    _salaryIncRequestDate = value;
  }

  String get salaryIncCurrency => _salaryIncCurrency;

  set salaryIncCurrency(String value) {
    _salaryIncCurrency = value;
  }

  String get salaryIncPayCycle => _salaryIncPayCycle;

  set salaryIncPayCycle(String value) {
    _salaryIncPayCycle = value;
  }

  String get salaryIncNote => _salaryIncNote;

  set salaryIncNote(String value) {
    _salaryIncNote = value;
  }

  String get salaryIncSerivecPeriod => _salaryIncSerivecPeriod;

  set salaryIncSerivecPeriod(String value) {
    _salaryIncSerivecPeriod = value;
  }

  num get salaryIncCurrentSalary => _salaryIncCurrentSalary;

  set salaryIncCurrentSalary(num value) {
    _salaryIncCurrentSalary = value;
  }

  num get salaryIncApprovedAmount => _salaryIncApprovedAmount;

  set salaryIncApprovedAmount(num value) {
    _salaryIncApprovedAmount = value;
  }

  String get salaryIncIncrType => _salaryIncIncrType;

  set salaryIncIncrType(String value) {
    _salaryIncIncrType = value;
  }

  num get salaryIncRequestAmount => _salaryIncRequestAmount;

  set salaryIncRequestAmount(num value) {
    _salaryIncRequestAmount = value;
  }

  String get salaryIncRequestStatus => _salaryIncRequestStatus;

  set salaryIncRequestStatus(String value) {
    _salaryIncRequestStatus = value;
  }

  String get salaryIncApprovedBy => _salaryIncApprovedBy;

  set salaryIncApprovedBy(String value) {
    _salaryIncApprovedBy = value;
  }

  String get salaryIncApprovedDate => _salaryIncApprovedDate;

  set salaryIncApprovedDate(String value) {
    _salaryIncApprovedDate = value;
  }

  num get vacationPaidDays => _vacationPaidDays;

  set vacationPaidDays(num value) {
    _vacationPaidDays = value;
  }

  num get vacationUnPaidDays => _vacationUnPaidDays;

  set vacationUnPaidDays(num value) {
    _vacationUnPaidDays = value;
  }

  num get vacationPreviousBalance => _vacationPreviousBalance;

  set vacationPreviousBalance(num value) {
    _vacationPreviousBalance = value;
  }

  num get vacationNewBalance => _vacationNewBalance;

  set vacationNewBalance(num value) {
    _vacationNewBalance = value;
  }

  String get extraWorkPayrollCycleDisplay => _extraWorkPayrollCycleDisplay;

  set extraWorkPayrollCycleDisplay(String value) {
    _extraWorkPayrollCycleDisplay = value;
  }

  String get extraWorkPayrollCycleId => _extraWorkPayrollCycleId;

  set extraWorkPayrollCycleId(String value) {
    _extraWorkPayrollCycleId = value;
  }
}
