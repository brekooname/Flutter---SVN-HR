
import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';

@JsonSerializable(nullable: false)
class BaseRequest{
  String? tokenID;


  BaseRequest({this.tokenID});

  factory BaseRequest.fromJson(Map<String, dynamic> json) => _$BaseRequestFromJson(json);


  Map<String, dynamic> toJson() => _$BaseRequestToJson(this);
}