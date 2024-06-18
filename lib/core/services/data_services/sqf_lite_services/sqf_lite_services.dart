import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:waiters_app/app/common/constants/texts/app_texts.dart';

class SqfLiteServices {
  Database? _database;

  SqfLiteServices._();

  static final SqfLiteServices instance = SqfLiteServices._();

  Future<void> init() async {
    // Initialize the _database
    if (_database != null) return; // If already initialized, return

    final path = await _getPath();

    _database = await _openDatabase(path);
  }

  Future<String> _getPath() async {
    final databasePath = await getDatabasesPath();
    return join(databasePath, AppTexts.cafeDb);
  }

  Future<Database> _openDatabase(String path) async {
    return await openDatabase(
      path,
      version: 2, // Increment the version number since you are modifying the table structure
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE waiters(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
        );
        await db.execute(
          'CREATE TABLE orders(id TEXT PRIMARY KEY, tableNumber INTEGER, drinks TEXT, firstMeals TEXT, mainMeals TEXT, waiterId INTEGER, totalPrice INTEGER, FOREIGN KEY (waiterId) REFERENCES waiters(id))', // Add totalPrice column
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        // Implement the migration logic to update the table schema here (if needed)
      },
    );
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    _checkIfDatabaseInited();
    return await _database!.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    _checkIfDatabaseInited();
    return await _database!.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> data, String where, List<dynamic> whereArgs) async {
    _checkIfDatabaseInited();
    return await _database!.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String table, String where, List<dynamic> whereArgs) async {
    _checkIfDatabaseInited();
    return await _database!.delete(table, where: where, whereArgs: whereArgs);
  }

  void _checkIfDatabaseInited() {
    if (_database == null) {
      // Handle the case where the database hasn't been initialized yet
      throw StateError('Database is not initialized. Please call initDatabase() first.');
    }
  }
}
