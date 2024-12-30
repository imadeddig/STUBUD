import 'package:flutter/material.dart';

class FilteringPage extends StatefulWidget {
  @override
  _FilteringPageState createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  String gender = "Any"; // Default
  RangeValues ageRange = RangeValues(18, 50); // Default age range
  double distance = 10; // Default distance
  String fieldOfStudy = ""; 
  String educationLevel = "School"; // Default
  List<String> interests = [];
  List<String> languages = [];
  List<String> studyTimes = [];
  List<String> studyMethods = [];
  List<String> purposesGoals = [];
  List<String> communicationMethods = [];
  List<String> academicStrengths = [];

  final List<String> sampleOptions = ["Option 1", "Option 2", "Option 3"]; // For simplicity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filter Options")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gender Selector
            ListTile(
              title: Text("Gender"),
              subtitle: DropdownButton<String>(
                value: gender,
                items: ["Any", "Man", "Woman"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
            ),
            
            // Age Range
            ListTile(
              title: Text("Age Range"),
              subtitle: RangeSlider(
                values: ageRange,
                min: 10,
                max: 70,
                divisions: 60,
                labels: RangeLabels(
                  "${ageRange.start.round()}",
                  "${ageRange.end.round()}",
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    ageRange = values;
                  });
                },
              ),
            ),

            // Distance
            ListTile(
              title: Text("Distance (in km)"),
              subtitle: Slider(
                value: distance,
                min: 1,
                max: 100,
                divisions: 99,
                label: "${distance.round()} km",
                onChanged: (value) {
                  setState(() {
                    distance = value;
                  });
                },
              ),
            ),

            // Field of Study
            ListTile(
              title: Text("Field of Study"),
              subtitle: TextField(
                decoration: InputDecoration(hintText: "Enter field of study"),
                onChanged: (value) {
                  setState(() {
                    fieldOfStudy = value;
                  });
                },
              ),
            ),

            // Education Level
            ListTile(
              title: Text("Education Level"),
              subtitle: DropdownButton<String>(
                value: educationLevel,
                items: ["School", "University"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    educationLevel = value!;
                  });
                },
              ),
            ),

            // Multi-select options for lists
            _buildMultiSelect("Interests", interests),
            _buildMultiSelect("Languages Spoken", languages),
            _buildMultiSelect("Study Times", studyTimes),
            _buildMultiSelect("Preferred Study Methods", studyMethods),
            _buildMultiSelect("Purposes and Goals", purposesGoals),
            _buildMultiSelect("Communication Methods", communicationMethods),
            _buildMultiSelect("Academic Strengths", academicStrengths),

            // Apply Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "gender": gender,
                  "ageRange": ageRange,
                  "distance": distance,
                  "fieldOfStudy": fieldOfStudy,
                  "educationLevel": educationLevel,
                  "interests": interests,
                  "languages": languages,
                  "studyTimes": studyTimes,
                  "studyMethods": studyMethods,
                  "purposesGoals": purposesGoals,
                  "communicationMethods": communicationMethods,
                  "academicStrengths": academicStrengths,
                });
              },
              child: Text("Apply Filters"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiSelect(String title, List<String> selectedList) {
    return ListTile(
      title: Text(title),
      subtitle: Wrap(
        spacing: 10,
        children: sampleOptions.map((option) {
          final isSelected = selectedList.contains(option);
          return ChoiceChip(
            label: Text(option),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  selectedList.add(option);
                } else {
                  selectedList.remove(option);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}



class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, dynamic> filters = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              // Navigate to filtering page and await filters
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilteringPage()),
              );

              if (result != null) {
                setState(() {
                  filters = result;
                });
              }
            },
            child: Text("Open Filters"),
          ),
          // Display filters
          if (filters.isNotEmpty)
            Expanded(
              child: ListView(
                children: filters.entries
                    .map((entry) => ListTile(
                          title: Text("${entry.key}:"),
                          subtitle: Text(entry.value.toString()),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
