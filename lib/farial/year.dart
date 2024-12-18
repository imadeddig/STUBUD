import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/database/StudentProfile.dart';

class Year extends StatefulWidget {
   final int userID;

  const Year({super.key, required this.userID});

  @override
  State<Year> createState() => _YearState();
}

class _YearState extends State<Year> {
  String? selectedYear;

  final List<String> years = [
    "first year 1st (L1/1PC)",
    "second year 2nd (L2/2PC)",
    "third year 3rd (L3/1SC)",
    "fourth year 4th (M1/2SC)",
    "fivth year 5th (M2/3SC)",
    "sixth year 6th",
    "seventh year 7th",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
           margin: const EdgeInsets.only(top: 15, left: 5), 
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(124, 144, 214, 0.3),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7C90D6),
                  ),
                ),
              ),
            ),
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Text(
                "Your Year of Study ",
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          

            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF7C8FD6),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: years.map((year) {
                    return GestureDetector(
                      onTap: () async{
                        setState(() {
                          selectedYear = year;
                        });

                         Map<String, dynamic> updatedProfile = {
                                      'level': selectedYear,
                                         };

                                    int rowsAffected = await StudentProfileDB
                                        .updateStudentProfile(
                                            widget.userID, updatedProfile);
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all( 5),
                                width: 5,
                                child: (selectedYear == year)
                                    ? const Icon(
                                        Icons.check,
                                        color: Color(0xFF7C8FD6),
                                      )
                                    : Container(color: Colors.white)),
                            const SizedBox(width: 20),
                            Container(
                              width:MediaQuery.of(context).size.width*0.7,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                               
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(124, 144, 214, 0.5),
                                  ),
                                ),
                              ),
                              child: Text(
                                year,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
