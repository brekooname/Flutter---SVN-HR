import 'package:json_annotation/json_annotation.dart';

part 'profile_screen_response.g.dart';

@JsonSerializable(nullable: false)
class ProfileScreenResponse{
  @JsonKey(name: 'screenName')
  String? _screenName;

  @JsonKey(name: 'displayFlag')
  bool? _displayFlag;

  ProfileScreenResponse();

  bool get displayFlag => _displayFlag!;

  set displayFlag(bool value) {
    _displayFlag = value;
  }

  String get screenName => _screenName!;

  set screenName(String value) {
    _screenName = value;
  }


  factory ProfileScreenResponse.fromJson(Map<String, dynamic> json) => _$ProfileScreenResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ProfileScreenResponseToJson(this);
}