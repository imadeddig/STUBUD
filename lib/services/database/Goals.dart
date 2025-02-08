import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class UserPurposesAndGoalsDB {
  // Create the table
  static Future<void> createUserPurposesAndGoalsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS UserPurposesAndGoals (
        purposeID INTEGER PRIMARY KEY AUTOINCREMENT,
        userID INTEGER NOT NULL,
        purposeDescription TEXT NOT NULL,
        FOREIGN KEY (userID) REFERENCES StudentProfile(userID) ON DELETE CASCADE
      );
    ''');
  }

  // Insert a new purpose/goal for a user
  static Future<int> insertPurposeGoal(int userID, String purposeDescription) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'UserPurposesAndGoals',
        {
          'userID': userID,
          'purposeDescription': purposeDescription,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting purpose/goal for userID $userID: $error');
      return -1; // Return negative value on failure
    }
  }

  // Fetch all purposes/goals for a specific user
  static Future<List<Map<String, dynamic>>> getUserPurposesGoals(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'UserPurposesAndGoals',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while fetching purposes/goals for userID $userID: $error');
      return [];
    }
  }

  // Update a purpose/goal by purposeID
  static Future<int> updatePurposeGoal(int purposeID, String newPurposeDescription) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'UserPurposesAndGoals',
        {'purposeDescription': newPurposeDescription},
        where: 'purposeID = ?',
        whereArgs: [purposeID],
      );
    } catch (error) {
      print('Error occurred while updating purpose/goal with purposeID $purposeID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific purpose/goal by purposeID
  static Future<int> deletePurposeGoal(int purposeID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserPurposesAndGoals',
        where: 'purposeID = ?',
        whereArgs: [purposeID],
      );
    } catch (error) {
      print('Error occurred while deleting purpose/goal with purposeID $purposeID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete all purposes/goals for a specific user
  static Future<int> deletePurposesGoalsByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserPurposesAndGoals',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting purposes/goals for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
}
