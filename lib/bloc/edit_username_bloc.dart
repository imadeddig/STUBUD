import 'package:bloc/bloc.dart';
import '../../database/db_helper.dart';


// BLoC class to manage username update
class EditUsernameBloc extends Cubit<String> {
  EditUsernameBloc() : super('');

  // Function to update the username in the database and emit the new state
  Future<void> updateUsername(String newUsername , int userID) async {
    try {
      final db = await DBHelper.getDatabase();

      // Update username in the database
      await db.update(
        'StudentProfile',
        {'username': newUsername},
        where: 'userID = ?',
        whereArgs: [userID], // Example dummy email, replace with current user's email
      );

      // Emit the new username to the state
      emit(newUsername);
    } catch (e) {
      print('Error updating username: $e');
    }
  }

  // Fetch the initial username (for example, from the database)
  Future<void> loadUsername(int userID) async {
    final db = await DBHelper.getDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'StudentProfile',
      where: 'userID = ?',
      whereArgs: [userID], // Example dummy email
      limit: 1,
    );
    if (result.isNotEmpty) {
      emit(result.first['username']);
    }
  }
}
