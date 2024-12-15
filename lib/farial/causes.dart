import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class Causes extends StatefulWidget {
  const Causes({super.key});

  @override
  State<Causes> createState() => _CausesState();
}

class _CausesState extends State<Causes> {
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
              "Delete Account ",
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
              "we’re sorry you had to go through that :( we want to understand how to improve your experience. why are you deleting your account ? ",
              style: GoogleFonts.outfit(fontSize: 12),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(thickness: 1.0, color: Colors.grey),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'app crashes too often',
                  style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                       Navigator.of(context).pushNamed("sure");
                    },
                    icon: const Icon(Icons.arrow_forward_ios,
                        size: 18, color: Colors.grey))
              ],
            ),
          ),
          const Divider(thickness: 1.0, color: Colors.grey),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'my matches are gone',
                  style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                       Navigator.of(context).pushNamed("sure");
                    },
                    icon: const Icon(Icons.arrow_forward_ios,
                        size: 18, color: Colors.grey))
              ],
            ),
          ),
          const Divider(thickness: 1.0, color: Colors.grey),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "i'm seeing people more than once",
                  style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                       Navigator.of(context).pushNamed("sure");
                    },
                    icon: const Icon(Icons.arrow_forward_ios,
                        size: 18, color: Colors.grey))
              ],
            ),
          ),
          const Divider(thickness: 1.0, color: Colors.grey),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'horrible UI/UX',
                  style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                       Navigator.of(context).pushNamed("sure");
                    },
                    icon: const Icon(Icons.arrow_forward_ios,
                        size: 18, color: Colors.grey))
              ],
            ),
          ),
          const Divider(thickness: 1.0, color: Colors.grey),
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Other',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFF7C90D6),
                        width: 2,
                      ),
                    ),
                    hintText: "tell us more about what’s happening",
                    hintStyle: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height:50),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF7C90D6),
                borderRadius: BorderRadius.circular(40),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("sure");
                },
                height: 55,
                minWidth: 190,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                  "Continue",
                  style: GoogleFonts.outfit(
                      textStyle: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
