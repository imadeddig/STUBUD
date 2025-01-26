import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/farial/speciality.dart';

class Field extends StatefulWidget {
  final String userID;

  const Field({super.key, required this.userID});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  String? selectedField;
  String? selectedWilaya;
  String? selectedUniversity;
  String? selectedSpeciality;
  final List<String> fields = [];
  List<String> filterFields = [];
  List<String> universities = [];
  List<String> specialities = [];
  TextEditingController searchController = TextEditingController();

  final List<String> wilayas = [
    "algiers",
    "annaba",
    "oran",
    "constantine",
    "tlemcen",
    "setif",
    "batna",
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
    searchController.addListener(() {
      _filterFields(searchController.text);
    });
  }

  Future<void> updateFieldsForUniversity(
      String wilaya, String selectedUniversity) async {
    try {
      QuerySnapshot fieldsSnapshot =
          await FirebaseFirestore.instance.collection('fields').get();
      List<String> filteredFields = [];

      for (var doc in fieldsSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        if (data['universities'] != null &&
            data['universities'][wilaya] != null) {
          var universities = data['universities'][wilaya];

          List<String> universitiesList = [];
          if (universities is String) {
            universitiesList.add(universities);
          } else if (universities is List) {
            universitiesList = List<String>.from(universities);
          }

         
          if (universitiesList.contains(selectedUniversity)) {
            filteredFields.add(doc.id); 
          }
        }
      }

      setState(() {
        filterFields = filteredFields; 
      });

      print(
          "Updated Fields for University '$selectedUniversity': $filterFields");
    } catch (e) {
      print("Error updating fields for university '$selectedUniversity': $e");
    }
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot fieldsSnapshot =
          await FirebaseFirestore.instance.collection('fields').get();

      for (var doc in fieldsSnapshot.docs) {
        fields.add(doc.id);
      }

      setState(() {
        filterFields = List.from(fields);
      });
    } catch (e) {
      print("Error fetching fields: $e");
    }
  }

  Future<void> _filterFields(String query) async {
    final results = fields.where((field) {
      return field.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filterFields = List.from(results);
    });
  }

  Future<void> fetchUniversities(String wilaya) async {
    try {
      QuerySnapshot fieldsSnapshot =
          await FirebaseFirestore.instance.collection('fields').get();
      specialities = [];
      List<String> fetchedUniversities = [];
      List<String> fetchedFields = [];

      for (var doc in fieldsSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data['wilayas'] != null &&
            (data['wilayas'] as List).contains(wilaya) &&
            data['universities'] != null) {
          var universities = data['universities'][wilaya];

          if (universities is String) {
            fetchedUniversities.add(universities);
          } else if (universities is List) {
            fetchedUniversities.addAll(List<String>.from(universities));
             fetchedFields.add(doc.id);
          }
        }
      }

      setState(() {
        universities = fetchedUniversities.toSet().toList();
        filterFields = fetchedFields;
      });
      print("Fetched Universities: $universities");
    } catch (e) {
      print("Error fetching universities for Wilaya '$wilaya': $e");
    }
  }

  Future<void> fetchSpeciality(String field) async {
    try {
      DocumentSnapshot fieldSnapshot = await FirebaseFirestore.instance
          .collection('fields')
          .doc(field)
          .get();

      if (fieldSnapshot.exists) {
        List<String> fetchedSpecialities =
            List<String>.from(fieldSnapshot['specialities'] ?? []);

        setState(() {
          specialities = fetchedSpecialities;
        });

        print("Fetched Specialities: $specialities");
      } else {
        print("Field document not found!");
      }
    } catch (e) {
      print("Error fetching specialities: $e");
    }
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Filter Search",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                      selectedUniversity = null;
                      universities = [];
                    });
                    if (value != null) fetchUniversities(value);
                  },
                ),
                const SizedBox(height: 20),
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

                    if (value != null) {
                      updateFieldsForUniversity(selectedWilaya!,
                          value); 
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C8FD6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 40,
                    ),
                  ),
                  child: Text(
                    "Done",
                    style: GoogleFonts.outfit(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                "Your Field of Study Speciality",
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.width * 0.15,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(124, 144, 214, 0.1),
                      border: Border.all(
                        color: const Color(0xFF7C8FD6),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for Field",
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showFilterDialog(context);
                  },
                  icon: const Icon(
                    Icons.tune_outlined,
                    color: Color(0xFF7C8FD6),
                    size: 35,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                  children: filterFields.map((field) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedField = field;
                        });
                        Map<String, dynamic> updatedProfile = {
                          'field': selectedField,
                        };

                        DocumentReference userDoc = FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.userID);
                        await userDoc.update(updatedProfile);
                        fetchSpeciality(field);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(124, 144, 214, 0.5),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 5,
                              margin: const EdgeInsets.only(right: 10),
                              child: selectedField == field
                                  ? const Icon(
                                      Icons.check,
                                      color: Color(0xFF7C8FD6),
                                    )
                                  : Container(),
                            ),
                            Text(
                              field,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
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
            Text("Choose speciality"),
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
                  children: specialities.map((Speciality) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedSpeciality = Speciality;
                        });
                        Map<String, dynamic> updatedProfile = {
                          'specilaity': selectedSpeciality,
                        };

                        DocumentReference userDoc = FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.userID);
                        await userDoc.update(updatedProfile);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(124, 144, 214, 0.5),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 5,
                              margin: const EdgeInsets.only(right: 10),
                              child: selectedSpeciality == Speciality
                                  ? const Icon(
                                      Icons.check,
                                      color: Color(0xFF7C8FD6),
                                    )
                                  : Container(),
                            ),
                            Text(
                              Speciality,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
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
          ],
        ),
      ),
    );
  }
}
