import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A service class that handles local database operations using SQFLite.
///
/// This class implements the singleton pattern to maintain a single database instance 
/// throughout the application's lifecycle. It provides methods to initialize the database,
/// and perform CRUD operations on the `user` table.
class DbService {
  // Singleton instance of DbService.
  static final DbService _instance = DbService._internal();

  /// Factory constructor that returns the singleton instance of [DbService].
  factory DbService() => _instance;

  // Private variable to hold the database instance.
  static Database? _database;

  /// Private named constructor for implementing the singleton pattern.
  DbService._internal();

  /// Provides access to the SQFLite [Database] instance.
  ///
  /// If the database is not already initialized, it will call [_initDatabase] to create it.
  /// Returns a [Future] that resolves to the initialized [Database] instance.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initializes the SQFLite database.
  ///
  /// Retrieves the default database path, constructs the database file path, and opens the database.
  /// The [onCreate] callback is used to set up the initial database schema.
  ///
  /// Returns a [Future] that resolves to an instance of [Database].
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'myapp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Callback method to create the initial database schema.
  ///
  /// This method is executed when the database is created for the first time.
  /// It creates the `user` table with the columns: [id], [email], and [token].
  ///
  /// [db] - The database instance.
  /// [version] - The version number of the database.
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        token TEXT
      )
    ''');
  }

  /// Inserts or updates a user record in the database.
  ///
  /// If a record with the same primary key exists, it is replaced with the new data.
  ///
  /// [email] - The user's email address.
  /// [token] - The authentication token associated with the user.
  ///
  /// Returns a [Future] that completes when the operation is finished.
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

  /// Retrieves the first user record from the database.
  ///
  /// Queries the `user` table and returns the first record as a map of column names to values.
  /// Returns `null` if no user record is found.
  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  /// Deletes all user records from the database.
  ///
  /// Removes user record(s) from the `user` table.
  ///
  /// Returns a [Future] that completes when the deletion is finished.
  Future<void> deleteUser() async {
    final db = await database;
    await db.delete('user');
  }
}
