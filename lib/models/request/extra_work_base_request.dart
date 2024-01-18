import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/extra_work_request.dart';

part 'extra_work_base_request.g.dart';

@JsonSerializable(nullable: false)
class ExtraWorkBaseRequest{
  String? tokenID;
  ExtraWorkRequest? extraWorkTrans;


  ExtraWorkBaseRequest({this.tokenID, this.extraWorkTrans});

  factory ExtraWorkBaseRequest.fromJson(Map<String, dynamic> json) =>
      _$ExtraWorkBaseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraWorkBaseRequestToJson(this);
}