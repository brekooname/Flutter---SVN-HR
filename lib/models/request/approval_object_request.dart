
import 'package:json_annotation/json_annotation.dart';

import 'base_request.dart';

part 'approval_object_request.g.dart';

@JsonSerializable(nullable: false)
class ApprovalObjectRequest{

  BaseRequest? tokenWrapper;

  String? par_row_id;


  ApprovalObjectRequest({this.tokenWrapper, this.par_row_id});

  factory ApprovalObjectRequest.fromJson(Map<String, dynamic> json) => _$ApprovalObjectRequestFromJson(json);


  Map<String, dynamic> toJson() => _$ApprovalObjectRequestToJson(this);
}