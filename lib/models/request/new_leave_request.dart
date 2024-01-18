import 'package:json_annotation/json_annotation.dart';

part 'new_leave_request.g.dart';

@JsonSerializable(nullable: false)
class NewLeaveRequest {

  String? leave_id;

  String? start_date;

  String? end_date;

  String? notes;

  NewLeaveRequest();

  factory NewLeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$NewLeaveRequestFromJson(json);


  Map<String, dynamic> toJson() => _$NewLeaveRequestToJson(this);

}