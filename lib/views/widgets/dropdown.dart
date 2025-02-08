import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WilayaUniversitySpecialtyDropdown extends StatefulWidget {
  const WilayaUniversitySpecialtyDropdown({super.key});

  @override
  _WilayaUniversitySpecialtyDropdownState createState() =>
      _WilayaUniversitySpecialtyDropdownState();
}

class _WilayaUniversitySpecialtyDropdownState
    extends State<WilayaUniversitySpecialtyDropdown> {
  List<String> wilayas = [
    "algiers",
    "annaba",
    "oran",
    "constantine",
    "tlemcen",
    "setif",
    "batna"
  ];

  List<String> universities = [];

  String? selectedWilaya;
  String? selectedUniversity;

  @override
  void initState() {
    super.initState();
  }
Future<void> fetchUniversities(String wilaya) async {
  try {
    QuerySnapshot fieldsSnapshot =
        await FirebaseFirestore.instance.collection('fields').get();

    print("Number of documents: ${fieldsSnapshot.docs.length}");

    List<String> fetchedUniversities = [];
    List<Map<String, dynamic>> filteredFields = []; 

    for (var doc in fieldsSnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      if (data['wilayas'] != null &&
          (data['wilayas'] as List).contains(wilaya)) {
        List<String> universitiesForWilaya =
            List<String>.from(data['universities'][0][wilaya] ?? []);
        fetchedUniversities.addAll(universitiesForWilaya);

        filteredFields.add(data);
      }
    }
    setState(() {
      universities = fetchedUniversities.toSet().toList(); 
    });
  } catch (e) {
    print("Error fetching universities: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Wilaya Dropdown
        DropdownButton<String>(
          isExpanded: true,
          value: selectedWilaya,
          hint: const Text("Select Wilaya"),
          items: wilayas.map((wilaya) {
            return DropdownMenuItem(
              value: wilaya,
              child: Text(wilaya),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedWilaya = value;
              selectedUniversity = null;  // Reset university
              universities = [];  // Clear previous universities
            });
            if (value != null) fetchUniversities(value);
          },
        ),
        const SizedBox(height: 20),

        // University Dropdown
        DropdownButton<String>(
          isExpanded: true,
          value: selectedUniversity,
          hint: const Text("Select University"),
          items: universities.map((university) {
            return DropdownMenuItem(
              value: university,
              child: Text(university),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedUniversity = value;
            });
          },
        ),
      ],
    );
  }
}
