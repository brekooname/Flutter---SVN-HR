import 'package:json_annotation/json_annotation.dart';

part 'user_verification_request.g.dart';

@JsonSerializable(nullable: false)
class UserVerificationRequest{
   String? _userLat;

   String? _userLang;

   String? _userMacAddress;

   String? _userNetworkBSSID;


   UserVerificationRequest();

  String get userLat => _userLat!;

  set userLat(String value) {
    _userLat = value;
  }

  factory UserVerificationRequest.fromJson(Map<String, dynamic> json) => _$UserVerificationRequestFromJson(json);


  Map<String, dynamic> toJson() => _$UserVerificationRequestToJson(this);

   String get userLang => _userLang!;

  set userLang(String value) {
    _userLang = value;
  }

   String get userMacAddress => _userMacAddress!;

  set userMacAddress(String value) {
    _userMacAddress = value;
  }

   String get userNetworkBSSID => _userNetworkBSSID!;

  set userNetworkBSSID(String value) {
    _userNetworkBSSID = value;
  }
}