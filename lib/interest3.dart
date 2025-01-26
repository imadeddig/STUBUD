import 'package:flutter/material.dart';
import 'interest4.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Interest3 extends StatefulWidget {
  final String userID;
  const Interest3({super.key, required this.userID});

  @override
  State<Interest3> createState() => _Interest3State();
}

class _Interest3State extends State<Interest3> {
  bool _isLoading = true;
  List<String> _languages = [];
  Set<String> _selectedLanguages = {};
  final TextEditingController _newLanguageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchLanguages();
  }

  @override
  void dispose() {
    _newLanguageController.dispose();
    super.dispose();
  }

  Future<void> _fetchLanguages() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('interests')
          .doc('interest')
          .get();
      if (docSnapshot.exists) {
        final List<dynamic>? languagesArray = docSnapshot['interest3'];
        if (languagesArray != null) {
          setState(() {
            _languages = List<String>.from(languagesArray);
            _isLoading = false;
          });
        }
      }
    } catch (error) {
      print("Error fetching languages: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.028;
    double progress = (3 / 6);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("interest4");
              },
              child: Text(
                "Skip",
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: verticalPadding),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: (screenWidth * 0.2)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: progress,
                                valueColor: const AlwaysStoppedAnimation(
                                    Color(0XFF7C90D6)),
                                minHeight: 9,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "3/6",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.035),
                    Center(
                      child: Text(
                        "Languages spoken",
                        style: GoogleFonts.outfit(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 21,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.0012),
                    Center(
                      child: Text(
                        "Let them know what that tongue can do",
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.7,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.08),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: (screenWidth * 0.024)),
                      child: Wrap(
                        spacing: 12.0,
                        runSpacing: 12.0,
                        children: _languages.map((language) {
                          final bool isSelected =
                              _selectedLanguages.contains(language);
                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                if (isSelected) {
                                  _selectedLanguages.remove(language);
                                } else {
                                  _selectedLanguages.add(language);
                                }
                              });
                              try {
                                final userDoc = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.userID);

                                await userDoc.update(
                                    {'languagesSpoken': _selectedLanguages});
                              } catch (error) {
                                print(
                                    "Error updating interests in Firestore: $error");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0XFF7C90D6)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0XFF7C90D6),
                                ),
                              ),
                              child: Text(
                                language,
                                style: GoogleFonts.outfit(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: TextField(
                        controller: _newLanguageController,
                        decoration: InputDecoration(
                          hintText: "Add a new language",
                          hintStyle: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
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
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF7C90D6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () async {
                        String newLanguage = _newLanguageController.text.trim();
                        if (newLanguage.isNotEmpty &&
                            !_languages.contains(newLanguage)) {
                          _selectedLanguages.add(newLanguage);
                          _languages.add(newLanguage);
                          _newLanguageController.clear();
                          try {
                            final userDoc = FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userID);

                            await userDoc.update(
                                {'languagesSpoken': _selectedLanguages});
                          } catch (error) {
                            print(
                                "Error updating interests in Firestore: $error");
                          }
                        }
                      },
                      child: Text(
                        "Add Language",
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: screenWidth * 0.06,
                            bottom: (screenHeight * 0.02)),
                        child: InkWell(
                          onTap: () async {
                            if (_selectedLanguages.isNotEmpty) {
                              
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Interest4(
                                    userID: widget.userID,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please select at least one interest.'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: _selectedLanguages.isEmpty
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
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
