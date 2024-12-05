import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Field extends StatefulWidget {
  const Field({super.key});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  String? selectedSpeciality;

  final List<String> specialities = [
    "Artificial Intelligence",
    "Data Science",
    "Software Engineering",
    "Networks",
    "Data Science",
    "Software Engineering",
    "Networks",
  ];

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Title
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Text(
                "Your field of Study Speciality",
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Search Container

            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.width * 0.1,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(124, 144, 214, 0.1),
                      border: Border.all(
                        color: const Color(0xFF7C8FD6),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for interest",
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showFilterDialog(context);
                  },
                  icon: Icon(
                    Icons.tune_outlined,
                    color: Color(0xFF7C8FD6),
                    size: 35,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Specialities List
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
                  children: specialities.map((speciality) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSpeciality = speciality;
                        });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(5),
                                width: 5,
                                child: (selectedSpeciality == speciality)
                                    ? const Icon(
                                        Icons.check,
                                        color: Color(0xFF7C8FD6),
                                      )
                                    : Container(color: Colors.white)),
                            const SizedBox(width: 20),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
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
                                speciality,
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
            SizedBox(height: 40),
          ],
        ),
      ),
    );
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
          color:Colors.white,
          borderRadius: BorderRadius.circular(20),)
          ,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                "Filter Search",
                 style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ))
              ),
              const SizedBox(height: 20),

              // Dropdown for Wilaya
              _buildDropdownRow("Wilaya", "Algiers"),
              const SizedBox(height: 15),

              // Dropdown for School
              _buildDropdownRow("School", "ENSIA - The National School"),
              const SizedBox(height: 15),

              // Dropdown for Speciality
              _buildDropdownRow("Speciality", "Computer Science"),
              const SizedBox(height: 40),

              // Done Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
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
                  textStyle: TextStyle(
                    color: Colors.white,
                    
                  ),),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


// Helper function for dropdown fields using Row
Widget _buildDropdownRow(String label, String defaultValue) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Label
      Expanded(
        flex: 3, // Adjust flex for proper spacing
        child: Text(
          label,
           style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),)
        ),
      ),

      // Dropdown
      Expanded(
        flex: 7, // Adjust flex for proper spacing
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
              color: Color.fromRGBO(124, 144, 214, 0.5),
            )),
          ),
          child: DropdownButton<String>(
            value: defaultValue,
            isExpanded: true,
            underline: const SizedBox(), // Remove underline
            onChanged: (String? newValue) {
              // Handle dropdown change
            },
            items: <String>[defaultValue, "Option 2", "Option 3"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    ],
  );
}