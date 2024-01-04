import 'package:sneaker_shop_app/models/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final String databaseName = "app_database.db";

  static const String userTable = "users";
  static const String profileTable = "profiles";

  String users = '''
    CREATE TABLE $userTable (
      userId INTEGER PRIMARY KEY AUTOINCREMENT,
      userName TEXT UNIQUE,
      userPassword TEXT
    )
  ''';

  String profiles = '''
    CREATE TABLE $profileTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userName TEXT UNIQUE,
      fullName TEXT,
      email TEXT
    )
  ''';

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(users);
        await db.execute(profiles);
      },
    );
  }

  Future<int> signup(Users user) async {
    final Database db = await initDB();
    return await db.insert(userTable, user.toMap());
  }

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
      "SELECT * FROM $userTable WHERE userName = ? AND userPassword = ?",
      [user.userName, user.userPassword],
    );

    return result.isNotEmpty;
  }

  getUserByUsername(String userName) {}

}

