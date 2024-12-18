import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class UserLanguagesDB {
  // Fetch all languages for a specific user
  static Future<List<Map<String, dynamic>>> getUserLanguages(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'UserLanguages',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while fetching languages for userID $userID: $error');
      return [];
    }
  }

  // Insert a new language for a user
  static Future<int> insertUserLanguage(int userID, String languageName) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'UserLanguages',
        {
          'userID': userID,
          'languageName': languageName,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting language for userID $userID: $error');
      return -1; // Return negative value on failure
    }
  }

  // Update a language by languageID
  static Future<int> updateUserLanguage(int languageID, String newLanguageName) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'UserLanguages',
        {'languageName': newLanguageName},
        where: 'languageID = ?',
        whereArgs: [languageID],
      );
    } catch (error) {
      print('Error occurred while updating language with languageID $languageID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific language by languageID
  static Future<int> deleteUserLanguage(int languageID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserLanguages',
        where: 'languageID = ?',
        whereArgs: [languageID],
      );
    } catch (error) {
      print('Error occurred while deleting language with languageID $languageID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete all languages for a specific user (optional, useful for explicit deletion if needed)
  static Future<int> deleteLanguagesByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserLanguages',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting languages for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
}
