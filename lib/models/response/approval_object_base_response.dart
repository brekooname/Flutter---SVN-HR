import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/base_request.dart';

import 'approval_object_response.dart';

part 'approval_object_base_response.g.dart';

@JsonSerializable(nullable: false)
class ApprovalObjectBaseResponse{

  factory ApprovalObjectBaseResponse.fromJson(Map<String, dynamic> json) => _$ApprovalObjectBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ApprovalObjectBaseResponseToJson(this);

  @JsonKey(name: 'response')
  String _response;

  @JsonKey(name: 'approvalInboxObject')
  ApprovalObjectResponse _approvalInboxObject;

  @JsonKey(name: 'err_MSG')
  String _err_MSG;

  ApprovalObjectBaseResponse();

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }

  ApprovalObjectResponse get approvalInboxObject => _approvalInboxObject;

  set approvalInboxObject(ApprovalObjectResponse value) {
    _approvalInboxObject = value;
  }

  String get response => _response;

  set response(String value) {
    _response = value;
  }
}