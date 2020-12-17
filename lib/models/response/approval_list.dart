import 'package:json_annotation/json_annotation.dart';


part 'approval_list.g.dart';

@JsonSerializable(nullable: false)
class ApprovalList{

  String _employeeId;
  String _employeeName;

  ApprovalList();


  factory ApprovalList.fromJson(Map<String, dynamic> json) => _$ApprovalListFromJson(json);


  Map<String, dynamic> toJson() => _$ApprovalListToJson(this);

  String get employeeName => _employeeName;

  set employeeName(String value) {
    _employeeName = value;
  }

  String get employeeId => _employeeId;

  set employeeId(String value) {
    _employeeId = value;
  }
}