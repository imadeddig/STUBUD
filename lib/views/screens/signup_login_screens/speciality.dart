import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/views/screens/signup_login_screens/information.dart';
import 'field.dart';
import 'year.dart';

class Speciality extends StatefulWidget {
  final String userID;

  const Speciality({super.key, required this.userID});

  @override
  State<Speciality> createState() => _SpecialityState();
}

class _SpecialityState extends State<Speciality> {
  @override
  Widget build(BuildContext context) {
    
  double screen = MediaQuery.of(context).size.width;

    return Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.015,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF7C90D6)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "0/6",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Text(
                "What is your speciality or sub-speciality within your field of study? *",
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: screen*0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'select speciality',
                      style: GoogleFonts.outfit(
                        textStyle:TextStyle(
                          color: Colors.black,
                          fontSize: screen*0.045,
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                      Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>Field(userID:widget.userID)));
                        
                  }, icon: const Icon(Icons.chevron_right, color: Colors.black),)
                ],
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Text(
                'What year of study are you currently in?',
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: screen*0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

        
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'select the year of study',
                      style: GoogleFonts.outfit(
                        textStyle:  TextStyle(
                          color: Colors.black,
                         fontSize: screen*0.045,
                        ),
                      ),
                    ),
                   IconButton(onPressed: (){
                      Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>  Year(userID:widget.userID)));
                        
                   }, icon: const Icon(Icons.chevron_right, color: Colors.black),)
                  ]),
            ),

            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF7C90D6),
                  borderRadius:
                      BorderRadius.circular(40), 
                ),
                child: MaterialButton(
                  onPressed: () async {
                   
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Infor(userID:widget.userID)));
                  },
                  height: 55,
                  minWidth: 190,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(
                    "Next",
                    style: GoogleFonts.outfit(
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        )
        )
        );
  }
}
