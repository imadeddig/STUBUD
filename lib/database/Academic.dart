import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class UserAcademicStrengthsDB {
  // Create the table
  static Future<void> createUserAcademicStrengthsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS UserAcademicStrengths (
        strengthID INTEGER PRIMARY KEY AUTOINCREMENT,
        userID INTEGER NOT NULL,
        academicStrength TEXT NOT NULL,
        FOREIGN KEY (userID) REFERENCES StudentProfile(userID) ON DELETE CASCADE
      );
    ''');
  }

  // Insert a new academic strength for a user
  static Future<int> insertAcademicStrength(int userID, String academicStrength) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'UserAcademicStrengths',
        {
          'userID': userID,
          'academicStrength': academicStrength,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting academic strength for userID $userID: $error');
      return -1; // Return negative value on failure
    }
  }

  // Fetch all academic strengths for a specific user
  static Future<List<Map<String, dynamic>>> getUserAcademicStrengths(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'UserAcademicStrengths',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while fetching academic strengths for userID $userID: $error');
      return [];
    }
  }

  // Update an academic strength by strengthID
  static Future<int> updateAcademicStrength(int strengthID, String newAcademicStrength) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'UserAcademicStrengths',
        {'academicStrength': newAcademicStrength},
        where: 'strengthID = ?',
        whereArgs: [strengthID],
      );
    } catch (error) {
      print('Error occurred while updating academic strength with strengthID $strengthID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific academic strength by strengthID
  static Future<int> deleteAcademicStrength(int strengthID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserAcademicStrengths',
        where: 'strengthID = ?',
        whereArgs: [strengthID],
      );
    } catch (error) {
      print('Error occurred while deleting academic strength with strengthID $strengthID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete all academic strengths for a specific user
  static Future<int> deleteAcademicStrengthsByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserAcademicStrengths',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting academic strengths for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
}
