import 'package:json_annotation/json_annotation.dart';

import 'base_request.dart';

part 'notification_close_request.g.dart';

@JsonSerializable(nullable: false)
class NotificationCloseRequest{

  String tokenId;
  String notifId;

  NotificationCloseRequest({this.tokenId, this.notifId});

  factory NotificationCloseRequest.fromJson(Map<String, dynamic> json) => _$NotificationCloseRequestFromJson(json);


  Map<String, dynamic> toJson() => _$NotificationCloseRequestToJson(this);
}