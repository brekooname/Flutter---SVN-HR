
import 'package:json_annotation/json_annotation.dart';

part 'salary.g.dart';

@JsonSerializable(nullable: false)
class Salary{

  Salary();

  @JsonKey(name: 'bank_account_id')
  String _bank_account_id;

  @JsonKey(name: 'taxabale_salary')
  double _taxabale_salary;

  @JsonKey(name: 'job_id')
  String _job_id;

  @JsonKey(name: 'job_id_code')
  String _job_id_code;

  @JsonKey(name: 'job_id_displayValue')
  String _job_id_displayValue;

  @JsonKey(name: 'salary_cycle')
  String _salary_cycle;

  @JsonKey(name: 'salary_cycle_code')
  String _salary_cycle_code;

  @JsonKey(name: 'salary_cycle_displayValue')
  String _salary_cycle_displayValue;

  @JsonKey(name: 'net_salary')
  double _net_salary;

  @JsonKey(name: 'original_date_of_hire')
  String _original_date_of_hire;

  @JsonKey(name: 'org_id')
  String _org_id;

  @JsonKey(name: 'hour_base_salary')
  int _hour_base_salary;

  @JsonKey(name: 'retroactive_amt')
  int _retroactive_amt;

  @JsonKey(name: 'hour_value')
  double _hour_value;

  @JsonKey(name: 'updatedate')
  String _updatedate;

  @JsonKey(name: 'exemptions_amt')
  double _exemptions_amt;

  @JsonKey(name: 'unpaid_days_amount')
  double _unpaid_days_amount;

  @JsonKey(name: 'status')
  String _status;

  @JsonKey(name: 'comp_commit_flg')
  String _comp_commit_flg;

  @JsonKey(name: 'loans_value')
  int _loans_value;

  @JsonKey(name: 'permission_method')
  String _permission_method;

  @JsonKey(name: 'tax_amt')
  num _tax_amt;

  @JsonKey(name: 'total_all')
 double _total_all;

  @JsonKey(name: 'effective_end_date')
  String _effective_end_date;

  @JsonKey(name: 'branch_id')
  String _branch_id;

  @JsonKey(name: 'branch_id_code')
  String _branch_id_code;

  @JsonKey(name: 'branch_id_displayValue')
  String _branch_id_displayValue;

  @JsonKey(name: 'extra_wrk_value')
  num _extra_wrk_value;

  @JsonKey(name: 'createdby')
  String _createdby;

  @JsonKey(name: 'total_ded')
  double _total_ded;

  @JsonKey(name: 'paid_amt')
  int _paid_amt;

  @JsonKey(name: 'cycle_close_balance')
  double _cycle_close_balance;

  @JsonKey(name: 'payroll_cycle')
  String _payroll_cycle;

  @JsonKey(name: 'employment_class')
  String _employment_class;

  @JsonKey(name: 'employment_class_code')
  String _employment_class_code;

  @JsonKey(name: 'employment_class_displayValue')
  String _employment_class_displayValue;

  @JsonKey(name: 'bank_commit_flg')
  String _bank_commit_flg;

  @JsonKey(name: 'step_id')
  String _step_id;

  @JsonKey(name: 'step_id_code')
  String _step_id_code;

  @JsonKey(name: 'step_id_displayValue')
  String _step_id_displayValue;

  @JsonKey(name: 'employee_status')
  String _employee_status;

  @JsonKey(name: 'employee_status_code')
  String _employee_status_code;

  @JsonKey(name: 'employee_status_displayValue')
  String _employee_status_displayValue;

  @JsonKey(name: 'gross_salary')
  int _gross_salary;

  @JsonKey(name: 'employment_type')
  String _employment_type;

  @JsonKey(name: 'tax_exempt_id')
  String _tax_exempt_id;

  @JsonKey(name: 'position_id')
  String _position_id;

  @JsonKey(name: 'cycle_days')
  int _cycle_days;

  @JsonKey(name: 'employee_id')
  String _employee_id;

  @JsonKey(name: 'eos_salary')
  int _eos_salary;

  @JsonKey(name: 'shift_type')
  String _shift_type;

  @JsonKey(name: 'shift_type_code')
  String _shift_type_code;

  @JsonKey(name: 'shift_type_displayValue')
  String _shift_type_displayValue;

  @JsonKey(name: 'row_id')
  String _row_id;

  @JsonKey(name: 'day_value')
  double _day_value;

  @JsonKey(name: 'unpaid_days')
  int _unpaid_days;

  @JsonKey(name: 'tax_slice_id')
  String _tax_slice_id;

  @JsonKey(name: 'iban_code')
  String _iban_code;

  @JsonKey(name: 'bank_id')
  String _bank_id;

  @JsonKey(name: 'wrk_days')
  int _wrk_days;

  @JsonKey(name: 'createddate')
  String _createddate;

  @JsonKey(name: 'currency_id')
  String _currency_id;

  @JsonKey(name: 'currency_id_code')
  String _currency_id_code;

  @JsonKey(name: 'currency_id_displayValue')
  String _currency_id_displayValue;

  @JsonKey(name: 'effective_start_date')
  String _effective_start_date;

  @JsonKey(name: 'work_location_id')
  String _work_location_id;

  @JsonKey(name: 'shift_class')
  String _shift_class;

  @JsonKey(name: 'shift_class_code')
  String _shift_class_code;

  @JsonKey(name: 'shift_class_displayValue')
  String _shift_class_displayValue;

  @JsonKey(name: 'paymet_method')
  String _paymet_method;

  @JsonKey(name: 'updatedby')
  String _updatedby;

  @JsonKey(name: 'tax_id')
  String _tax_id;

  @JsonKey(name: 'basic_salary')
  int _basic_salary;

  @JsonKey(name: 'isPosted')
  String _isPosted;

  @JsonKey(name: 'posted_date')
  String _posted_date;

  @JsonKey(name: 'atch_row_id')
  String _batch_row_id;


  String get bank_account_id => _bank_account_id;

  set bank_account_id(String value) {
    _bank_account_id = value;
  }


  double get taxabale_salary => _taxabale_salary;

  set taxabale_salary(double value) {
    _taxabale_salary = value;
  }

  String get job_id => _job_id;

  set job_id(String value) {
    _job_id = value;
  }

  String get job_id_code => _job_id_code;

  set job_id_code(String value) {
    _job_id_code = value;
  }

  String get job_id_displayValue => _job_id_displayValue;

  set job_id_displayValue(String value) {
    _job_id_displayValue = value;
  }

  String get salary_cycle => _salary_cycle;

  set salary_cycle(String value) {
    _salary_cycle = value;
  }

  String get salary_cycle_code => _salary_cycle_code;

  set salary_cycle_code(String value) {
    _salary_cycle_code = value;
  }

  String get salary_cycle_displayValue => _salary_cycle_displayValue;

  set salary_cycle_displayValue(String value) {
    _salary_cycle_displayValue = value;
  }

  double get net_salary => _net_salary;

  set net_salary(double value) {
    _net_salary = value;
  }

  String get original_date_of_hire => _original_date_of_hire;

  set original_date_of_hire(String value) {
    _original_date_of_hire = value;
  }

  String get org_id => _org_id;

  set org_id(String value) {
    _org_id = value;
  }

  int get hour_base_salary => _hour_base_salary;

  set hour_base_salary(int value) {
    _hour_base_salary = value;
  }

  int get retroactive_amt => _retroactive_amt;

  set retroactive_amt(int value) {
    _retroactive_amt = value;
  }

  double get hour_value => _hour_value;

  set hour_value(double value) {
    _hour_value = value;
  }

  String get updatedate => _updatedate;

  set updatedate(String value) {
    _updatedate = value;
  }

  double get exemptions_amt => _exemptions_amt;

  set exemptions_amt(double value) {
    _exemptions_amt = value;
  }

  double get unpaid_days_amount => _unpaid_days_amount;

  set unpaid_days_amount(double value) {
    _unpaid_days_amount = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get comp_commit_flg => _comp_commit_flg;

  set comp_commit_flg(String value) {
    _comp_commit_flg = value;
  }

  int get loans_value => _loans_value;

  set loans_value(int value) {
    _loans_value = value;
  }

  String get permission_method => _permission_method;

  set permission_method(String value) {
    _permission_method = value;
  }

  num get tax_amt => _tax_amt;

  set tax_amt(num value) {
    _tax_amt = value;
  }

  double get total_all => _total_all;

  set total_all(double value) {
    _total_all = value;
  }

  String get effective_end_date => _effective_end_date;

  set effective_end_date(String value) {
    _effective_end_date = value;
  }

  String get branch_id => _branch_id;

  set branch_id(String value) {
    _branch_id = value;
  }

  String get branch_id_code => _branch_id_code;

  set branch_id_code(String value) {
    _branch_id_code = value;
  }

  String get branch_id_displayValue => _branch_id_displayValue;

  set branch_id_displayValue(String value) {
    _branch_id_displayValue = value;
  }

  num get extra_wrk_value => _extra_wrk_value;

  set extra_wrk_value(num value) {
    _extra_wrk_value = value;
  }

  String get createdby => _createdby;

  set createdby(String value) {
    _createdby = value;
  }

  double get total_ded => _total_ded;

  set total_ded(double value) {
    _total_ded = value;
  }

  int get paid_amt => _paid_amt;

  set paid_amt(int value) {
    _paid_amt = value;
  }

  double get cycle_close_balance => _cycle_close_balance;

  set cycle_close_balance(double value) {
    _cycle_close_balance = value;
  }

  String get payroll_cycle => _payroll_cycle;

  set payroll_cycle(String value) {
    _payroll_cycle = value;
  }

  String get employment_class => _employment_class;

  set employment_class(String value) {
    _employment_class = value;
  }

  String get employment_class_code => _employment_class_code;

  set employment_class_code(String value) {
    _employment_class_code = value;
  }

  String get employment_class_displayValue => _employment_class_displayValue;

  set employment_class_displayValue(String value) {
    _employment_class_displayValue = value;
  }

  String get bank_commit_flg => _bank_commit_flg;

  set bank_commit_flg(String value) {
    _bank_commit_flg = value;
  }

  String get step_id => _step_id;

  set step_id(String value) {
    _step_id = value;
  }

  String get step_id_code => _step_id_code;

  set step_id_code(String value) {
    _step_id_code = value;
  }

  String get step_id_displayValue => _step_id_displayValue;

  set step_id_displayValue(String value) {
    _step_id_displayValue = value;
  }

  String get employee_status => _employee_status;

  set employee_status(String value) {
    _employee_status = value;
  }

  String get employee_status_code => _employee_status_code;

  set employee_status_code(String value) {
    _employee_status_code = value;
  }

  String get employee_status_displayValue => _employee_status_displayValue;

  set employee_status_displayValue(String value) {
    _employee_status_displayValue = value;
  }

  int get gross_salary => _gross_salary;

  set gross_salary(int value) {
    _gross_salary = value;
  }

  String get employment_type => _employment_type;

  set employment_type(String value) {
    _employment_type = value;
  }

  String get tax_exempt_id => _tax_exempt_id;

  set tax_exempt_id(String value) {
    _tax_exempt_id = value;
  }

  String get position_id => _position_id;

  set position_id(String value) {
    _position_id = value;
  }

  int get cycle_days => _cycle_days;

  set cycle_days(int value) {
    _cycle_days = value;
  }

  String get employee_id => _employee_id;

  set employee_id(String value) {
    _employee_id = value;
  }

  int get eos_salary => _eos_salary;

  set eos_salary(int value) {
    _eos_salary = value;
  }

  String get shift_type => _shift_type;

  set shift_type(String value) {
    _shift_type = value;
  }

  String get shift_type_code => _shift_type_code;

  set shift_type_code(String value) {
    _shift_type_code = value;
  }

  String get shift_type_displayValue => _shift_type_displayValue;

  set shift_type_displayValue(String value) {
    _shift_type_displayValue = value;
  }

  String get row_id => _row_id;

  set row_id(String value) {
    _row_id = value;
  }

  double get day_value => _day_value;

  set day_value(double value) {
    _day_value = value;
  }

  int get unpaid_days => _unpaid_days;

  set unpaid_days(int value) {
    _unpaid_days = value;
  }

  String get tax_slice_id => _tax_slice_id;

  set tax_slice_id(String value) {
    _tax_slice_id = value;
  }

  String get iban_code => _iban_code;

  set iban_code(String value) {
    _iban_code = value;
  }

  String get bank_id => _bank_id;

  set bank_id(String value) {
    _bank_id = value;
  }

  int get wrk_days => _wrk_days;

  set wrk_days(int value) {
    _wrk_days = value;
  }

  String get createddate => _createddate;

  set createddate(String value) {
    _createddate = value;
  }

  String get currency_id => _currency_id;

  set currency_id(String value) {
    _currency_id = value;
  }

  String get currency_id_code => _currency_id_code;

  set currency_id_code(String value) {
    _currency_id_code = value;
  }

  String get currency_id_displayValue => _currency_id_displayValue;

  set currency_id_displayValue(String value) {
    _currency_id_displayValue = value;
  }

  String get effective_start_date => _effective_start_date;

  set effective_start_date(String value) {
    _effective_start_date = value;
  }

  String get work_location_id => _work_location_id;

  set work_location_id(String value) {
    _work_location_id = value;
  }

  String get shift_class => _shift_class;

  set shift_class(String value) {
    _shift_class = value;
  }

  String get shift_class_code => _shift_class_code;

  set shift_class_code(String value) {
    _shift_class_code = value;
  }

  String get shift_class_displayValue => _shift_class_displayValue;

  set shift_class_displayValue(String value) {
    _shift_class_displayValue = value;
  }

  String get paymet_method => _paymet_method;

  set paymet_method(String value) {
    _paymet_method = value;
  }

  String get updatedby => _updatedby;

  set updatedby(String value) {
    _updatedby = value;
  }

  String get tax_id => _tax_id;

  set tax_id(String value) {
    _tax_id = value;
  }

  int get basic_salary => _basic_salary;

  set basic_salary(int value) {
    _basic_salary = value;
  }

  String get isPosted => _isPosted;

  set isPosted(String value) {
    _isPosted = value;
  }

  String get posted_date => _posted_date;

  set posted_date(String value) {
    _posted_date = value;
  }

  String get batch_row_id => _batch_row_id;

  set batch_row_id(String value) {
    _batch_row_id = value;
  }

  factory Salary.fromJson(Map<String, dynamic> json) => _$SalaryFromJson(json);


  Map<String, dynamic> toJson() => _$SalaryToJson(this);


}