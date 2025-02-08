import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class UserImagesDB {
  // Fetch all images for a specific user
  static Future<List<Map<String, dynamic>>> getUserImages(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'UserImages',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while fetching images for userID $userID: $error');
      return [];
    }
  }

  // Insert a new image for a user
  static Future<int> insertUserImage(int userID, String imageUrl) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'UserImages',
        {
          'userID': userID,
          'imageUrl': imageUrl,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting image for userID $userID: $error');
      return -1; // Return negative value on failure
    }
  }

  // Update an existing image URL by imageID
  static Future<int> updateUserImage(int imageID, String newImageUrl) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'UserImages',
        {'imageUrl': newImageUrl},
        where: 'imageID = ?',
        whereArgs: [imageID],
      );
    } catch (error) {
      print('Error occurred while updating image with imageID $imageID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific image by imageID
  static Future<int> deleteUserImage(int imageID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserImages',
        where: 'imageID = ?',
        whereArgs: [imageID],
      );
    } catch (error) {
      print('Error occurred while deleting image with imageID $imageID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete all images for a specific user (optional, useful for explicit deletion if needed)
  static Future<int> deleteImagesByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'UserImages',
        where: 'userID = ?',
        whereArgs: [userID],
      );
    } catch (error) {
      print('Error occurred while deleting images for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
}
