import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/request/user_verification_request.dart';

part 'user_verification_base_request.g.dart';

@JsonSerializable(nullable: false)
class UserVerificationBaseRequest{
  String tokenId;
  UserVerificationRequest userVerificationRequest;


  UserVerificationBaseRequest({this.tokenId, this.userVerificationRequest});

  factory UserVerificationBaseRequest.fromJson(Map<String, dynamic> json) => _$UserVerificationBaseRequestFromJson(json);


  Map<String, dynamic> toJson() => _$UserVerificationBaseRequestToJson(this);

}