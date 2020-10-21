
import 'package:json_annotation/json_annotation.dart';
part 'lov_value_request.g.dart';

@JsonSerializable(nullable: false)
class LovValuesRequest{
 final String tokenID;
  String lovID;

 LovValuesRequest({this.tokenID});

 factory LovValuesRequest.fromJson(Map<String, dynamic> json) => _$LovValuesRequestFromJson(json);


 Map<String, dynamic> toJson() => _$LovValuesRequestToJson(this);
}