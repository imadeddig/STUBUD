import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant/constant.dart';

class EditUsernameState {
  final String username;
  final String message;

  EditUsernameState({required this.username, required this.message});
}

class EditUsernameBloc extends Cubit<EditUsernameState> {
  EditUsernameBloc() : super(EditUsernameState(username: '', message: ''));

  

  // Load the username from Flask backend
  Future<void> loadUsername(String userID) async {
    try {
      final response = await http.get(Uri.parse('$flaskBaseUrl/get_username/$userID'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(EditUsernameState(username: data['username'], message: ''));
      } else {
        final error = jsonDecode(response.body)['error'];
        emit(EditUsernameState(username: '', message: error));
      }
    } catch (e) {
      emit(EditUsernameState(username: '', message: 'Error loading username: $e'));
    }
  }

  // Update the username via Flask backend
  Future<void> updateUsername(String newUsername, String userID) async {
    try {
      final response = await http.post(
        Uri.parse('$flaskBaseUrl/update_username'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userID': userID, 'username': newUsername}),
      );

      if (response.statusCode == 200) {
        emit(EditUsernameState(username: newUsername, message: 'Username updated successfully!'));
      } else {
        final error = jsonDecode(response.body)['error'];
        emit(EditUsernameState(username: '', message: error));
      }
    } catch (e) {
      emit(EditUsernameState(username: '', message: 'Error updating username: $e'));
    }
  }
}

