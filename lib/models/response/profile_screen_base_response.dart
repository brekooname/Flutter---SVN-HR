import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/profile_screen_response.dart';

part 'profile_screen_base_response.g.dart';

@JsonSerializable(nullable: false)
class ProfileScreenBaseResponse{
  @JsonKey(name: 'response')
  String? _response;

  @JsonKey(name: 'err_MSG')
  String? _err_MSG;

  @JsonKey(name: 'listOfAllScreensDisplay')
  List<ProfileScreenResponse>? _listOfAllScreensDisplay;


  ProfileScreenBaseResponse();


  String get response => _response!;

  set response(String value) {
    _response = value;
  }

  factory ProfileScreenBaseResponse.fromJson(Map<String, dynamic> json) => _$ProfileScreenBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ProfileScreenBaseResponseToJson(this);

  String get err_MSG => _err_MSG!;

  set err_MSG(String value) {
    _err_MSG = value;
  }

  List<ProfileScreenResponse> get listOfAllScreensDisplay =>
      _listOfAllScreensDisplay!;

  set listOfAllScreensDisplay(List<ProfileScreenResponse> value) {
    _listOfAllScreensDisplay = value;
  }
}