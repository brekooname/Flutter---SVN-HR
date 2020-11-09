// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_location_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewLocationRequest _$NewLocationRequestFromJson(Map<String, dynamic> json) {
  return NewLocationRequest(
    tokenId: json['tokenId'] as String,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    locationName: json['locationName'] as String,
    locationRange: json['locationRange'] as num,
  );
}

Map<String, dynamic> _$NewLocationRequestToJson(NewLocationRequest instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'locationName': instance.locationName,
      'locationRange': instance.locationRange,
    };
