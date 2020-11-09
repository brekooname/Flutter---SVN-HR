// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_network_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewNetworkRequest _$NewNetworkRequestFromJson(Map<String, dynamic> json) {
  return NewNetworkRequest(
    tokenId: json['tokenId'] as String,
    connectionName: json['connectionName'] as String,
    connectionIP: json['connectionIP'] as String,
    connectionBSSID: json['connectionBSSID'] as String,
  );
}

Map<String, dynamic> _$NewNetworkRequestToJson(NewNetworkRequest instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'connectionName': instance.connectionName,
      'connectionIP': instance.connectionIP,
      'connectionBSSID': instance.connectionBSSID,
    };
