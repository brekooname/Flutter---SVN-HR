
import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/lov_values.dart';

part 'lov_value_response.g.dart';

@JsonSerializable(nullable: false)
class LovValuesResponse{


  @JsonKey(name: 'response')
  String? response;

  @JsonKey(name: 'lovs')
  List<LovValues>? lovs;

  @JsonKey(name: 'err_MSG')
  String? err_MSG;

  factory LovValuesResponse.fromJson(Map<String, dynamic> json) => _$LovValuesResponseFromJson(json);


  Map<String, dynamic> toJson() => _$LovValuesResponseToJson(this);

  LovValuesResponse();
}

