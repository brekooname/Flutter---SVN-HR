import 'package:json_annotation/json_annotation.dart';


part 'approval_inbox_input_request.g.dart';

@JsonSerializable(nullable: false)
class ApprovalInboxInputRequest{

   String? _approvedInboxId;
   double? _approvedAmount;
   String? _paymentDueDate;
   double? _installmentAmount;
   String? _payrolCycle;

   ApprovalInboxInputRequest();

   factory ApprovalInboxInputRequest.fromJson(Map<String, dynamic> json) => _$ApprovalInboxInputRequestFromJson(json);


   Map<String, dynamic> toJson() => _$ApprovalInboxInputRequestToJson(this);

   String get payrolCycle => _payrolCycle!;

  set payrolCycle(String value) {
    _payrolCycle = value;
  }

  double get installmentAmount => _installmentAmount!;

  set installmentAmount(double value) {
    _installmentAmount = value;
  }

  String get paymentDueDate => _paymentDueDate!;

  set paymentDueDate(String value) {
    _paymentDueDate = value;
  }

  double get approvedAmount => _approvedAmount!;

  set approvedAmount(double value) {
    _approvedAmount = value;
  }

  String get approvedInboxId => _approvedInboxId!;

  set approvedInboxId(String value) {
    _approvedInboxId = value;
  }
}