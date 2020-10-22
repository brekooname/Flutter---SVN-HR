
import 'package:json_annotation/json_annotation.dart';

import 'base_request.dart';

part 'get_approval_object_request.g.dart';

@JsonSerializable(nullable: false)
class GetApprovalObjectRequest{

  BaseRequest tokenWrapper;

  String par_row_id;


  GetApprovalObjectRequest({this.tokenWrapper, this.par_row_id});

  factory GetApprovalObjectRequest.fromJson(Map<String, dynamic> json) => _$GetApprovalObjectRequestFromJson(json);


  Map<String, dynamic> toJson() => _$GetApprovalObjectRequestToJson(this);
}