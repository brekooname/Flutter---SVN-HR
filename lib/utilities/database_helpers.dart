import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "hr_sven.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }


  // open the database
  // _initDatabase() async {
  //   // The path_provider plugin gets the right directory for Android or iOS.
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, _databaseName);
  //
  //   if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
  //     // Load database from asset and copy
  //     ByteData data = await rootBundle.load(join('assets/database', _databaseName));
  //     List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //     // Save copied asset to documents
  //     await new File(path).writeAsBytes(bytes);
  //   }
  //   // Open the database. Can also add an onUpdate callback parameter.
  //   return await openDatabase(path,
  //       password: "1111",
  //       readOnly: false,
  //       version: _databaseVersion,);
  // }

  _initDatabase() async {
    try {
      // Construct a file path to copy database to
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);

      dynamic filepattt = FileSystemEntity.typeSync(path);
// Only copy if the database doesn't exist
      if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
        // Load database from asset and copy
        ByteData data =
            await rootBundle.load(join('assets/database', _databaseName));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Save copied asset to documents
        await new File(path).writeAsBytes(bytes, flush: true);
      }

      // Directory appDocDir = await getApplicationDocumentsDirectory();
      // String databasePath = join(appDocDir.path, _databaseName);
      // Open the database. Can also add an onUpdate callback parameter.
      return await openDatabase(
        path,
        version: _databaseVersion,
      );
    } catch (e) {
      print(e);
    }
  }

  // SQL string to create the database
  // Future _onCreate(Database db, int version) async {
  //   await db.execute('''
  //             CREATE TABLE $tableWords (
  //               $columnId INTEGER PRIMARY KEY,
  //               $columnWord TEXT NOT NULL,
  //               $columnFrequency INTEGER NOT NULL
  //             )
  //             ''');
  // }

  // Database helper methods:

  Future<void> insert(String tableName, Map<String, Object?> map) async {
    // Check for null values in the map
    if (map.containsValue(null)) {
      print('Error: Map contains null values. Map: $map');
      return;
    }

    try {
      // Ensure the database instance is not null
      Database? db = await database;
      if (db == null) {
        print('Error: Database instance is null.');
        return;
      }

      // Log before attempting to insert
      print('Attempting to insert into $tableName: $map');
      await db.insert(tableName, map);
      print('Successfully inserted into $tableName');
    } catch (e) {
      print('Error during insertion into $tableName: $e');
    }
  }


  Future<dynamic> queryWord(String tableName, List<String> columns,
      String where, List<dynamic> whereArgs) async {
    Database? db = await database;
    List<Map> maps = await db!.transaction((txn) => txn.query(tableName,
        columns: columns, where: where, whereArgs: whereArgs));
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  Future<List<Map>?> queryWhereList(String tableName, List<String> columns,
      String where, List<dynamic> whereArgs) async {
    Database? db = await database;
    List<Map> maps = await db!.query(tableName,
        columns: columns, where: where, whereArgs: whereArgs);
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<List<Map>?> queryAllList(String tableName, List<String> columns) async {
    Database? db = await database;
    List<Map> maps = await db!.query(tableName,
        columns: columns);
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<int> delete(String tableName) async {
    Database? db = await database;
    int id = await db!.transaction((txn) => txn.delete(tableName));
    return id;
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}
