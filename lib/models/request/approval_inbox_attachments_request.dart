import 'package:json_annotation/json_annotation.dart';


part 'approval_inbox_attachments_request.g.dart';

@JsonSerializable(nullable: false)
class ApprovalInboxAttachmentsRequest{

  String token_id ;
  String approval_inbox_row_id;


  ApprovalInboxAttachmentsRequest({this.token_id, this.approval_inbox_row_id});

  factory ApprovalInboxAttachmentsRequest.fromJson(Map<String, dynamic> json) => _$ApprovalInboxAttachmentsRequestFromJson(json);


  Map<String, dynamic> toJson() => _$ApprovalInboxAttachmentsRequestToJson(this);
}