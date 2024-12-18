import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../farial/complete.dart';

class success extends StatefulWidget {

  final int userID;
  const success ({super.key, required this.userID});

  @override
  State<success> createState() => _successState();
}

class _successState extends State<success> {
  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "Success",
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(124, 144, 214, 1),
                  ),
                ),
              ),
              const SizedBox(height: 10), 
              Text(
                "Phone number verified!",
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.5),
                Padding(
              padding: const EdgeInsets.only(right:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(124, 144, 214, 0.3),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>complete(userID: widget.userID), ),);
                      },
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
