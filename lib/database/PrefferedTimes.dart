import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class UserPreferredStudyTimesDB {
  // Fetch all preferred study times for a specific user
  static Future<List<Map<String, dynamic>>> getStudyTimesByUser(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'UserPreferredStudyTimes',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while fetching study times for userID $userID: $error');
      return [];
    }
  }

  // Insert a new study time preference for a user
  static Future<int> insertStudyTime(int userID, String studyTimeCategory) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'UserPreferredStudyTimes',
        {
          'userID': userID,
          'studyTimeCategory': studyTimeCategory,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting study time for userID $userID: $error');
      return -1; // Return negative value on failure
    }
  }

  // Update a study time preference by studyTimeID
  static Future<int> updateStudyTime(int studyTimeID, String newStudyTimeCategory) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'UserPreferredStudyTimes',
        {'studyTimeCategory': newStudyTimeCategory},
        where: 'studyTimeID = ?',
        whereArgs: [studyTimeID],
      );
    } catch (error) {
      print('Error occurred while updating study time with studyTimeID $studyTimeID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific study time preference by studyTimeID
  static Future<int> deleteStudyTime(int studyTimeID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserPreferredStudyTimes',
        where: 'studyTimeID = ?',
        whereArgs: [studyTimeID],
      );
    } catch (error) {
      print('Error occurred while deleting study time with studyTimeID $studyTimeID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete all study time preferences for a specific user (optional, for explicit control)
  static Future<int> deleteStudyTimesByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserPreferredStudyTimes',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting study times for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
}
