import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/new_leave_request.dart';


part 'new_leave_base_request.g.dart';

@JsonSerializable(nullable: false)
class NewLeaveBaseRequest{

  String  tokenID;

  NewLeaveRequest leaveTrans;

  factory NewLeaveBaseRequest.fromJson(Map<String, dynamic> json) => _$NewLeaveBaseRequestFromJson(json);


  Map<String, dynamic> toJson() => _$NewLeaveBaseRequestToJson(this);

  NewLeaveBaseRequest({this.tokenID, this.leaveTrans});
}