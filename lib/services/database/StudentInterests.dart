import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class UserInterestsDB {
  // Fetch all interests for a specific user
  static Future<List<Map<String, dynamic>>> getUserInterests(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'UserInterests',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while fetching interests for userID $userID: $error');
      return [];
    }
  }

  // Insert a new interest for a user
  static Future<int> insertUserInterest(int userID, String interest) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'UserInterests',
        {
          'userID': userID,
          'interest': interest,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting interest for userID $userID: $error');
      return -1; // Return negative value on failure
    }
  }

  // Update an interest by interestID
  static Future<int> updateUserInterest(int interestID, String newInterest) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'UserInterests',
        {'interest': newInterest},
        where: 'interestID = ?',
        whereArgs: [interestID],
      );
    } catch (error) {
      print('Error occurred while updating interest with interestID $interestID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific interest by interestID
  static Future<int> deleteUserInterest(int interestID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserInterests',
        where: 'interestID = ?',
        whereArgs: [interestID],
      );
    } catch (error) {
      print('Error occurred while deleting interest with interestID $interestID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete all interests for a specific user (optional, useful for explicit deletion if needed)
  static Future<int> deleteInterestsByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserInterests',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting interests for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
}
