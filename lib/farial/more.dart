import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  final List<String> _label = [
    "coding",
    "medecin",
    "astronomy",
    "volunteering",
    "music",
    "tennis",
    "drawing",
    "literature",
    "robotics club",
    "atonomy",
    "book club",
    "film making",
    "basketball",
    "football",
    "DIY"
  ];

  final Set<String> _selected5 = {"literature"};
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.04;

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
                    ))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: verticalPadding),
              child: Column(
                children: [
                  SizedBox(
                    height: (screenHeight * 0.035),
                  ),
                  Center(
                    child: Text(
                      "your Interests",
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.0012),
                  ),
                  Center(
                    child: Text(
                      "find your squad by picking your passions",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.7,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight * 0.035),
                  ),
                  Container(
                    height: 45,
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.1)),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0XFF7C90D6),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0XFF7C90D6),
                              width: 2,
                            ),
                          ),
                          hintText: "what are you into ?",
                          hintStyle: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0XFF7C90D6),
                              width: 1,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          suffixIcon: Padding(
                            padding:
                                EdgeInsets.only(right: (screenWidth * 0.03)),
                            child: const Icon(
                              Icons.search_outlined,
                              color: Color(0XFF7C90D6),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.014)),
                    child: Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: _label.map((label) {
                        final bool isSelected5 = _selected5.contains(label);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected5) {
                                _selected5.remove(label);
                              } else {
                                _selected5.add(label);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: isSelected5
                                  ? const Color(0XFF7C90D6)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                width: 1,
                                color: const Color(0XFF7C90D6),
                              ),
                            ),
                            child: Text(
                              label,
                              style: GoogleFonts.outfit(
                                color:
                                    isSelected5 ? Colors.white : Colors.black,
                                fontWeight: isSelected5
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.041,
              right: screenWidth * 0.06,
              child: InkWell(
                onTap: () {
                  if (_selected5.isNotEmpty) {
                    Navigator.of(context).pushNamed("interest2");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: _selected5.isEmpty
                        ? const Color(0XFF7C90D6)
                        : const Color(0XFF5A6EA5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
