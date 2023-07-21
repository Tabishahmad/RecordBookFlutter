import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If the database instance is null, initialize it
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'my_database.db');

    // Create and open the database
    return await openDatabase(dbPath, version: 1, onCreate: _createDatabase);
  }

  static void _createDatabase(Database db, int version) async {
    // Create your table with columns: datetime, item name, item price
    await db.execute('''
      CREATE TABLE my_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        datetime TEXT NOT NULL,
        item_name TEXT NOT NULL,
        item_price REAL NOT NULL
      )
    ''');
  }

  // Insert data into the database
  static Future<int> insertData(String datetime, String itemName, double itemPrice) async {
    Database db = await database;
    Map<String, dynamic> row = {
      'datetime': datetime,
      'item_name': itemName,
      'item_price': itemPrice,
    };
    return await db.insert('my_table', row);
  }

  // Fetch all data from the database
  static Future<List<Map<String, dynamic>>> fetchData() async {
    Database db = await database;
    return await db.query('my_table');
  }
}
