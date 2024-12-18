import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/farial/shots.dart';
import 'package:stubudmvp/database/StudentProfile.dart';

class Interest5 extends StatefulWidget {
  final int userID;

  const Interest5({super.key, required this.userID});

  @override
  State<Interest5> createState() => _Interest5State();
}

class _Interest5State extends State<Interest5> {
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.028;
    double progress = (5 / 6);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Shots(userID: widget.userID)));
                },
                child: Text(
                  "Skip",
                  style: GoogleFonts.outfit(
                      color: Colors.black, fontWeight: FontWeight.w800),
                )),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: verticalPadding),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: (screenWidth * 0.2)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            valueColor:
                                const AlwaysStoppedAnimation(Color(0XFF7C90D6)),
                            minHeight: 9,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "5/6",
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: (screenHeight * 0.035),
                ),
                Center(
                  child: Text(
                    "Set Your Location",
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 21,
                    ),
                  ),
                ),
                SizedBox(
                  height: (screenHeight * 0.0012),
                ),
                Center(
                  child: Text(
                    "Find out who’s close by!",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.7,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: (screenHeight * 0.045),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: (screenWidth * 0.1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 41,
                        child: TextField(
                          controller: locationController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0XFF7C90D6),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0XFF7C90D6),
                                width: 2,
                              ),
                            ),
                            hintText: "your location",
                            hintStyle: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0XFF7C90D6),
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (screenHeight * 0.03),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color(0XFF1D1B20),
                              size: 21,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "your current location",
                              style: GoogleFonts.outfit(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (screenHeight * 0.0095),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.map_outlined,
                              color: Color(0XFF1D1B20),
                              size: 21,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "select location on map",
                              style: GoogleFonts.outfit(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.041,
            right: screenWidth * 0.06,
            child: InkWell(
              onTap: () async {
                String location = locationController.text;
                Map<String, dynamic> updatedProfile = {
                  'location': location,
                };

                int rowsAffected = await StudentProfileDB.updateStudentProfile(
                    widget.userID, updatedProfile);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Shots(userID: widget.userID)));
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0XFF7C90D6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
