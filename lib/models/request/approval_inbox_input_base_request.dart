import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/approval_inbox_input_request.dart';


part 'approval_inbox_input_base_request.g.dart';

@JsonSerializable(nullable: false)
class ApprovalInboxInputBaseRequest{

  String tokenId ;
  ApprovalInboxInputRequest approvalObject;


   ApprovalInboxInputBaseRequest({this.tokenId, this.approvalObject});

  factory ApprovalInboxInputBaseRequest.fromJson(Map<String, dynamic> json) => _$ApprovalInboxInputBaseRequestFromJson(json);


  Map<String, dynamic> toJson() => _$ApprovalInboxInputBaseRequestToJson(this);
}