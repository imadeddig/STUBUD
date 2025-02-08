import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant/constant.dart';

/// -------------------------------------
/// EVENTS
/// -------------------------------------
abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class CurrentPasswordChanged extends ChangePasswordEvent {
  final String currentPassword;

  const CurrentPasswordChanged(this.currentPassword);

  @override
  List<Object> get props => [currentPassword];
}

class NewPasswordChanged extends ChangePasswordEvent {
  final String newPassword;

  const NewPasswordChanged(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

class ConfirmPasswordChanged extends ChangePasswordEvent {
  final String confirmPassword;

  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class SubmitChangePassword extends ChangePasswordEvent {
  final String userID;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const SubmitChangePassword({
    required this.userID,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [userID, currentPassword, newPassword, confirmPassword];
}

/// -------------------------------------
/// STATES
/// -------------------------------------
abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {
  final String error;

  const ChangePasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}

/// -------------------------------------
/// BLOC
/// -------------------------------------
class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  

  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<CurrentPasswordChanged>((event, emit) {
      // Handle current password logic if necessary
    });

    on<NewPasswordChanged>((event, emit) {
      // Handle new password logic if necessary
    });

    on<ConfirmPasswordChanged>((event, emit) {
      // Handle confirm password logic if necessary
    });

    on<SubmitChangePassword>((event, emit) async {
      emit(ChangePasswordLoading());

      try {
        // Ensure passwords match
        if (event.newPassword != event.confirmPassword) {
          emit(const ChangePasswordFailure("New password and confirmation do not match."));
          return;
        }

        // Send the password change request to Flask backend
        final response = await http.post(
          Uri.parse('$flaskBaseUrl/change_password'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'userID': event.userID,
            'currentPassword': event.currentPassword,
            'newPassword': event.newPassword,
          }),
        );

        if (response.statusCode == 200) {
          emit(ChangePasswordSuccess());
        } else {
          final error = jsonDecode(response.body)['error'];
          emit(ChangePasswordFailure(error));
        }
      } catch (e) {
        emit(ChangePasswordFailure("An error occurred: ${e.toString()}"));
      }
    });
  }
}
