import 'package:json_annotation/json_annotation.dart';

part 'new_password_request.g.dart';

@JsonSerializable(nullable: false)
class NewPasswordRequest{

  String tokenID;
  String oldPassword;
  String newPassword;
  String repatedPassword;

  NewPasswordRequest({
      this.tokenID, this.oldPassword, this.newPassword, this.repatedPassword});

  factory NewPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$NewPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NewPasswordRequestToJson(this);
}