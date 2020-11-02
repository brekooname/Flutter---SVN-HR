// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_inbox_input_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalInboxInputRequest _$ApprovalInboxInputRequestFromJson(
    Map<String, dynamic> json) {
  return ApprovalInboxInputRequest()
    ..payrolCycle = json['payrolCycle'] as String
    ..installmentAmount = (json['installmentAmount'] as num).toDouble()
    ..paymentDueDate = json['paymentDueDate'] as String
    ..approvedAmount = (json['approvedAmount'] as num).toDouble()
    ..approvedInboxId = json['approvedInboxId'] as String;
}

Map<String, dynamic> _$ApprovalInboxInputRequestToJson(
        ApprovalInboxInputRequest instance) =>
    <String, dynamic>{
      'payrolCycle': instance.payrolCycle,
      'installmentAmount': instance.installmentAmount,
      'paymentDueDate': instance.paymentDueDate,
      'approvedAmount': instance.approvedAmount,
      'approvedInboxId': instance.approvedInboxId,
    };
