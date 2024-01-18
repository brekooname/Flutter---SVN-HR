// database table and column names
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sven_hr/utilities/database_helpers.dart';

final String tableName = 'LOV_VALUE';
String col_row_id = 'row_id';
final String col_code = 'lov_code';
final String col_display = 'display_value';
final String col_parent = 'parent_lov';

final List<String> columns = [col_row_id, col_code, col_display, col_parent];

class LovValue {
  String? _row_id;
  String? _code;
  String? _parent;
  String? _display;
  // not database columns
  bool isSelected=false;

  DatabaseHelper? helper;

  LovValue() {
    helper = DatabaseHelper.instance;
  }


  set row_id(String value) {
    _row_id = value;
  }

  String get row_id => _row_id!;

  String get code => _code!;

  String get display => _display!;

  String get parent => _parent!;

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (_row_id != null) {
      map[col_row_id] = _row_id;
    } else {
      print('Warning: _row_id is null in toMap');
    }

    if (_code != null) {
      map[col_code] = _code;
    } else {
      print('Warning: _code is null in toMap');
    }

    if (_display != null) {
      map[col_display] = _display;
    } else {
      print('Warning: _display is null in toMap');
    }

    if (_parent != null) {
      map[col_parent] = _parent;
    } else {
      print('Warning: _parent is null in toMap');
    }

    return map;
  }


  // convenience constructor to create a Word object
  LovValue.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      print('Error: Map is null in LovValue.fromMap');
      // Initialize with default values
      _row_id = 'default_row_id';
      _code = 'default_code';
      _display = 'default_display';
      _parent = 'default_parent';
      return;
    }

    print('map - fromMap LovValue - '+map.toString());

    _row_id = map[col_row_id] as String? ?? 'default_row_id';
    _code = map[col_code] as String? ?? 'default_code';
    _display = map[col_display] as String? ?? 'default_display';
    _parent = map[col_parent] as String? ?? 'default_parent';
  }


  List<LovValue> fromLListMap(List<Map>? map) {
    List<LovValue> list = [];
    for (Map? item in map!) {
      // Cast each map item to Map<String, dynamic>
      LovValue? value = LovValue.fromMap(item!.cast<String, dynamic>());
      list.add(value);
    }
    return list;
  }


  Future<int> delete() async {
    try {
      Database? db = await helper!.database; // Ensure database is initialized
      if (db != null) {
        int id = await db.delete(tableName);
        print('Deleted old LovValues successfully');
        return id;
      } else {
        print('Error: Database is not initialized');
        return -1; // Indicates an error
      }
    } catch (e) {
      print('Error deleting old LovValues1: $e');
      return -1; // Indicates an error
    }
  }



  Future<void> insert(LovValue value) async {
    if (value == null) {
      print('Error: Attempted to insert a null LovValue');
      return;
    }

    try {
      var map = value.toMap();
      print('Attempting to insert LovValue with map: $map');
      Database? db = await helper!.database; // Await the database here

      if (map.isNotEmpty) {
        await db!.insert(tableName, map); // Use the 'db' variable for the insert operation
      } else {
        print('Error: Map is empty during insertion of LovValue');
      }
    } catch (e) {
      print('Error inserting LovValue: $e');
    }
  }
  Future<List<LovValue>?> getLovsByParentId(String id) async {
    String where = col_parent + "=?";
    List<String> whereArgs = [id];
    List<Map>? maps =
        await helper!.queryWhereList(tableName, columns, where, whereArgs);
    if (maps!.length > 0) {
      return fromLListMap(maps);
    }
    return null;
  }

  Future<LovValue?> getLovsByRowId(String id) async {
    String where = col_row_id + "=?";
    List<String> whereArgs = [id];
    List<Map>? maps =
    await helper!.queryWhereList(tableName, columns, where, whereArgs);
    if (maps != null && maps.isNotEmpty) {
      // Cast the first map item to Map<String, dynamic>
      return LovValue.fromMap(maps.first.cast<String, dynamic>());
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
