import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Future<bool> onSwipeButtonPressed(String currentUserId, String otherUserId) async {
  bool isMatch = false;
  try {
    // Reference to the "interestedIn" collection
    var interestedInRef = FirebaseFirestore.instance.collection('InterestedIn');

    // Check if the current user has already swiped on user X
    var currentUserSwipe = await interestedInRef
        .where('InterestedStuID', isEqualTo: otherUserId)
        .where('RecipientStuID', isEqualTo: currentUserId)
        .get();

    if (currentUserSwipe.docs.isNotEmpty) {
    
      // Match found, update the friends list
      await FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
        'friendsList': FieldValue.arrayUnion([otherUserId]),
      });
      await FirebaseFirestore.instance.collection('users').doc(otherUserId).update({
        'friendsList': FieldValue.arrayUnion([currentUserId]),
      });

      // Remove the swipe document to complete the match process
      await interestedInRef.doc(currentUserSwipe.docs.first.id).delete();
        isMatch = true;
   

      // Return true to indicate a match
    
    } else {
      // No match yet, add a swipe record
      await interestedInRef.add({
        'InterestedStuID': currentUserId,
        'RecipientStuID': otherUserId,
        'matchDate': FieldValue.serverTimestamp(),
      });

      // Return false to indicate no match

    }
          return isMatch;
  } catch (e) {
    print('Error processing swipe: $e');

    // Handle errors gracefully by returning false
    return false;
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

