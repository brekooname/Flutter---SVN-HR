import 'package:json_annotation/json_annotation.dart';

part 'new_location_request.g.dart';

@JsonSerializable(nullable: false)
class NewLocationRequest {
  String tokenId;

  String latitude;

  String longitude;

  String locationName;

  num locationRange;

  NewLocationRequest(
      {this.tokenId,
      this.latitude,
      this.longitude,
      this.locationName,
      this.locationRange});

  factory NewLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$NewLocationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NewLocationRequestToJson(this);
}
