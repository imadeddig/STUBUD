import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class UserValuesDB {
  // Fetch all values for a specific user
  static Future<List<Map<String, dynamic>>> getUserValues(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'UserValues',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while fetching values for userID $userID: $error');
      return [];
    }
  }

  // Insert a new value for a user
  static Future<int> insertUserValue(int userID, String valueName) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'UserValues',
        {
          'userID': userID,
          'valueName': valueName,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting value for userID $userID: $error');
      return -1; // Return negative value on failure
    }
  }

  // Update a value by valueID
  static Future<int> updateUserValue(int valueID, String newValueName) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'UserValues',
        {'valueName': newValueName},
        where: 'valueID = ?',
        whereArgs: [valueID],
      );
    } catch (error) {
      print('Error occurred while updating value with valueID $valueID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific value by valueID
  static Future<int> deleteUserValue(int valueID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserValues',
        where: 'valueID = ?',
        whereArgs: [valueID],
      );
    } catch (error) {
      print('Error occurred while deleting value with valueID $valueID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete all values for a specific user (optional, useful for explicit deletion if needed)
  static Future<int> deleteValuesByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserValues',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting values for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
}
