import 'package:json_annotation/json_annotation.dart';
import 'package:sven_hr/models/response/project_list_response.dart';


part 'project_list_base_response.g.dart';

@JsonSerializable(nullable: false)
class ProjectListBaseResponse{

  ProjectListBaseResponse();


  factory ProjectListBaseResponse.fromJson(Map<String, dynamic> json) => _$ProjectListBaseResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ProjectListBaseResponseToJson(this);


  @JsonKey(name: 'projectListTransactions')
  List<ProjectListResponse> _projectListTransactions;

  @JsonKey(name: 'err_MSG')
  String _err_MSG;


  List<ProjectListResponse> get projectListTransactions =>
      _projectListTransactions;

  set projectListTransactions(List<ProjectListResponse> value) {
    _projectListTransactions = value;
  }

  String get err_MSG => _err_MSG;

  set err_MSG(String value) {
    _err_MSG = value;
  }
}