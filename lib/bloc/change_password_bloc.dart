import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../database/db_helper.dart';

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
  final int userID;
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
      // Handle the current password logic if necessary
    });

    on<NewPasswordChanged>((event, emit) {
      // Handle the new password logic if necessary
    });

    on<ConfirmPasswordChanged>((event, emit) {
      // Handle the confirm password logic if necessary
    });

    on<SubmitChangePassword>((event, emit) async {
      emit(ChangePasswordLoading());

      try {
        // Ensure passwords match
        if (event.newPassword != event.confirmPassword) {
          emit(ChangePasswordFailure("New password and confirmation do not match."));
          return;
        }

        final db = await DBHelper.getDatabase();

        // Fetch the user record with the matching userID
        final List<Map<String, dynamic>> users = await db.query(
          'StudentProfile',
          where: 'userID = ?',
          whereArgs: [event.userID], // Querying by userID
        );

        if (users.isEmpty) {
          emit(ChangePasswordFailure("User not found."));
          return;
        }

        final storedPassword = users.first['password'];

        // Check if currentPassword matches the stored password
        if (event.currentPassword != storedPassword) {
          emit(ChangePasswordFailure("Current password is incorrect."));
          return;
        }

        // Update the password in the database
        await db.update(
          'StudentProfile',
          {'password': event.newPassword},
          where: 'userID = ?',
          whereArgs: [event.userID],
        );

        emit(ChangePasswordSuccess());
      } catch (e) {
        emit(ChangePasswordFailure("An error occurred: ${e.toString()}"));
      }
    });
  }
}
