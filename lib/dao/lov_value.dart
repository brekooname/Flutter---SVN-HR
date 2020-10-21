// database table and column names
import 'package:sqflite/sqflite.dart';
import 'package:sven_hr/utilities/database_helpers.dart';

final String tableName = 'LOV_VALUE';
String col_row_id = 'row_id';
final String col_code = 'lov_code';
final String col_display = 'display_value';
final String col_parent = 'parent_lov';

final List<String> columns = [col_row_id, col_code, col_display, col_parent];

class LovValue {
  String _row_id;
  String _code;
  String _parent;
  String _display;
  // not database columns
  bool isSelected=false;

  DatabaseHelper helper;

  LovValue() {
    helper = DatabaseHelper.instance;
  }


  set row_id(String value) {
    _row_id = value;
  }

  String get row_id => _row_id;

  String get code => _code;

  String get display => _display;

  String get parent => _parent;

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      col_code: _code,
      col_display: _display,
      col_parent: _parent,
      col_row_id: _row_id
    };
    // if (col_row_id != null) {
    //   map[col_row_id] = _row_id;
    // }
    return map;
  }

  // convenience constructor to create a Word object
    LovValue.fromMap(Map<String, dynamic> map) {
    // col_row_id = 'row_Id';
    // print( map["row_Id"]);
    // print(map[col_code]);
    _row_id = map[col_row_id];
    _code = map[col_code];
    _display = map[col_display];
    _parent = map[col_parent];
  }

  List<LovValue> fromLListMap(List<Map> map) {
    List<LovValue> list = List();
    for (Map item in map) {
      LovValue value = LovValue.fromMap(item);
      list.add(value);
    }
    return list;
  }

  Future<int> delete() async {
    int id = await helper.delete(tableName);
    return id;
  }

  Future<void> insert(LovValue value) async {
    await helper.insert(tableName, value.toMap());
    // return id;
  }

  Future<List<LovValue>> getLovsByParentId(String id) async {
    String where = col_parent + "=?";
    List<String> whereArgs = [id];
    List<Map> maps =
        await helper.queryWhereList(tableName, columns, where, whereArgs);
    if (maps != null && maps.length > 0) {
      return fromLListMap(maps);
    }
    return null;
  }

  Future<LovValue> getLovsByRowId(String id) async {
    String where = col_row_id + "=?";
    List<String> whereArgs = [id];
    List<Map> maps =
        await helper.queryWord(tableName, columns, where, whereArgs);
    if (maps != null && maps.length > 0) {
      return LovValue.fromMap(maps.first);
    }
    return null;
  }

  set code(String value) {
    _code = value;
  }

  set parent(String value) {
    _parent = value;
  }

  set display(String value) {
    _display = value;
  }
}
