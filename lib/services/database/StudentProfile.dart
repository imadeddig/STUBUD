import 'package:sqflite/sqflite.dart';
import 'db_helper.dart'; 

class StudentProfileDB {
  static Future<List<Map<String, dynamic>>> getStudentProfiles() async {
    try {
      final database = await DBHelper.getDatabase();
      final List<Map<String, dynamic>> studentProfiles = await database.query('StudentProfile');
      return studentProfiles;
    } catch (error) {
      print('Error occurred while fetching student profiles: $error');
      return [];
    }
  }

  static Future<int> insertStudentProfile(Map<String, dynamic> profile) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'StudentProfile',
        profile,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting student profile: $error');
      return -1;
    }
  }

  static Future<int> updateStudentProfile(int userID, Map<String, dynamic> profile) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'StudentProfile',
        profile,
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while updating student profile with ID $userID: $error');
      return 0;
    }
  }

  static Future<int> deleteStudentProfile(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'StudentProfile',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting student profile with ID $userID: $error');
      return 0;
    }
  }

 static Future<int?> getCurrentUserID(String email) async {
  if (email.isEmpty) {
    throw ArgumentError('Email cannot be empty');
  }

  try {
    final database = await DBHelper.getDatabase();
    final result = await database.query(
      'StudentProfile',
      columns: ['userID'],
      where: 'email = ? OR username = ?',
      whereArgs: [email, email],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['userID'] as int?;
    }
    return null;
  } catch (error) {
    return null;
  }
}


  static Future<Map<String, dynamic>?> getStudentProfileByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      final result = await database.query(
        'StudentProfile',
        where: 'userID = ?',
        whereArgs: [userID],
        limit: 1,
      );

      if (result.isNotEmpty) {
        return result.first;  
      } else {
        return null;  
      }
    } catch (error) {
      print('Error fetching student profile with ID $userID: $error');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getUserByEmailOrUsername(String emailOrUsername) async {
    try {
      final db = await DBHelper.getDatabase();
      final result = await db.query(
        'StudentProfile',
        where: 'email = ? OR username = ?',
        whereArgs: [emailOrUsername, emailOrUsername],
        limit: 1, 
      );

      if (result.isNotEmpty) {
        return result.first;  
      } else {
        return null;  
      }
    } catch (error) {
      print('Error fetching user by email or username: $error');
      return null;
    }
  }

  static Future<bool> doesUsernameExist(String username) async {
  try {
    final db = await DBHelper.getDatabase();
    final result = await db.query(
      'StudentProfile',
      where: 'username = ?',
      whereArgs: [username],
      limit: 1, 
    );


    return result.isNotEmpty;
  } catch (error) {
    print('Error checking if username exists: $error');
    return false;
  }
}

}
