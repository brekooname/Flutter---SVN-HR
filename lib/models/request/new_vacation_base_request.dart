import 'package:sven_hr/models/request/new_vacation_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_vacation_base_request.g.dart';

@JsonSerializable(nullable: false)
class NewVacationBaseRequest{
  String? tokenID;
  NewVacationRequest? vac;

  NewVacationBaseRequest({this.tokenID, this.vac});

  factory NewVacationBaseRequest.fromJson(Map<String, dynamic> json) => _$NewVacationBaseRequestFromJson(json);


  Map<String, dynamic> toJson() => _$NewVacationBaseRequestToJson(this);

}