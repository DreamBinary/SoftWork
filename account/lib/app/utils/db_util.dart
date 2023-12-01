import 'package:sqflite/sqflite.dart';

class DBUtil {
  static DBUtil? _instance;
  static Database? _database;
  static String _databaseName = "account.db";

  factory DBUtil() {
    if (_instance == null) {
      return DBUtil._init();
    } else {
      return _instance!;
    }
  }

  DBUtil._init() {
    _init();
  }

  Future<void> _init() async {
    if (_database == null) {
      var dbPath = await getDatabasesPath();
      var path = dbPath + _databaseName;
      _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    }
  }

  Future _onCreate(Database db, int version) async {
    // String favoriteSQL =
    // '''
    //   CREATE TABLE $favoriteTable(
    //   $doubanId TEXT PRIMARY KEY,
    //   $_moviePoster TEXT,
    //   $_movieName TEXT,
    //   $_movieCountry TEXT,
    //   $_movieLanguage TEXT,
    //   $_movieGenre TEXT,
    //   $_movieDescription TEXT
    //   )
    //   ''';
    //
    // String searchSQL =
    // '''
    //   CREATE TABLE $searchTable(
    //   $searchKey TEXT PRIMARY KEY
    //   )
    //   ''';
    //
    // await db.execute(favoriteSQL);
    // await db.execute(searchSQL);
  }

  // insert
  Future<int> insert(String table, Map<String, dynamic> values) async {
    return await _database!.insert(table, values);
  }

  // delete
  Future<int> delete(
      String table, String where, List<dynamic> whereArgs) async {
    return await _database!.delete(table, where: where, whereArgs: whereArgs);
  }

  // update
  Future<int> update(String table, Map<String, dynamic> values, String where,
      List<dynamic> whereArgs) async {
    return await _database!
        .update(table, values, where: where, whereArgs: whereArgs);
  }

  // query
  Future<List<Map<String, dynamic>>> query(String table,
      {bool distinct = false,
      List<String>? columns,
      String? where,
      List<dynamic>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) async {
    return await _database!.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  // close
  Future<void> close() async {
    await _database!.close();
    _database = null;
  }

  // isOpen
  bool isOpen() {
    return _database!.isOpen;
  }
}
