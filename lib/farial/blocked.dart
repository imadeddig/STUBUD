import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class Blocked extends StatefulWidget {
  const Blocked({super.key});

  @override
  State<Blocked> createState() => _BlockedState();
}

class _BlockedState extends State<Blocked> {

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Done",
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF7C90D6),
                      fontWeight: FontWeight.bold
                    ))),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "Blocked Accounts ",
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

           Container(
            padding:const EdgeInsets.all(16),
             child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emily',
                       style: GoogleFonts.outfit(
                            fontSize:16,
                            fontWeight: FontWeight.w600,
                            color:Colors.black
                        ),
                      ),
                      Text(
                        '@emilyintheuk',
                           style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color:Colors.grey
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'unblock',
                      style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color:Colors.black
                        ),
                    ),
                  ),
                ],
              ),
           ),
          
        ],
      )),
    );
  }
}
