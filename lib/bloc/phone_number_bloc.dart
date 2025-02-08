import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant/constant.dart';

// Define the events
abstract class PhoneNumberEvent {}

class PhoneNumberUpdateRequested extends PhoneNumberEvent {
  final String phoneNumber;
  final String userId;

  PhoneNumberUpdateRequested({required this.phoneNumber, required this.userId});
}

class PhoneNumberVerificationRequested extends PhoneNumberEvent {
  final String email;

  PhoneNumberVerificationRequested({required this.email});
}

// Define the states
abstract class PhoneNumberState {}

class PhoneNumberInitial extends PhoneNumberState {}

class PhoneNumberLoading extends PhoneNumberState {}

class PhoneNumberSuccess extends PhoneNumberState {
  final String phoneNumber;
  PhoneNumberSuccess(this.phoneNumber);
}

class PhoneNumberFailure extends PhoneNumberState {
  final String errorMessage;
  PhoneNumberFailure(this.errorMessage);
}

class PhoneNumberVerificationSuccess extends PhoneNumberState {}

class PhoneNumberVerificationFailure extends PhoneNumberState {
  final String errorMessage;
  PhoneNumberVerificationFailure(this.errorMessage);
}

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  

  PhoneNumberBloc() : super(PhoneNumberInitial()) {
    on<PhoneNumberUpdateRequested>(_handlePhoneNumberUpdateRequested);
    on<PhoneNumberVerificationRequested>(_handlePhoneNumberVerificationRequested);
  }

  // Function to validate phone number format
  bool _isPhoneNumberValid(String phoneNumber) {
    final phoneRegex = RegExp(r'^\d{10,15}$'); // E.164 format
    return phoneRegex.hasMatch(phoneNumber);
  }

  // Handle the phone number update event
  Future<void> _handlePhoneNumberUpdateRequested(
      PhoneNumberUpdateRequested event, Emitter<PhoneNumberState> emit) async {
    emit(PhoneNumberLoading());

    try {
      if (!_isPhoneNumberValid(event.phoneNumber)) {
        emit(PhoneNumberFailure("Invalid phone number format"));
        return;
      }

      // Send the phone number update request to Flask backend
      final response = await http.post(
        Uri.parse('$flaskBaseUrl/update_phone_number'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': event.userId,
          'phoneNumber': event.phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        emit(PhoneNumberSuccess(event.phoneNumber));
      } else {
        final error = jsonDecode(response.body)['error'];
        emit(PhoneNumberFailure(error));
      }
    } catch (e) {
      emit(PhoneNumberFailure('Error updating phone number: $e'));
    }
  }

  // Handle email verification event
  Future<void> _handlePhoneNumberVerificationRequested(
      PhoneNumberVerificationRequested event, Emitter<PhoneNumberState> emit) async {
    emit(PhoneNumberLoading());

    try {
      // Send email verification to the provided email via Flask
      final response = await http.post(
        Uri.parse('$flaskBaseUrl/send_verification_email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': event.email}),
      );

      if (response.statusCode == 200) {
        emit(PhoneNumberVerificationSuccess());
      } else {
        final error = jsonDecode(response.body)['error'];
        emit(PhoneNumberVerificationFailure(error));
      }
    } catch (e) {
      emit(PhoneNumberVerificationFailure('Error sending verification email: $e'));
    }
  }
}

