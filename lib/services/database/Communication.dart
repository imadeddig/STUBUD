import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class UserCommunicationMethodsDB {
  // Create the table
  static Future<void> createUserCommunicationMethodsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS UserCommunicationMethods (
        communicationID INTEGER PRIMARY KEY AUTOINCREMENT,
        userID INTEGER NOT NULL,
        communicationMethod TEXT NOT NULL,
        FOREIGN KEY (userID) REFERENCES StudentProfile(userID) ON DELETE CASCADE
      );
    ''');
  }

  // Insert a new communication method for a user
  static Future<int> insertCommunicationMethod(int userID, String communicationMethod) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'UserCommunicationMethods',
        {
          'userID': userID,
          'communicationMethod': communicationMethod,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting communication method for userID $userID: $error');
      return -1; // Return negative value on failure
    }
  }

  // Fetch all communication methods for a specific user
  static Future<List<Map<String, dynamic>>> getUserCommunicationMethods(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'UserCommunicationMethods',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while fetching communication methods for userID $userID: $error');
      return [];
    }
  }

  // Update a communication method by communicationID
  static Future<int> updateCommunicationMethod(int communicationID, String newCommunicationMethod) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'UserCommunicationMethods',
        {'communicationMethod': newCommunicationMethod},
        where: 'communicationID = ?',
        whereArgs: [communicationID],
      );
    } catch (error) {
      print('Error occurred while updating communication method with communicationID $communicationID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific communication method by communicationID
  static Future<int> deleteCommunicationMethod(int communicationID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserCommunicationMethods',
        where: 'communicationID = ?',
        whereArgs: [communicationID],
      );
    } catch (error) {
      print('Error occurred while deleting communication method with communicationID $communicationID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete all communication methods for a specific user
  static Future<int> deleteCommunicationMethodsByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserCommunicationMethods',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting communication methods for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
}
