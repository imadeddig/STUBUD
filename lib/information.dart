import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stubudmvp/database/initialization.dart';
import 'package:stubudmvp/interest1.dart';

class Infor extends StatefulWidget {
  final String userID;

  const Infor({super.key, required this.userID});

  @override
  State<Infor> createState() => _InforState();
}

class _InforState extends State<Infor> {
    Map<String, dynamic>? studentProfile;
  String school = ''; 

  @override
  void initState() {
    super.initState();
    _loadStudentProfile();
  }


  Future<void> _loadStudentProfile() async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          studentProfile = docSnapshot.data() as Map<String, dynamic>;
          _extractSchoolName(); 
        });
      } else {
        print("User not found in Firestore.");
      }
    } catch (e) {
      print("Error loading student profile: $e");
    }
  }

  Future<void> _extractSchoolName() async {
  if (studentProfile == null) {
    print('Student profile is null');
    return;
  }

  String? email = studentProfile?['email'];
  if (email == null || !email.contains('@')) {
    print('Invalid or missing email: $email');
    return;
  }

  setState(() {
    school = extractSchoolName(email);
    print('Extracted School Name: $school');
  });
  DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(widget.userID);
    await userDocRef.update({
      'school': school,
    });
}


  String extractSchoolName(String email) {
  List<String> parts = email.split('@');
  if (parts.length > 1) {
    String domain = parts[1];
    List<String> domainParts = domain.split('.');
    if (domainParts.isNotEmpty) {
      return domainParts[0];
    }
  }
  return ''; 
}

 


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.012;

    if (studentProfile == null) {
      // Show a loading indicator until the profile is fetched
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          toolbarHeight: 50,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: verticalPadding),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.1)),
                      child: Text(
                        "You are officially in!",
                        style: GoogleFonts.outfit(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.14)),
                      child: Text(
                        "Based on your progress account, here is what we know about you so far!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: (screenHeight * 0.022),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Information",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.005),
                  ),
                  Text(
                    "First Name",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    studentProfile?['username'] ?? 'Loading...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.010),
                  ),
                  Text(
                    "Date of Birth",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    studentProfile?['dateOfBirth'] ?? 'Loading...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.010),
                  ),
                  Text(
                    "Gender",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    studentProfile?['gender'] ?? 'Loading...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.010),
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: (screenHeight * 0.009),
                  ),
                  Text(
                    "Education",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.005),
                  ),
                  Text(
                    "School/University",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                     school,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.010),
                  ),
                  Text(
                    "Field",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    studentProfile?['field'] ?? 'Loading...',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.010),
                  ),
                  Text(
                    "Level",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    studentProfile?['level'] ?? 'Loading...',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.0055),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (screenHeight * 0.0350),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.10)),
              child: Text(
                "Information below can’t be changed for security measures. Let us know more about who you are now!",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.33), vertical: (screenHeight * 0.03)),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Interest1(userID: widget.userID)));
                },
                height: 55,
                color: const Color(0XFF7C90D6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Continue",
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

