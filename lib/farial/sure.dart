import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/welcome.dart';

class Sure extends StatefulWidget {
  const Sure({super.key});

  @override
  State<Sure> createState() => _SureState();
}

class _SureState extends State<Sure> {
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
                child: Text("Cancel",
                    style: GoogleFonts.outfit(
                        color: const Color(0xFF7C90D6),
                        fontWeight: FontWeight.bold))),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "100% sure of your decision ? ",
              textAlign: TextAlign.start,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "your profile, messages, photos and study buddies will vanish into thin air, never to be seen again",
              style: GoogleFonts.outfit(fontSize: 12),
            ),
          ),
const SizedBox(height:20),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "this decision is final- once it’s gone, it’s gone for good.",
              style: GoogleFonts.outfit(fontSize: 12),
            ),
          ),
          const SizedBox(height:30),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "But wait ! if you’re not ready for such a big move, why not go undercover instead? you can hide your account and reappear whenever you like, just flip the switch in your settings",
              style: GoogleFonts.outfit(fontSize: 12),
            ),
          ),
         
         
          const SizedBox(
            height: 100,
          ),
         
                  
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF7C90D6),
                borderRadius: BorderRadius.circular(40),
              ),
              child: MaterialButton(
                onPressed: () {
                   Navigator.of(context).pushNamed("mainpage");
                },
                height: 55,
                minWidth: 190,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                  "Desactivate account",
                  style: GoogleFonts.outfit(
                      textStyle: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),

            Center(
           
              child: TextButton(onPressed: (){
                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const Welcome(),
                                      ),
                                    );
              }, child: Text("delete account" ,style: GoogleFonts.outfit(
                        color: Colors.red,
                        fontWeight: FontWeight.bold)))
            ),
          
        ],
      )),
    );
  }
}
