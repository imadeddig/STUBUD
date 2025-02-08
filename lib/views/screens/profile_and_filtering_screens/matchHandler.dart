import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:googleapis_auth/googleapis_auth.dart' as gAuth;
import 'package:googleapis_auth/auth_io.dart' as gAuthh;


Future<bool> onSwipeButtonPressed(String currentUserId, String otherUserId) async {
  bool isMatch = false;
  try {
    var interestedInRef = FirebaseFirestore.instance.collection('InterestedIn');

    var currentUserSwipe = await interestedInRef
        .where('InterestedStuID', isEqualTo: otherUserId)
        .where('RecipientStuID', isEqualTo: currentUserId)
        .get();

    if (currentUserSwipe.docs.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
        'friendsList': FieldValue.arrayUnion([otherUserId]),
      });
      await FirebaseFirestore.instance.collection('users').doc(otherUserId).update({
        'friendsList': FieldValue.arrayUnion([currentUserId]),
      });

      var currentUserDoc = await FirebaseFirestore.instance.collection('users').doc(currentUserId).get();
      var otherUserDoc = await FirebaseFirestore.instance.collection('users').doc(otherUserId).get();

      String? token1 = currentUserDoc.data()?['token'];
      String? token2 = otherUserDoc.data()?['token'];

      await interestedInRef.doc(currentUserSwipe.docs.first.id).delete();
      isMatch = true;

      if (token1 != null) {
        await sendNotification(token1, 'It is a Match!', 'You have made a new Study Buddy, Start Chatting now!');
      }
      if (token2 != null) {
        await sendNotification(token2, 'It is a Match!', 'You have made a new Study Buddy, Start Chatting now!');
      }
    } else {
      await interestedInRef.add({
        'InterestedStuID': currentUserId,
        'RecipientStuID': otherUserId,
        'matchDate': FieldValue.serverTimestamp(),
      });
    }

    await FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
      'slides': FieldValue.arrayUnion([otherUserId]),
    });

    return isMatch;
  } catch (e) {
    print('Error processing swipe: $e');
    return false;
  }
}


Future<void> sendNotification(String token, String title, String body) async {
  try {
    final String projectId = 'stubud-e32d2';
    final String endpoint = 'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

    // Load the JSON file from assets
    final jsonString = await rootBundle.loadString('assets/stubud-e32d2-firebase-adminsdk-jln8d-9b598c8897.json');
    final credentials = gAuth.ServiceAccountCredentials.fromJson(jsonString);

    final client = await gAuthh.clientViaServiceAccount(credentials, ['https://www.googleapis.com/auth/firebase.messaging']);

    final response = await client.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "message": {
          "token": token,
          "notification": {
            "title": title,
            "body": body,
          },
          "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
          }
        }
      }),
    );

    if (response.statusCode != 200) {
      print('Error sending notification: ${response.body}');
    } else {
      print('Notification sent successfully');
    }
  } catch (e) {
    print('Error sending notification: $e');
  }
}







void showMatchMessage(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.45,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Center(
                child: Text("Congrats ! \n You have made a Study Buddy!?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      fontSize: 13,
                    ))),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("chutbud1", (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C8FD6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 25,
                  ),
                ),
                child: Text(
                  "Start a Conversation",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  "keep exploring",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
