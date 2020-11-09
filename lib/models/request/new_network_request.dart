import 'package:json_annotation/json_annotation.dart';

part 'new_network_request.g.dart';

@JsonSerializable(nullable: false)
class NewNetworkRequest {
  String tokenId;

  String connectionName;

  String connectionIP;

  String connectionBSSID;

  NewNetworkRequest(
      {this.tokenId,
      this.connectionName,
      this.connectionIP,
      this.connectionBSSID});

  factory NewNetworkRequest.fromJson(Map<String, dynamic> json) =>
      _$NewNetworkRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NewNetworkRequestToJson(this);
}
