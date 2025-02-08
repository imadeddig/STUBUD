import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class UserPreferredStudyMethodsDB {
  // Create the table
  static Future<void> createUserPreferredStudyMethodsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS UserPreferredStudyMethods (
        studyMethodID INTEGER PRIMARY KEY AUTOINCREMENT,
        userID INTEGER NOT NULL,
        studyMethod TEXT NOT NULL,
        FOREIGN KEY (userID) REFERENCES StudentProfile(userID) ON DELETE CASCADE
      );
    ''');
  }

  // Insert a new study method for a user
  static Future<int> insertStudyMethod(int userID, String studyMethod) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'UserPreferredStudyMethods',
        {
          'userID': userID,
          'studyMethod': studyMethod,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting study method for userID $userID: $error');
      return -1; // Return negative value on failure
    }
  }

  // Fetch all study methods for a specific user
  static Future<List<Map<String, dynamic>>> getUserStudyMethods(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'UserPreferredStudyMethods',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while fetching study methods for userID $userID: $error');
      return [];
    }
  }

  // Update a study method by studyMethodID
  static Future<int> updateStudyMethod(int studyMethodID, String newStudyMethod) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'UserPreferredStudyMethods',
        {'studyMethod': newStudyMethod},
        where: 'studyMethodID = ?',
        whereArgs: [studyMethodID],
      );
    } catch (error) {
      print('Error occurred while updating study method with studyMethodID $studyMethodID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific study method by studyMethodID
  static Future<int> deleteStudyMethod(int studyMethodID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserPreferredStudyMethods',
        where: 'studyMethodID = ?',
        whereArgs: [studyMethodID],
      );
    } catch (error) {
      print('Error occurred while deleting study method with studyMethodID $studyMethodID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete all study methods for a specific user
  static Future<int> deleteStudyMethodsByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserPreferredStudyMethods',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting study methods for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
}
