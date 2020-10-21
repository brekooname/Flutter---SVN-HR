import 'package:json_annotation/json_annotation.dart';

import 'approval_inbox_list_response.dart';

part 'approval_inbox_list_base_response.g.dart';

@JsonSerializable(nullable: false)
class ApprovalInboxListBaseResponse {


  ApprovalInboxListBaseResponse();

  factory ApprovalInboxListBaseResponse.fromJson(Map<String, dynamic> json) => _$ApprovalInboxListBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ApprovalInboxListBaseResponseToJson(this);

  @JsonKey(name: 'response')
  String _response;

  @JsonKey(name: 'listOfApprovals')
  List<ApprovalInboxListResponse> _listOfApprovals;

  @JsonKey(name: 'err_MSG')
  String _err_MSG;

  String get response => _response;

  set response(String value) {
    _response = value;
  }

  List<ApprovalInboxListResponse> get listOfApprovals => _listOfApprovals;

  set listOfApprovals(List<ApprovalInboxListResponse> value) {
    _listOfApprovals = value;
  }

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}