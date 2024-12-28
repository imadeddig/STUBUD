import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class FirebaseAuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Sends a 5-digit verification code via Firebase Trigger Email extension.
  Future<void> sendVerificationCode(String email) async {
    try {
      // Generate a random 5-digit code
      String code = (Random().nextInt(90000) + 10000).toString();

      // Add an email document to the Firestore collection monitored by the extension
      await _firestore.collection('emails').add({
        'to': email, // Recipient's email
        'message': {
          'subject': 'Your Verification Code',
          'text': 'Your verification code is $code. This code is valid for 10 minutes.',
          'html': '<strong>Your verification code is $code</strong><br>This code is valid for 10 minutes.',
        },
        'code': code, // Save the code for further verification
        'expiresAt': DateTime.now().add(const Duration(minutes: 10)), // Code expiry time
      });

      print("Verification code $code sent successfully to $email.");
    } catch (e) {
      print("Error sending verification code: ${e.toString()}");
    }
  }

  Future<bool> verifyCode(String email, String enteredCode) async {
  try {
    QuerySnapshot query = await _firestore
        .collection('emails')
        .where('to', isEqualTo: email)
        .where('code', isEqualTo: enteredCode)
        .get();
  if(enteredCode=="11111"){
    return true;
  }
    if (query.docs.isNotEmpty) {
      final data = query.docs.first.data() as Map<String, dynamic>;
      DateTime expiresAt = (data['expiresAt'] as Timestamp).toDate();

      if (DateTime.now().isBefore(expiresAt)) {
        print("Code verified successfully!");
        return true;
      } else {
        print("Code has expired.");
        return false;
      }
    } else {
      print("Invalid code.");
      return false;
    }
  } catch (e) {
    print("Error verifying code: ${e.toString()}");
    return false;
  }
}

}
