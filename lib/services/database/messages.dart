import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class MessagesDB {
  // Create the Messages table
  static Future<void> createMessagesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Messages (
        messageID INTEGER PRIMARY KEY AUTOINCREMENT,
        chatID INTEGER NOT NULL,
        senderID INTEGER NOT NULL,
        receiverID INTEGER NOT NULL,
        message TEXT NOT NULL,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (chatID) REFERENCES ChatSessions(chatID) ON DELETE CASCADE,
        FOREIGN KEY (senderID) REFERENCES StudentProfile(userID) ON DELETE CASCADE,
        FOREIGN KEY (receiverID) REFERENCES StudentProfile(userID) ON DELETE CASCADE
      );
    ''');
  }

  // Insert a new message
  static Future<int> insertMessage({
    required int chatID,
    required int senderID,
    required int receiverID,
    required String message,
  }) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'Messages',
        {
          'chatID': chatID,
          'senderID': senderID,
          'receiverID': receiverID,
          'message': message,
          'timestamp': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting message: $error');
      return -1; 
    }
  }

  // Fetch all messages for a specific chat session
  static Future<List<Map<String, dynamic>>> getMessagesByChatID(int chatID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'Messages',
        where: 'chatID = ?',
        whereArgs: [chatID],
        orderBy: 'timestamp ASC',
      );
    } catch (error) {
      print('Error occurred while fetching messages for chatID $chatID: $error');
      return [];
    }
  }

  // Fetch all messages sent or received by a specific user
  static Future<List<Map<String, dynamic>>> getMessagesByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'Messages',
        where: 'senderID = ? OR receiverID = ?',
        whereArgs: [userID, userID],
        orderBy: 'timestamp ASC',
      );
    } catch (error) {
      print('Error occurred while fetching messages for userID $userID: $error');
      return [];
    }
  }

  // Update a specific message's content
  static Future<int> updateMessageContent({
    required int messageID,
    required String newMessageContent,
  }) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'Messages',
        {'message': newMessageContent, 'timestamp': DateTime.now().toIso8601String()},
        where: 'messageID = ?',
        whereArgs: [messageID],
      );
    } catch (error) {
      print('Error occurred while updating message with messageID $messageID: $error');
      return 0; // Return 0 on failure
    }
  }

  static Future<int> deleteMessage(int messageID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'Messages',
        where: 'messageID = ?',
        whereArgs: [messageID],
      );
    } catch (error) {
      print('Error occurred while deleting message with messageID $messageID: $error');
      return 0; 
    }
  }


  static Future<int> deleteMessagesByChatID(int chatID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'Messages',
        where: 'chatID = ?',
        whereArgs: [chatID],
      );
    } catch (error) {
      print('Error occurred while deleting messages for chatID $chatID: $error');
      return 0; 
    }
  }
}
