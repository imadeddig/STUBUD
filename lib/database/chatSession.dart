import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class ChatSessionsDB {
  // Create the ChatSessions table
  static Future<void> createChatSessionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ChatSessions (
        chatID INTEGER PRIMARY KEY AUTOINCREMENT,
        user1ID INTEGER NOT NULL,
        user2ID INTEGER NOT NULL,
        lastMessage TEXT,
        lastMessageTime TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user1ID) REFERENCES StudentProfile(userID) ON DELETE CASCADE,
        FOREIGN KEY (user2ID) REFERENCES StudentProfile(userID) ON DELETE CASCADE
      );
    ''');
  }

  // Insert a new chat session
  static Future<int> insertChatSession({
    required int user1ID,
    required int user2ID,
    String? lastMessage,
  }) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.insert(
        'ChatSessions',
        {
          'user1ID': user1ID,
          'user2ID': user2ID,
          'lastMessage': lastMessage ?? '',
          'lastMessageTime': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print('Error occurred while inserting chat session: $error');
      return -1; // Return -1 on failure
    }
  }

  // Fetch all chat sessions
  static Future<List<Map<String, dynamic>>> getAllChatSessions() async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query('ChatSessions');
    } catch (error) {
      print('Error occurred while fetching all chat sessions: $error');
      return [];
    }
  }

  // Fetch chat sessions by userID
  static Future<List<Map<String, dynamic>>> getChatSessionsByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.query(
        'ChatSessions',
        where: 'user1ID = ? OR user2ID = ?',
        whereArgs: [userID, userID],
      );
    } catch (error) {
      print('Error occurred while fetching chat sessions for userID $userID: $error');
      return [];
    }
  }

  // Update the last message and timestamp for a specific chat session
  static Future<int> updateLastMessage({
    required int chatID,
    required String lastMessage,
  }) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.update(
        'ChatSessions',
        {
          'lastMessage': lastMessage,
          'lastMessageTime': DateTime.now().toIso8601String(),
        },
        where: 'chatID = ?',
        whereArgs: [chatID],
      );
    } catch (error) {
      print('Error occurred while updating chat session with chatID $chatID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Delete a specific chat session by chatID
  static Future<int> deleteChatSession(int chatID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'ChatSessions',
        where: 'chatID = ?',
        whereArgs: [chatID],
      );
    } catch (error) {
      print('Error occurred while deleting chat session with chatID $chatID: $error');
      return 0; // Return 0 on failure
    }
  }

  // Fetch messages for a specific chatID
Future<List<Map<String, dynamic>>> fetchAllMessagesForChat(int chatID) async {
  final db = await DBHelper.getDatabase();
  return await db.query(
    'Messages',
    where: 'chatID = ?',
    whereArgs: [chatID],
    orderBy: 'timestamp ASC',
  );
}


  // Delete all chat sessions for a specific user
  static Future<int> deleteChatSessionsByUserID(int userID) async {
    try {
      final database = await DBHelper.getDatabase();
      return await database.delete(
        'ChatSessions',
        where: 'user1ID = ? OR user2ID = ?',
        whereArgs: [userID, userID],
      );
    } catch (error) {
      print('Error occurred while deleting chat sessions for userID $userID: $error');
      return 0; // Return 0 on failure
    }
  }
static Future<List<Map<String, dynamic>>> getChatSessions(int userID) async {
  final db = await DBHelper.getDatabase();
  
  // Fetch all chat sessions where the user is either user1 or user2
  final chatSessions = await db.query(
    'ChatSessions',
    where: 'user1ID = ? OR user2ID = ?',
    whereArgs: [userID, userID],
  );

  List<Map<String, dynamic>> chats = [];

  // Check if chatSessions is being populated correctly
  print('Chat Sessions fetched: $chatSessions');

  for (var session in chatSessions) {
   int user2ID = (session['user1ID'] as int) == userID ? (session['user2ID'] as int) : (session['user1ID'] as int);


    // Fetch user details from StudentProfile
    final userProfile = await db.query(
      'StudentProfile',
      where: 'userID = ?',
      whereArgs: [user2ID],
    );

    if (userProfile.isNotEmpty) {
      // Add to the chats list
      chats.add({
        'name': userProfile[0]['username'],
        'image': userProfile[0]['profilePicture'],
        'messages': [],  // Empty messages for now
      });
    }
  }

  // Return the fetched chat data
  return chats;
}

}