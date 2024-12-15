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
                    child: const TextField(
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
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

void showFilterDialog(BuildContext context) {
  
  double screen = MediaQuery.of(context).size.width;

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
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             
              Text(
                "Filter Search",
                 style: GoogleFonts.outfit(
                  textStyle:  TextStyle(
                    color: Colors.black,
                    fontSize: screen*0.05,
                    fontWeight: FontWeight.bold,
                  ))
              ),
              const SizedBox(height: 20),

             
              _buildDropdownRow("Wilaya", "Algiers"),
              const SizedBox(height: 15),

             
              _buildDropdownRow("School", "ENSIA - The National School"),
              const SizedBox(height: 15),

              
              _buildDropdownRow("Speciality", "Computer Science"),
              const SizedBox(height: 40),

             
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



Widget _buildDropdownRow(String label, String defaultValue) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
     
      Expanded(
        flex: 3, 
        child: Text(
          label,
           style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),)
        ),
      ),

 
      Expanded(
        flex: 7, 
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
              color: Color.fromRGBO(124, 144, 214, 0.5),
            )),
          ),
          child: DropdownButton<String>(
            value: defaultValue,
            isExpanded: true,
            underline: const SizedBox(), 
            onChanged: (String? newValue) {
             
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
