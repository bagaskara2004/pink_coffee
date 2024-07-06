import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pink_coffee/model/product.dart';

class Tproduct {
  static final Tproduct _instance = Tproduct._internal();
  static Database? _database;

  final String tableName = 'myproduct';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnPrice = 'price';
  final String columnDescription = 'description';
  final String columnPhoto = 'photo';
  final String columnKategori = 'kategori';
  final String columnRekomended = 'rekomended';

  Tproduct._internal();
  factory Tproduct() => _instance;
  Future<Database?> get _db  async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }
  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'myproduct.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnPrice TEXT,"
        "$columnDescription TEXT,"
        "$columnPhoto TEXT,"
        "$columnKategori TEXT,"
        "$columnRekomended TEXT)";
    await db.execute(sql);
  }
  Future<int?> saveProduct(Product product) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, product.toMap());
  }
  Future<List?> getAllProduct() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnPrice,
      columnDescription,
      columnPhoto,
      columnKategori,
      columnRekomended
    ]);
    return result.toList();
  }
  Future<int?> updateProduct(Product product) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, product.toMap(), where: '$columnId = ?', whereArgs: [product.id]);
  }
  Future<int?> deleteProduct(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<List<Map<String, dynamic>>?> searchProductByName(String? name) async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName,
        where: '$columnName LIKE ?',
        whereArgs: ['%$name%'],
        columns: [
          columnId,
          columnName,
          columnPrice,
          columnDescription,
          columnPhoto,
          columnKategori,
          columnRekomended
        ]);
    return result.toList();
  }
}