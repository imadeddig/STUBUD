import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> _fetchData(dynamic widget) async {
  try {
    print('UserID: ${widget.userID}');

    // Fetch the logged-in user's document to retrieve their list of friends
    final loggedInUserDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userID).get();
    if (!loggedInUserDoc.exists) {
      throw Exception("Logged-in user document not found");
    }

    // Retrieve the list of friend IDs from the logged-in user's document
    List<String> friends = List<String>.from(loggedInUserDoc.data()?['friends'] ?? []);

    // Fetch all users, excluding the logged-in user and their friends
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();

    final documents = snapshot.docs
        .where((doc) => doc.id != widget.userID && !friends.contains(doc.id)) // Exclude logged-in user and friends
        .toList();

    _users = documents.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'userID': doc.id,  // Add the userID here
        'name': data['fullName'],
        'bio': data['bio'],
        'detail': 'Student at ${data['school']}',
        'image': data['profilePic'] ?? 'default_image.jpg',
        'interests': data['interests'] ?? [],
        'academicStrengths': data['academicStrengths'] ?? [],
        'languagesSpoken': data['languagesSpoken'] ?? [],
        'communicationMethods': data['communicationMethods'] ?? [],
        'preferredStudyMethods': data['preferredStudyMethods'] ?? [],
        'preferredStudyTimes': data['preferredStudyTimes'] ?? [],
        'studyGoals': data['studyGoals'] ?? [],
        'values': data['values'] ?? [],
        'images': data['images'] ?? [],
        'imagesSize': (data['images'] ?? []).length,
      };
    }).toList()
    ..sort((a, b) => a['name'].compareTo(b['name'])); // Sort by name

  } catch (e) {
    print('Error fetching data: $e');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}



   // Add user data to the collection
      /*
      await users.doc('58555585858520').set({
        'active' : 'true',
        'dateOfBirth' : '2004-05-08',
        'email' : 'badri@gmail.com',
        'field' : 'Artificial Intelligence',
        'fullName' : 'badri',
        'level' : 'first year 1sr(L1/1CP)',
        'password' : 'badribadri',
        'username' : 'menkilla',
          'name': 'badri',
          'bio': 'dont get too close, i am a bad friend ijbol',
          'school': 'ENSIA',
          'image': {'', '', ''},
          'interests': {'coding', 'films', 'gaming', 'fashion'},
          'academicStrengths': {'programming', 'mathematics', 'computer architecture'},
          'languagesSpoken': {'english', 'french', 'arabic'},
          'communicationMethods': {'coffee shops', 'univeristy library', 'dorms'},
          'preferredStudyMethods': {'silent study', 'quizzes', 'mock tests'},
          'preferredStudyTimes': {'morning', 'evening', 'night'},
          'studyGoals': {'finding study buddies', 'collaborate on projects', 'networking'},
          'values': {'hypocrisity', 'lying'},
          'profilePic': '',
      });


*/

//!MUST UPDATE DONT LOOP.



import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final bool condition = true; // Change this to see different content

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conditional Rendering"),
      ),
      body: condition
          ? Center(
              child: Text(
                "Condition is true!",
                style: TextStyle(fontSize: 20),
              ),
            )
          : Center(
              child: Text(
                "Condition is false!",
                style: TextStyle(fontSize: 20),
              ),
            ),
    );
  }
}
