import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User{
  final String username;
  String password;
  bool netsuitFlag;


  User({this.username, this.password, this.netsuitFlag});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);


  Map<String, dynamic> toJson() => _$UserToJson(this);
}