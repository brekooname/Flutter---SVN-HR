import 'package:json_annotation/json_annotation.dart';

part 'new_clock_check_request.g.dart';

@JsonSerializable(nullable: false)
class NewClockCheckRequest{
  String tokenID;

  num clockTime;

  String clockType;


  NewClockCheckRequest({this.tokenID, this.clockTime, this.clockType});

  factory NewClockCheckRequest.fromJson(Map<String, dynamic> json) => _$NewClockCheckRequestFromJson(json);


  Map<String, dynamic> toJson() => _$NewClockCheckRequestToJson(this);
}