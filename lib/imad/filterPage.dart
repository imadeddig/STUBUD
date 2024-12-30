import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/imad/exploreBuddiesPage.dart';

class Filterpage extends StatefulWidget {

  const Filterpage({super.key});

  @override
  State<Filterpage> createState() => _FilterpageState();
}

class _FilterpageState extends State<Filterpage> {


  List<String> studyTimes = ["Morning", "Afternoon", "Evening"];
  List<bool> selectedTimes = [false, true, false];
  List<String> selectedMethods = [];
  String purpose = "Study Group Sessions";
  List<String> communicationMethods = [];


  RangeValues ageRange = const RangeValues(18, 34);
  double distance = 10;
  String selectedGender = "any gender";
  List<String> selectedStudyTimes = [];
  List<String> selectedStudyMethods = [];
  List<String> selectedGoals = [];
  List<String> selectedCommunicationMethods = [];
  List<String> selectedAcademicStrenghts = [];
  
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
                      print("Done pressed!");


 Navigator.pop(context, {
                  "gender": selectedGender,
                  "ageRange": ageRange,
                  "distance": distance,
                  //"fieldOfStudy": fieldOfStudy,
                  //"educationLevel": educationLevel,
                  //"interests": interests,
                 // "languages": languages,
                  "selectedStudyTimes": selectedStudyTimes,
                  "selectedStudyMethods": selectedStudyMethods,
                  "selectedGoals": selectedGoals,
                  "selectedCommunicationMethods": selectedCommunicationMethods,
                  "selectedAcademicStrenghts": selectedAcademicStrenghts,
                });
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
            const Divider(
              thickness: 0,
              height: 0,
              color: Color.fromARGB(53, 0, 0, 0),
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
                data: const SliderThemeData(
                  trackHeight: 2.0,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
                  activeTrackColor: Color(0xFF7C90D6),
                  inactiveTrackColor: Color.fromARGB(33, 0, 0, 0),
                  thumbColor: Color(0xFF7C90D6),
                  overlayColor: Color(0xFF7C90D6),
                  valueIndicatorColor: Color(0xFF7C90D6),
                ),
                child: RangeSlider(
                  values: ageRange,
                  min: 18,
                  max: 50,
                  divisions: 32,
                  onChanged: (values) {
                    setState(() {
                      ageRange = values;
                      print(ageRange);
                      print(selectedStudyTimes);
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

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
                data: const SliderThemeData(
                  trackHeight: 2.0,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
                  activeTrackColor: Color(0xFF7C90D6),
                  inactiveTrackColor: Color.fromARGB(33, 0, 0, 0),
                  thumbColor: Color(0xFF7C90D6),
                  overlayColor: Color(0xFF7C90D6),
                  valueIndicatorColor: Color(0xFF7C90D6),
                ),
                child: Slider(
                  value: distance,
                  min: 1,
                  max: 50,
                  divisions: 49,
                  onChanged: (value) {
                    setState(() {
                      distance = value;
                      print(distance);
                      print(selectedStudyTimes);
                    });
                  },
                ),
              ),
              const SizedBox(height: 70),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("field");
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                    ),
                  ),
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
                      const Row(
                        children: [
                          Text('select'),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  print("object");
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                    ),
                  ),
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
                      const Row(
                        children: [
                          Text('select'),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                    ),
                  ),
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
                      const Row(
                        children: [
                          Text('select'),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("field");
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(50, 0, 0, 0),
                        width: 1.0,
                      ),
                    ),
                  ),
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
                      const Row(
                        children: [
                          Text('select'),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),

              Text("Study Times",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(116, 0, 0, 0),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ["Morning", "Afternoon", "Evening", "Night Owl"]
                      .map((method) => Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: studyMethodChip(method, selectedStudyTimes),
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(
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
                            padding: const EdgeInsets.only(right: 10.0),
                            child: studyMethodChip(method, selectedStudyMethods),
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(
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
                            padding: const EdgeInsets.only(right: 10.0),
                            child: studyMethodChip(method, selectedGoals),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
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
                            padding: const EdgeInsets.only(right: 20.0),
                            child: studyMethodChip(method, selectedCommunicationMethods),
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(
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
                            padding: const EdgeInsets.only(right: 10.0),
                            child: studyMethodChip(method, selectedAcademicStrenghts),
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              const SizedBox(height: 120),
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
         print(selectedGender);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: selectedGender == gender
              ? const Color(0xFF7C90D6)
              : const Color.fromARGB(10, 0, 0, 0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selectedGender == gender
                ? const Color(0xFF7C90D6)
                : const Color.fromARGB(255, 88, 88, 88),
            width: 1,
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

Widget studyMethodChip(String method, List<String> selectedToFilter) {
  return FilterChip(
    label: Text(
      method,
      style: TextStyle(
        color: selectedToFilter.contains(method) ? Colors.white : Colors.black,
        fontSize: 14,
      ),
    ),
    selected: selectedToFilter.contains(method),
    selectedColor: const Color(0xFF7C90D6),
    backgroundColor: const Color.fromARGB(22, 124, 143, 214),
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
    onSelected: (selected) {
      setState(() {
        if (selected) {
          selectedToFilter.add(method);
        } else {
          selectedToFilter.remove(method);
        }
        print(selectedToFilter); // Debug output to verify changes
      });
    },
    checkmarkColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

}
