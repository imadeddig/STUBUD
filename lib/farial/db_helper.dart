import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class UserProfileDatabaseHelper {
  static final UserProfileDatabaseHelper _instance = UserProfileDatabaseHelper._internal();
  factory UserProfileDatabaseHelper() => _instance;

  static Database? _database;

  UserProfileDatabaseHelper._internal();
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'user_profile.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE userProfile(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT,
            fullName TEXT,
            profilePicPath TEXT
          )
        ''');
      },
    );
  }
  Future<void> insertOrUpdateUserProfile({
    required String username,
    required String email,
    required String fullName,
    required String profilePicPath,
  }) async {
    final db = await database;
    var result = await db.query(
      'userProfile',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isEmpty) {
      await db.insert('userProfile', {
        'username': username,
        'email': email,
        'fullName': fullName,
        'profilePicPath': profilePicPath,
      });
    } else {
      await db.update(
        'userProfile',
        {
          'email': email,
          'fullName': fullName,
          'profilePicPath': profilePicPath,
        },
        where: 'username = ?',
        whereArgs: [username],
      );
    }
  }
  Future<Map<String, String?>> getUserProfile() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('userProfile');

    if (result.isNotEmpty) {
      return {
        'username': result.first['username'],
        'email': result.first['email'],
        'fullName': result.first['fullName'],
        'profilePicPath': result.first['profilePicPath'],
      };
    }

    return {};
  }
}
