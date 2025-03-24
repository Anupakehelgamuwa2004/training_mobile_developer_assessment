import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static final DbService _instance = DbService._internal();
  factory DbService() => _instance;

  static Database? _database;

  DbService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'myapp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        token TEXT
      )
    ''');
  }

  // Example: Insert or update user
  Future<void> saveUser(String email, String token) async {
    final db = await database;
    await db.insert(
      'user',
      {
        'email': email,
        'token': token,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Example: Retrieve user
  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Example: Delete user
  Future<void> deleteUser() async {
    final db = await database;
    await db.delete('user');
  }
}
