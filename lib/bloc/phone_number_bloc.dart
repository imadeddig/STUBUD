import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stubudmvp/database/db_helper.dart';

// Define the events
abstract class PhoneNumberEvent {}


// Define the states
class PhoneNumberBloc extends Bloc<PhoneNumberEvent, String> {
  PhoneNumberBloc() : super('');

  @override
    Future<void> updatePhoneNumber(String phoneNumber ,int userId) async {
    try {
      final db = await DBHelper.getDatabase();

      // Update phone number in the database
      await db.update(
        'StudentProfile',
        {'phoneNumber': phoneNumber},
        where: 'userID = ?',
        whereArgs: [userId], // Example dummy email, replace with current user's email
      );

      // Emit the new username to the state
      emit(phoneNumber);
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
      emit(result.first['phoneNumber']);
    }
  }
}
