import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Interest4 extends StatefulWidget {
  const Interest4({super.key});

  @override
  State<Interest4> createState() => _Interest4State();
}

class _Interest4State extends State<Interest4> {
  final List<String> _labels3A = ['Morning', 'Afternoon', 'Evening'];
  final List<String> _labels3B = [
    'Silent study',
    'Group discussion',
    'Timed Quizzes'
  ];
  final List<String> _labels3C = [
    'Study group sessions',
    'Networking',
    'Finding study buddies'
  ];
  final List<String> _labels3D = ['Library', 'Coffee shop', 'Online virtual'];

  final Set<String> __selectedLabels3 = {
    'Morning',
    'Group discussion',
    'Timed Quizzes',
    'Study group sessions',
    'Networking',
  };

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
              onPressed: () {
                Navigator.of(context).pushNamed("interest5");
              },
              child: Text(
                "Skip",
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
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
                        "4/6",
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
                      children: _labels3A.map((label) {
                        final bool isSelected3A =
                            __selectedLabels3.contains(label);
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected3A) {
                                    __selectedLabels3.remove(label);
                                  } else {
                                    __selectedLabels3.add(label);
                                  }
                                });
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
                                    color:const Color(0XFF7C90D6),
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
                            SizedBox(
                                width: screenWidth * 0.02), 
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
                      children: _labels3B.map((label) {
                        final bool isSelected3B =
                            __selectedLabels3.contains(label);
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected3B) {
                                    __selectedLabels3.remove(label);
                                  } else {
                                    __selectedLabels3.add(label);
                                  }
                                });
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
                            SizedBox(
                                width: screenWidth * 0.02), 
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
                      children: _labels3C.map((label) {
                        final bool isSelected3C =
                            __selectedLabels3.contains(label);
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected3C) {
                                    __selectedLabels3.remove(label);
                                  } else {
                                    __selectedLabels3.add(label);
                                  }
                                });
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
                            SizedBox(
                                width: screenWidth * 0.02), 
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
                      children: _labels3D.map((label) {
                        final bool isSelected3D =
                            __selectedLabels3.contains(label);
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected3D) {
                                    __selectedLabels3.remove(label);
                                  } else {
                                    __selectedLabels3.add(label);
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: (screenWidth * 0.05)),
                                height: 33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: isSelected3D
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
                                      color: isSelected3D
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: screenWidth * 0.02), 
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.041,
            right: screenWidth * 0.06,
            child: InkWell(
              onTap: () {
                if (__selectedLabels3.isNotEmpty) {
                  Navigator.of(context).pushNamed("interest5");
                }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: __selectedLabels3.isEmpty
                      ? const Color(0XFF7C90D6)
                      : const Color(
                          0XFF5A6EA5), 

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
