import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user.dart';

class Tuser {
  static final Tuser _instance = Tuser._internal();
  static Database? _database;

  final String tableName = 'user';
  final String columnId = 'id';
  final String columnEmail = 'email';
  final String columnPassword = 'password';

  Tuser._internal();
  factory Tuser() => _instance;
  Future<Database?> get _db  async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }
  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnEmail TEXT,"
        "$columnPassword TEXT)";
    await db.execute(sql);
  }
  Future<int?> saveUser(User user) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, user.toMap());
  }
  Future<List?> getAllUser() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnEmail,
      columnPassword,
    ]);
    return result.toList();
  }
  Future<int?> updateUser(User user) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, user.toMap(), where: '$columnId = ?', whereArgs: [user.id]);
  }
  Future<int?> deleteUser(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<List<Map<String, dynamic>>?> findUser(String? email) async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName,
        where: '$columnEmail ==?',
        whereArgs: ['$email'],
        columns: [
          columnId,
          columnEmail,
          columnPassword,
        ]);
    return result.toList();
  }
}