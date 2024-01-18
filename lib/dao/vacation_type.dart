import 'package:sven_hr/utilities/database_helpers.dart';

final String tableName = 'Vacation_Type';

final String col_name = 'name';
final String col_approval_flg = 'approval_flg';
final String col_createddate = 'createddate';
final String col_balance_sign = 'balance_sign';

final String col_balance_sign_displayValue = 'balance_sign_displayValue';
final String col_balance_sign_code = 'balance_sign_code';
final String col_active_flg = 'active_flg';
final String col_updatedby = 'updatedby';

final String col_row_id = 'row_id';
final String col_permission_method = 'permission_method';
final String col_description = 'description';
final String col_createdby = 'createdby';
final String col_updatedate = 'updatedate';
final String col_default_balance = 'default_balance';

final List<String> columns = [
  col_name,
  col_approval_flg,
  col_createddate,
  col_balance_sign,
  col_balance_sign_displayValue,
  col_balance_sign_code,
  col_active_flg,
  col_updatedby,
  col_row_id,
  col_permission_method,
  col_description,
  col_createdby,
  col_updatedate,
  col_default_balance
];

class VacationType {

  String? _name;
  String? _approval_flg;
  String? _createddate;
  String? _balance_sign;
  String? _balance_sign_displayValue;
  String? _balance_sign_code;
  String? _active_flg;
  String? _updatedby;
  String? _row_id;
  String? _permission_method;
  String? _description;
  String? _createdby;
  String? _updatedate;
  num? _default_balance;
  // not database columns
  bool isSelected=false;
  DatabaseHelper? helper;

  VacationType(){
    helper = DatabaseHelper.instance;
  }

  num get default_balance => _default_balance!;

  set default_balance(num value) {
    _default_balance = value;
  }

  String get updatedate => _updatedate!;

  set updatedate(String value) {
    _updatedate = value;
  }

  String get createdby => _createdby!;

  set createdby(String value) {
    _createdby = value;
  }

  String get description => _description!;

  set description(String value) {
    _description = value;
  }

  String get permission_method => _permission_method!;

  set permission_method(String value) {
    _permission_method = value;
  }

  String get row_id => _row_id!;

  set row_id(String value) {
    _row_id = value;
  }

  String get updatedby => _updatedby!;

  set updatedby(String value) {
    _updatedby = value;
  }

  String get active_flg => _active_flg!;

  set active_flg(String value) {
    _active_flg = value;
  }

  String get balance_sign_code => _balance_sign_code!;

  set balance_sign_code(String value) {
    _balance_sign_code = value;
  }

  String get balance_sign_displayValue => _balance_sign_displayValue!;

  set balance_sign_displayValue(String value) {
    _balance_sign_displayValue = value;
  }

  String get balance_sign => _balance_sign!;

  set balance_sign(String value) {
    _balance_sign = value;
  }

  String get createddate => _createddate!;

  set createddate(String value) {
    _createddate = value;
  }

  String get approval_flg => _approval_flg!;

  set approval_flg(String value) {
    _approval_flg = value;
  }

  String get name => _name!;

  set name(String value) {
    _name = value;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      col_name: _name,
      col_approval_flg: _active_flg,
      col_createddate: createddate,
      col_balance_sign: _balance_sign,
      col_balance_sign_displayValue: _balance_sign_displayValue,
      col_balance_sign_code: _balance_sign_code,
      col_active_flg: _active_flg,
      col_updatedby: _updatedby,
      col_row_id: _row_id,
      col_permission_method: _permission_method,
      col_description: _description,
      col_createdby: _createdby,
      col_updatedate: _updatedate,
      col_default_balance: _default_balance,

    };
    // if (col_row_id != null) {
    //   map[col_row_id] = _row_id;
    // }
    return map;
  }

  // convenience constructor to create a Word object
  VacationType.fromMap(Map<String, dynamic> map) {
    _row_id = map[col_row_id];
    _name = map[col_name];
    _approval_flg = map[col_approval_flg];
    _createddate = map[col_createddate];
    _balance_sign = map[col_balance_sign];
    _balance_sign_displayValue = map[col_balance_sign_displayValue];
    _balance_sign_code = map[col_balance_sign_code];
    _active_flg= map[col_active_flg];
    _updatedby = map[col_updatedby];
    _permission_method = map[col_permission_method];
    _description = map[col_description];
    _createdby = map[col_createdby];
    _updatedate = map[col_updatedate];
    _default_balance = map[col_default_balance];

  }

  List<VacationType> fromLListMap(List<Map>? map) {
    List<VacationType> list = [];
    for (Map item in map!) {
      // Cast each map item to Map<String, dynamic>
      VacationType value = VacationType.fromMap(item.cast<String, dynamic>());
      list.add(value);
    }
    return list;
  }


  Future<int> delete() async {
    int id = await helper!.delete(tableName);
    return id;
  }

  Future<void> insert(VacationType value) async {
    if (value == null) {
      print('Error: Attempted to insert a null VacationType');
      return;
    }

    // Check if helper is null
    if (helper == null) {
      print('Error: Database helper is null');
      return;
    }

    try {
      var map = value.toMap();
      if (map.isEmpty) {
        print('Error: Map is empty during insertion of VacationType');
        return;
      }

      // Log the map data for debugging
      print('Inserting VacationType with map: $map');
      await helper!.insert(tableName, map);
      print('Successfully inserted VacationType');
    } catch (e) {
      print('Error inserting VacationType: $e');
    }
  }


  Future<List<VacationType>?> getAllVacationsType() async {
    List<Map>? maps =
    await helper!.queryAllList(tableName, columns);
    if (maps!.length > 0) {
      return fromLListMap(maps);
    }
    return null;
  }

  Future<VacationType?> getLovsByRowId(String id) async {
    String where = col_row_id + "=?";
    List<String> whereArgs = [id];
    List<Map> maps =
    await helper!.queryWord(tableName, columns, where, whereArgs);
    if (maps.isNotEmpty) {
      // Cast the first map item to Map<String, dynamic>
      return VacationType.fromMap(maps.first.cast<String, dynamic>());
    }
    return null;
  }

}
