import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/database/StudentProfile.dart';
import 'package:stubudmvp/interest1.dart';


class Infor extends StatefulWidget {
  final int userID;

  const Infor({super.key, required this.userID});

  @override
  State<Infor> createState() => _InforState();
}

class _InforState extends State<Infor> {
  Map<String, dynamic>? studentProfile;

  @override
  void initState() {
    super.initState();
    _loadStudentProfile();
  }

  // Load the student profile based on the userID
  Future<void> _loadStudentProfile() async {
    final profile = await StudentProfileDB.getStudentProfileByUserID(widget.userID);
    setState(() {
      studentProfile = profile;
    });
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
                        "You are officially in !",
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
                        "based on your progress account, here is what we know about you so far !",
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
                    studentProfile?['username'] ?? 'Loading...', // Use the dynamic name
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
                    studentProfile?['dateOfBirth'] ?? 'Loading...', // Dynamic Date of Birth
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
                    studentProfile?['gender'] ?? 'Loading...', // Dynamic Gender
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
                    "school/university",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    studentProfile?['school'] ?? 'Loading...', // Dynamic School
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
                    studentProfile?['field'] ?? 'Loading...', // Dynamic Field
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
                    studentProfile?['level'] ?? 'Loading...', // Dynamic Level
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Interest1(userID:widget.userID)));
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
