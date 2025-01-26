import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/interest5.dart';

class Modify extends StatefulWidget {
  final String userID;

  const Modify({super.key, required this.userID});

  @override
  State<Modify> createState() => _ModifyState();
}

class _ModifyState extends State<Modify> {
  List<String> studyTimes = [];
  List<String> methods = [];
  List<String> goals = [];
  List<String> communication = [];
  List<String> strength = [];
  List<String> skills = [];

  final Set<String> selectedTimes = {};
  final Set<String> selectedMethods = {};
  final Set<String> selectedGoals = {};
  final Set<String> selectedComm = {};
  final Set<String> selectedStrength = {};
  final Set<String> selectedSkills = {};

  Future<void> fetchData() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('interests')
          .doc('interest')
          .get();
      if (docSnapshot.exists) {
        setState(() {
          studyTimes = _getListFromSnapshot(docSnapshot, 'studyTimes');
          methods = _getListFromSnapshot(docSnapshot, 'studyMethods');
          goals = _getListFromSnapshot(docSnapshot, 'purposesAndGoals');
          communication =
              _getListFromSnapshot(docSnapshot, 'CommunicationMethods');
          strength = _getListFromSnapshot(docSnapshot, 'AcademicStrength');
          skills = _getListFromSnapshot(docSnapshot, 'skills');
        });
      }
    } catch (error) {
      print("Error fetching interests: $error");
    }
  }

  List<String> _getListFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot, String fieldName) {
    final List<dynamic>? fieldArray = snapshot[fieldName];
    return fieldArray != null ? List<String>.from(fieldArray) : [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.028;
    double progress = (4 / 6);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: TextButton(
              onPressed: () async {
             
                Navigator.of(context).pop();
              },
              child: Text(
                "Done",
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: verticalPadding),
              child: Column(
                children: [
                 
                  SizedBox(
                    height: (screenHeight * 0.035),
                  ),
                  Center(
                    child: Text(
                      "Tailor your profile!",
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
                      "Tell us more about what makes you tick",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.7,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.012),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        Text(
                          "Study Times",
                          style: GoogleFonts.outfit(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "What's your secret to making studying fun?",
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.013),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: studyTimes.map((label) {
                          final bool isSelected3A =
                              selectedTimes.contains(label);
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    if (isSelected3A) {
                                      selectedTimes.remove(label);
                                    } else {
                                      selectedTimes.add(label);
                                    }
                                  });
                                  final userDoc = FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.userID);

                                  await userDoc
                                      .update({'studyTimes': selectedTimes});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: (screenWidth * 0.05)),
                                  height: 33,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: isSelected3A
                                        ? const Color(0XFF7C90D6)
                                        : Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: const Color(0XFF7C90D6),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      label,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected3A
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.01),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        Text(
                          "Preferred Study Methods",
                          style: GoogleFonts.outfit(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "What's your secret to making studying fun?",
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.013),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: methods.map((label) {
                          final bool isSelected3B =
                              selectedMethods.contains(label);
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    if (isSelected3B) {
                                      selectedMethods.remove(label);
                                    } else {
                                      selectedMethods.add(label);
                                    }
                                  });
                                  final userDoc = FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.userID);

                                  await userDoc.update(
                                      {'StudyMethods': selectedMethods});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: (screenWidth * 0.05)),
                                  height: 33,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: isSelected3B
                                        ? const Color(0XFF7C90D6)
                                        : Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: const Color(0XFF7C90D6),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      label,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected3B
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.01),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        Text(
                          "Study Goals",
                          style: GoogleFonts.outfit(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "What's your secret to making studying fun?",
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.013),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: goals.map((label) {
                          final bool isSelected3C =
                              selectedGoals.contains(label);
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    if (isSelected3C) {
                                      selectedGoals.remove(label);
                                    } else {
                                      selectedGoals.add(label);
                                    }
                                  });
                                  final userDoc = FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.userID);

                                  await userDoc.update(
                                      {'goalsAndPurposes': selectedGoals});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: (screenWidth * 0.05)),
                                  height: 33,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: isSelected3C
                                        ? const Color(0XFF7C90D6)
                                        : Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: const Color(0XFF7C90D6),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      label,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected3C
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.01),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        Text(
                          "Favorite Study Spots",
                          style: GoogleFonts.outfit(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Where do you feel most productive?",
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.013),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: communication.map((label) {
                          final bool isSeleceted = selectedComm.contains(label);
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    if (isSeleceted) {
                                      selectedComm.remove(label);
                                    } else {
                                      selectedComm.add(label);
                                    }
                                  });
                                  final userDoc = FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.userID);

                                  await userDoc.update(
                                      {'CommunicationMethods': selectedComm});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: (screenWidth * 0.05)),
                                  height: 33,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: isSeleceted
                                        ? const Color(0XFF7C90D6)
                                        : Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: const Color(0XFF7C90D6),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      label,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isSeleceted
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (screenHeight * 0.01),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 0,
                    color: Colors.transparent,
                  ),
                  Text(
                    "Academic Strengths",
                    style: GoogleFonts.outfit(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "what are you strong at?",
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (screenHeight * 0.013),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: strength.map((label) {
                    final bool isSeleceted = selectedStrength.contains(label);
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              if (isSeleceted) {
                                selectedStrength.remove(label);
                              } else {
                                selectedStrength.add(label);
                              }
                            });
                            final userDoc = FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userID);

                            await userDoc
                                .update({'strength': selectedStrength});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: (screenWidth * 0.05)),
                            height: 33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isSeleceted
                                  ? const Color(0XFF7C90D6)
                                  : Colors.white,
                              border: Border.all(
                                width: 1,
                                color: const Color(0XFF7C90D6),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                label,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isSeleceted ? Colors.white : Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: (screenHeight * 0.01),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.06)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 0,
                    color: Colors.transparent,
                  ),
                  Text(
                    "Skills",
                    style: GoogleFonts.outfit(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "express yourself",
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (screenHeight * 0.013),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.04)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: skills.map((label) {
                    final bool isSeleceted = selectedComm.contains(label);
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              if (isSeleceted) {
                                selectedSkills.remove(label);
                              } else {
                                selectedSkills.add(label);
                              }
                            });
                            final userDoc = FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userID);

                            await userDoc.update({'skills': selectedSkills});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: (screenWidth * 0.05)),
                            height: 33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isSeleceted
                                  ? const Color(0XFF7C90D6)
                                  : Colors.white,
                              border: Border.all(
                                width: 1,
                                color: const Color(0XFF7C90D6),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                label,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isSeleceted ? Colors.white : Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
         
          ],
        ),
      ),
    );
  }
}
