// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Salary _$SalaryFromJson(Map<String, dynamic> json) {
  return Salary()
    ..bank_account_id = json['bank_account_id'] as String
    ..taxabale_salary = (json['taxabale_salary'] as num).toDouble()
    ..job_id = json['job_id'] as String
    ..job_id_code = json['job_id_code'] as String
    ..job_id_displayValue = json['job_id_displayValue'] as String
    ..salary_cycle = json['salary_cycle'] as String
    ..salary_cycle_code = json['salary_cycle_code'] as String
    ..salary_cycle_displayValue = json['salary_cycle_displayValue'] as String
    ..net_salary = (json['net_salary'] as num).toDouble()
    ..original_date_of_hire = json['original_date_of_hire'] as String
    ..org_id = json['org_id'] as String
    ..hour_base_salary = json['hour_base_salary'] as int
    ..retroactive_amt = json['retroactive_amt'] as int
    ..hour_value = (json['hour_value'] as num).toDouble()
    ..updatedate = json['updatedate'] as String
    ..exemptions_amt = (json['exemptions_amt'] as num).toDouble()
    ..unpaid_days_amount = json['unpaid_days_amount'] as int
    ..status = json['status'] as String
    ..comp_commit_flg = json['comp_commit_flg'] as String
    ..loans_value = json['loans_value'] as int
    ..permission_method = json['permission_method'] as String
    ..tax_amt = json['tax_amt'] as int
    ..total_all = (json['total_all'] as num).toDouble()
    ..effective_end_date = json['effective_end_date'] as String
    ..branch_id = json['branch_id'] as String
    ..branch_id_code = json['branch_id_code'] as String
    ..branch_id_displayValue = json['branch_id_displayValue'] as String
    ..extra_wrk_value = json['extra_wrk_value'] as int
    ..createdby = json['createdby'] as String
    ..total_ded = (json['total_ded'] as num).toDouble()
    ..paid_amt = json['paid_amt'] as int
    ..cycle_close_balance = (json['cycle_close_balance'] as num).toDouble()
    ..payroll_cycle = json['payroll_cycle'] as String
    ..employment_class = json['employment_class'] as String
    ..employment_class_code = json['employment_class_code'] as String
    ..employment_class_displayValue =
        json['employment_class_displayValue'] as String
    ..bank_commit_flg = json['bank_commit_flg'] as String
    ..step_id = json['step_id'] as String
    ..step_id_code = json['step_id_code'] as String
    ..step_id_displayValue = json['step_id_displayValue'] as String
    ..employee_status = json['employee_status'] as String
    ..employee_status_code = json['employee_status_code'] as String
    ..employee_status_displayValue =
        json['employee_status_displayValue'] as String
    ..gross_salary = json['gross_salary'] as int
    ..employment_type = json['employment_type'] as String
    ..tax_exempt_id = json['tax_exempt_id'] as String
    ..position_id = json['position_id'] as String
    ..cycle_days = json['cycle_days'] as int
    ..employee_id = json['employee_id'] as String
    ..eos_salary = json['eos_salary'] as int
    ..shift_type = json['shift_type'] as String
    ..shift_type_code = json['shift_type_code'] as String
    ..shift_type_displayValue = json['shift_type_displayValue'] as String
    ..row_id = json['row_id'] as String
    ..day_value = (json['day_value'] as num).toDouble()
    ..unpaid_days = json['unpaid_days'] as int
    ..tax_slice_id = json['tax_slice_id'] as String
    ..iban_code = json['iban_code'] as String
    ..bank_id = json['bank_id'] as String
    ..wrk_days = json['wrk_days'] as int
    ..createddate = json['createddate'] as String
    ..currency_id = json['currency_id'] as String
    ..currency_id_code = json['currency_id_code'] as String
    ..currency_id_displayValue = json['currency_id_displayValue'] as String
    ..effective_start_date = json['effective_start_date'] as String
    ..work_location_id = json['work_location_id'] as String
    ..shift_class = json['shift_class'] as String
    ..shift_class_code = json['shift_class_code'] as String
    ..shift_class_displayValue = json['shift_class_displayValue'] as String
    ..paymet_method = json['paymet_method'] as String
    ..updatedby = json['updatedby'] as String
    ..tax_id = json['tax_id'] as String
    ..basic_salary = json['basic_salary'] as int
    ..isPosted = json['isPosted'] as String
    ..posted_date = json['posted_date'] as String
    ..batch_row_id = json['batch_row_id'] as String;
}

Map<String, dynamic> _$SalaryToJson(Salary instance) => <String, dynamic>{
      'bank_account_id': instance.bank_account_id,
      'taxabale_salary': instance.taxabale_salary,
      'job_id': instance.job_id,
      'job_id_code': instance.job_id_code,
      'job_id_displayValue': instance.job_id_displayValue,
      'salary_cycle': instance.salary_cycle,
      'salary_cycle_code': instance.salary_cycle_code,
      'salary_cycle_displayValue': instance.salary_cycle_displayValue,
      'net_salary': instance.net_salary,
      'original_date_of_hire': instance.original_date_of_hire,
      'org_id': instance.org_id,
      'hour_base_salary': instance.hour_base_salary,
      'retroactive_amt': instance.retroactive_amt,
      'hour_value': instance.hour_value,
      'updatedate': instance.updatedate,
      'exemptions_amt': instance.exemptions_amt,
      'unpaid_days_amount': instance.unpaid_days_amount,
      'status': instance.status,
      'comp_commit_flg': instance.comp_commit_flg,
      'loans_value': instance.loans_value,
      'permission_method': instance.permission_method,
      'tax_amt': instance.tax_amt,
      'total_all': instance.total_all,
      'effective_end_date': instance.effective_end_date,
      'branch_id': instance.branch_id,
      'branch_id_code': instance.branch_id_code,
      'branch_id_displayValue': instance.branch_id_displayValue,
      'extra_wrk_value': instance.extra_wrk_value,
      'createdby': instance.createdby,
      'total_ded': instance.total_ded,
      'paid_amt': instance.paid_amt,
      'cycle_close_balance': instance.cycle_close_balance,
      'payroll_cycle': instance.payroll_cycle,
      'employment_class': instance.employment_class,
      'employment_class_code': instance.employment_class_code,
      'employment_class_displayValue': instance.employment_class_displayValue,
      'bank_commit_flg': instance.bank_commit_flg,
      'step_id': instance.step_id,
      'step_id_code': instance.step_id_code,
      'step_id_displayValue': instance.step_id_displayValue,
      'employee_status': instance.employee_status,
      'employee_status_code': instance.employee_status_code,
      'employee_status_displayValue': instance.employee_status_displayValue,
      'gross_salary': instance.gross_salary,
      'employment_type': instance.employment_type,
      'tax_exempt_id': instance.tax_exempt_id,
      'position_id': instance.position_id,
      'cycle_days': instance.cycle_days,
      'employee_id': instance.employee_id,
      'eos_salary': instance.eos_salary,
      'shift_type': instance.shift_type,
      'shift_type_code': instance.shift_type_code,
      'shift_type_displayValue': instance.shift_type_displayValue,
      'row_id': instance.row_id,
      'day_value': instance.day_value,
      'unpaid_days': instance.unpaid_days,
      'tax_slice_id': instance.tax_slice_id,
      'iban_code': instance.iban_code,
      'bank_id': instance.bank_id,
      'wrk_days': instance.wrk_days,
      'createddate': instance.createddate,
      'currency_id': instance.currency_id,
      'currency_id_code': instance.currency_id_code,
      'currency_id_displayValue': instance.currency_id_displayValue,
      'effective_start_date': instance.effective_start_date,
      'work_location_id': instance.work_location_id,
      'shift_class': instance.shift_class,
      'shift_class_code': instance.shift_class_code,
      'shift_class_displayValue': instance.shift_class_displayValue,
      'paymet_method': instance.paymet_method,
      'updatedby': instance.updatedby,
      'tax_id': instance.tax_id,
      'basic_salary': instance.basic_salary,
      'isPosted': instance.isPosted,
      'posted_date': instance.posted_date,
      'batch_row_id': instance.batch_row_id,
    };
