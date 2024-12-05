import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/imad/exploreBuddiesPage.dart';
import '../imad/deactivatedProfile.dart';

class Filterpage extends StatefulWidget {
  const Filterpage({super.key});

  @override
  State<Filterpage> createState() => _FilterpageState();
}

class _FilterpageState extends State<Filterpage> {
  String selectedGender = "any gender";
  RangeValues ageRange = const RangeValues(18, 34);
  double distance = 10;
  List<String> studyTimes = ["Morning", "Afternoon", "Evening"];
  List<bool> selectedTimes = [
    false,
    true,
    false
  ]; // Default: Afternoon selected
  List<String> selectedMethods = [];
  String purpose = "Study Group Sessions";
  List<String> communicationMethods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              scrolledUnderElevation: 0,
              
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Text(
                  "Study Buddy Finder",
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 0),
                  child: GestureDetector(
                    onTap: () {
  // Add your action here when "Done" is pressed
  print("Done pressed!");
   Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  const Explorebuddiespage()), // Replace `ImadPage` with your actual widget
          (route) =>
              false, // This removes all the previous routes from the stack
        );
},

                    child: Text(
                      "Done",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            // Divider line at the bottom of AppBar
            const Divider(
              thickness: 0, // Thickness of the line
              height: 0, // Height of the divider
              color: Color.fromARGB(53, 0, 0, 0), // Line color
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gender selection
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "What gender do you prefer for your study buddy?",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(116, 0, 0, 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    genderButton("female"),
                    const SizedBox(width: 8),
                    genderButton("male"),
                    const SizedBox(width: 8),
                    genderButton("any gender"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Age range

              Text("What would you want their age range to be?",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(116, 0, 0, 0),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Between: ${ageRange.start.round()} and ${ageRange.end.round()}',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),

              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2.0, 
                  thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius:
                          10), 
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
                  activeTrackColor: Color(0xFF7C90D6), 
                  inactiveTrackColor:
                      const Color.fromARGB(33, 0, 0, 0), 
                  thumbColor: Color(0xFF7C90D6), 
                  overlayColor:
                      Color(0xFF7C90D6), 
                  valueIndicatorColor:
                      Color(0xFF7C90D6),
                ),
                child: RangeSlider(
                  values: ageRange,
                  min: 18,
                  max: 50,
                  divisions: 32,
                  onChanged: (values) {
                    setState(() {
                      ageRange = values;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Distance
              Text("Distance (how far are they)",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(116, 0, 0, 0),
                  )),

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '${distance.round()} kms away',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),

              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2.0, // Adjust this value to lower the height
                  thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius:
                          10), // Adjust the thumb size if needed
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
                  activeTrackColor: Color(0xFF7C90D6), // Active track color
                  inactiveTrackColor:
                      const Color.fromARGB(33, 0, 0, 0), // Inactive track color
                  thumbColor: Color(0xFF7C90D6), // Thumb color
                  overlayColor:
                      Color(0xFF7C90D6), // Overlay color when thumb is touched
                  valueIndicatorColor:
                      Color(0xFF7C90D6), // Value indicator color
                ),
                child: Slider(
                  value: distance,
                  min: 1,
                  max: 50,
                  divisions: 49,
                  onChanged: (value) {
                    setState(() {
                      distance = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 70),

              GestureDetector(
                onTap: () {
                  // Handle field selection
                Navigator.of(context).pushNamed("field");
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'field',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.outfit(
                          color: const Color.fromARGB(50, 0, 0, 0),
                        ),
                      ),
                      Row(
                        children: [
                          Text('select'),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: const Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: const Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              // Gesture Detector for "school/university"
              GestureDetector(
                onTap: () {
                  // Handle school/university selection
                  print("object");
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'school/university',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.outfit(
                          color: const Color.fromARGB(50, 0, 0, 0),
                        ),
                      ),
                      Row(
                        children: [
                          Text('select'),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: const Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              // Gesture Detector for "interests"
              GestureDetector(
                onTap: () {
                  // Handle interests selection
                  print("object");
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'interests',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.outfit(
                          color: const Color.fromARGB(50, 0, 0, 0),
                        ),
                      ),
                      Row(
                        children: [
                          Text('select'),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: const Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              // Gesture Detector for "languages spoken"
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("field");
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'languages spoken',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.outfit(
                          color: const Color.fromARGB(50, 0, 0, 0),
                        ),
                      ),
                      Row(
                        children: [
                          Text('select'),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: const Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Study Methods
              Text("Study Times",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(116, 0, 0, 0),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Allow horizontal scrolling
                child: Row(
                  children: ["Morning", "Afternoon", "Evening", "Night Owl"]
                      .map((method) => Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0), // Add spacing between items
                            child: studyMethodChip(method),
                          ))
                      .toList(),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Text("Preferred Study Methods",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(116, 0, 0, 0),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, 
                child: Row(
                  children: [
                    "silent study",
                    "group discussions",
                    "Timed Quizzes",
                    "Practice Exams",
                    "Study Challenges",
                    "flashcards"
                  ]
                      .map((method) => Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0), 
                            child: studyMethodChip(method),
                          ))
                      .toList(),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Text("Purposes and Goals",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(116, 0, 0, 0),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, 
                child: Row(
                  children: [
                    "Study Group Discussions",
                    "Networking",
                    "finding Study Buddies",
                    "Collaborative Projects",
                    "Motivational boosts",
                    "learning other's fields"
                  ]
                      .map((method) => Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0), // Add spacing between items
                            child: studyMethodChip(method),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              const Text("Communication Methods"),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, 
                child: Row(
                  children: [
                    "Library",
                    "Coffee Shops",
                    "Virtual",
                    "University Cafe",
                    "Dorms",
                    "Co-working Spaces"
                  ]
                      .map((method) => Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0), 
                            child: studyMethodChip(method),
                          ))
                      .toList(),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Text("Academic Strengths",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(116, 0, 0, 0),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, 
                child: Row(
                  children: [
                    "mathematics",
                    "Physics",
                    "Computer Science",
                    "Problem Solving"
                  ]
                      .map((method) => Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0), 
                            child: studyMethodChip(method),
                          ))
                      .toList(),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              const SizedBox(height: 120),

              // Purpose and Goals
            ],
          ),
        ),
      ),
    );
  }

  
  Widget genderButton(String gender) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: selectedGender == gender
              ? Color(0xFF7C90D6)
              : const Color.fromARGB(10, 0, 0, 0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selectedGender == gender
                ? Color(0xFF7C90D6)
                : const Color.fromARGB(255, 88, 88, 88), // Border color
            width: 1, // Border width
          ),
        ),
        child: Text(
          gender,
          style: GoogleFonts.outfit(
              fontSize: 12,
              color: selectedGender == gender ? Colors.white : Colors.black),
        ),
      ),
    );
  }



  Widget studyMethodChip(String method) {
    return FilterChip(
      label: Text(
        method,
        style: TextStyle(
          color: selectedMethods.contains(method)
              ? Colors.white
              : Colors.black,
          fontSize: 14, 
        ),
      ),
      selected: selectedMethods.contains(method),
      selectedColor: Color(0xFF7C90D6), 
      backgroundColor: Color.fromARGB(
          22, 124, 143, 214), 
      padding: const EdgeInsets.symmetric(
          horizontal: 28, vertical: 10), 
      labelPadding: const EdgeInsets.symmetric(
          horizontal: 8), 
      onSelected: (selected) {
        setState(() {
          if (selected) {
            selectedMethods.add(method);
          } else {
            selectedMethods.remove(method);
          }
        });
      },
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      elevation: 2.0, 
    );
  }
}
