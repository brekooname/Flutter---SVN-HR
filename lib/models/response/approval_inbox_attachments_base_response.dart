import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/approval_inbox_attachments_response.dart';

part 'approval_inbox_attachments_base_response.g.dart';

@JsonSerializable(nullable: false)
class ApprovalInboxAttachmentsBaseResponse {


  ApprovalInboxAttachmentsBaseResponse();

  factory ApprovalInboxAttachmentsBaseResponse.fromJson(Map<String, dynamic> json) => _$ApprovalInboxAttachmentsBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ApprovalInboxAttachmentsBaseResponseToJson(this);

  @JsonKey(name: 'response')
  String _response;

  @JsonKey(name: 'listOfAttachments')
  List<ApprovalInboxAttachmentsResponse> _listOfAttachments;

  @JsonKey(name: 'err_MSG')
  String _err_MSG;

  String get response => _response;

  set response(String value) {
    _response = value;
  }


  List<ApprovalInboxAttachmentsResponse> get listOfAttachments =>
      _listOfAttachments;

  set listOfAttachments(List<ApprovalInboxAttachmentsResponse> value) {
    _listOfAttachments = value;
  }

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}