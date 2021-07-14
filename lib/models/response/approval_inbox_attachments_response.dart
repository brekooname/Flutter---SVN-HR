import 'package:json_annotation/json_annotation.dart';

part 'approval_inbox_attachments_response.g.dart';

@JsonSerializable(nullable: false)
class ApprovalInboxAttachmentsResponse {
  ApprovalInboxAttachmentsResponse();

  factory ApprovalInboxAttachmentsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ApprovalInboxAttachmentsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ApprovalInboxAttachmentsResponseToJson(this);

  @JsonKey(name: 'attachment_rowId')
  String _attachment_rowId;

  @JsonKey(name: 'attachment_name')
  String _attachment_name;

  String get attachment_rowId => _attachment_rowId;

  set attachment_rowId(String value) {
    _attachment_rowId = value;
  }

  String get attachment_name => _attachment_name;

  set attachment_name(String value) {
    _attachment_name = value;
  }
}
