import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/base_request.dart';

import 'get_approval_object_response.dart';

part 'get_approval_object_base_response.g.dart';

@JsonSerializable(nullable: false)
class GetApprovalObjectBaseResponse{

  factory GetApprovalObjectBaseResponse.fromJson(Map<String, dynamic> json) => _$GetApprovalObjectBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$GetApprovalObjectBaseResponseToJson(this);

  @JsonKey(name: 'response')
  String _response;

  @JsonKey(name: 'approvalInboxObject')
  GetApprovalObjectResponse _approvalInboxObject;

  @JsonKey(name: 'err_MSG')
  String _err_MSG;

  GetApprovalObjectBaseResponse();

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }

  GetApprovalObjectResponse get approvalInboxObject => _approvalInboxObject;

  set approvalInboxObject(GetApprovalObjectResponse value) {
    _approvalInboxObject = value;
  }

  String get response => _response;

  set response(String value) {
    _response = value;
  }
}