import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stubudmvp/views/screens/profile_and_filtering_screens/moreFilters.dart';
import 'package:stubudmvp/views/screens/signup_login_screens/field.dart';

class Filterpage extends StatefulWidget {

final Map<String, dynamic> initialFilters;
  const Filterpage({super.key, this.initialFilters = const {}});

  @override
  State<Filterpage> createState() => _FilterpageState();
}

class _FilterpageState extends State<Filterpage> {

  List<String> fetchedStudyMethods = [];
  List<String> fetchedCommunicationMethods = [];
  List<String> fetchedAcademicStrenghts = [];
  List<String> fetchedStudyGoals = [];
  List<String> fetchedStudyTimes = [];



  List<String> studyTimes = ["morning", "afternoon", "evening"];
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
  final selectedUni = 'any';
  String selectedField = 'any';
   List<String> selectedInterests = [];
   List<String> selectedLanguages =[];

      
  @override
  void initState() {
    super.initState();


    // Initialize the filter values with the initialFilters passed from the parent
    if (widget.initialFilters.isNotEmpty) {
      selectedGender = widget.initialFilters["gender"] ?? "any gender";
      ageRange = RangeValues(
        widget.initialFilters["ageRange"]["start"] ?? 18,
        widget.initialFilters["ageRange"]["end"] ?? 34,
      );
      distance = widget.initialFilters["distance"] ?? 10;
      selectedInterests = List<String>.from(widget.initialFilters["interests"] ?? []);
      selectedLanguages = List<String>.from(widget.initialFilters["languages"] ?? []);
      selectedStudyTimes = List<String>.from(widget.initialFilters["selectedStudyTimes"] ?? []);
      selectedStudyMethods = List<String>.from(widget.initialFilters["selectedStudyMethods"] ?? []);
      selectedGoals = List<String>.from(widget.initialFilters["selectedGoals"] ?? []);
      selectedCommunicationMethods = List<String>.from(widget.initialFilters["selectedCommunicationMethods"] ?? []);
      selectedAcademicStrenghts = List<String>.from(widget.initialFilters["selectedAcademicStrenghts"] ?? []);
    }


    fetchStudyMethods();
  }

  Future<void> fetchStudyMethods() async {
  try {
    // Fetch the document from the "interests" collection
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('interests')
        .doc('interest') // Specify the document ID if necessary
        .get();

    if (snapshot.exists) {
      // Get the values for each field, which should be lists
      List<dynamic> fetchedMethods = snapshot['studyMethods'] ?? [];
      List<dynamic> fetchedCommunication = snapshot['CommunicationMethods'] ?? [];
      List<dynamic> fetchedStrengths = snapshot['AcademicStrength'] ?? [];
      List<dynamic> fetchedGoals = snapshot['purposesAndGoals'] ?? [];
      List<dynamic> fetchedTimes = snapshot['studyTimes'] ?? [];

      setState(() {
        // Convert dynamic lists to String lists
        fetchedStudyMethods = List<String>.from(fetchedMethods);
        fetchedCommunicationMethods = List<String>.from(fetchedCommunication);
        fetchedAcademicStrenghts = List<String>.from(fetchedStrengths);
        fetchedStudyGoals = List<String>.from(fetchedGoals);
        fetchedStudyTimes = List<String>.from(fetchedTimes);
      });
    }
  } catch (e) {
    print('Error fetching study methods: $e');
  }
}



  
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

  final ageRangeMap = {
    'start': ageRange.start,
    'end': ageRange.end,
  };

 Navigator.pop(context, {
                  "gender": selectedGender,
                  "ageRange": ageRangeMap,
                  "distance": distance,
                  //"fieldOfStudy": fieldOfStudy,
                  //"educationLevel": educationLevel,
                  "interests": selectedInterests,
                  "languages": selectedLanguages,
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
                //! here, there will be a hidden button that shows only when a proper parameter is passed(something indicates that the user is logged in), therefore, hedik l method will be a  pop, popping the needed field.
                //! all other on taps will be hidden, keep ghir the done
                //! same goes for all others.
                onTap: () async {
               selectedField = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Field(userID: '1',)),
              );
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
              //! here since it does not exist, i have to implement page for schools fetching men feriel database,s amee logic
              GestureDetector(
                onTap: () async {
               selectedField = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Field(userID: '1',)),
              );
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
  onTap: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterestsPage(selectedFilterMethod: 'interests'),
      ),
    );

    // Update the selectedInterests if there are returned items
    if (result != null && result is List<String>) {
      setState(() {
        selectedInterests = result;
      });
    }
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
        Expanded(
          child: Text(
            selectedInterests.isNotEmpty
                ? selectedInterests.join(', ') // Display selected interests
                : 'interests', // Default text
            textAlign: TextAlign.start,
            style: GoogleFonts.outfit(
              color: selectedInterests.isNotEmpty
                  ? Colors.black // Change color for selected text
                  : const Color.fromARGB(50, 0, 0, 0),
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis, // Handle long text gracefully
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
  onTap: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterestsPage(selectedFilterMethod: 'languages'),
      ),
    );

    // Update the selectedInterests if there are returned items
    if (result != null && result is List<String>) {
      setState(() {
        selectedLanguages = result;
      });
    }
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
        Expanded(
          child: Text(
            selectedInterests.isNotEmpty
                ? selectedLanguages.join(', ') // Display selected interests
                : 'languages spoken', // Default text
            textAlign: TextAlign.start,
            style: GoogleFonts.outfit(
              color: selectedInterests.isNotEmpty
                  ? Colors.black // Change color for selected text
                  : const Color.fromARGB(50, 0, 0, 0),
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis, // Handle long text gracefully
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
                  children: fetchedStudyTimes
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
                  children:fetchedStudyMethods
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
                  children: fetchedStudyGoals
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
                  children: fetchedCommunicationMethods
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
                  children: fetchedAcademicStrenghts
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