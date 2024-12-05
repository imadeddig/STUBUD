import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Infor extends StatefulWidget {
  const Infor({super.key});

  @override
  State<Infor> createState() => _InforState();
}

class _InforState extends State<Infor> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.012;

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
                      padding:
                          EdgeInsets.symmetric(horizontal: (screenWidth * 0.1)),
                      child: Text(
                        "You are officially in !",
                        style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: (screenWidth * 0.14)),
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
                    "Imad Eddine",
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
                    "27 september 2004",
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
                    "Male",
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
                    "The National Higher School Of Artificial Intelligence - 2nd",
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
                    "mathematics/computer sicence",
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
                    "cycle superieure",
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
                "information bellow can’t be changed for security measures. let us know more about who you are now !",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.33) , vertical: (screenHeight * 0.03)),
              
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("specialite");
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
