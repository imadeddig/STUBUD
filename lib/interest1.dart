import 'package:flutter/material.dart';
import 'interest2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Interest1 extends StatefulWidget {
  final String userID;
  const Interest1({super.key, required this.userID});

  @override
  State<Interest1> createState() => _Interest1State();
}

class _Interest1State extends State<Interest1> {
  List<String> _label = [];
  List<String> _filteredLabel = [];
  final Set<String> _selected5 = {"litterature"};
  bool _isLoading = true;
  final TextEditingController _newInterestController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchInterests();
    _searchController.addListener(() {
      _filterInterests(_searchController.text);
    });
  }

  @override
  void dispose() {
    _newInterestController.dispose();
    super.dispose();
    _searchController.dispose();
  }

  Future<void> _fetchInterests() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('interests')
          .doc('interest')
          .get();
      if (docSnapshot.exists) {
        final List<dynamic>? interestsArray = docSnapshot['interest1'];
        if (interestsArray != null) {
          setState(() {
            _label = List<String>.from(interestsArray);
            _isLoading = false;
            _filteredLabel = List<String>.from(_label);
          });
        }
      }
    } catch (error) {
      print("Error fetching interests: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterInterests(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredLabel = List<String>.from(_label);
      });
    } else {
      setState(() {
        _filteredLabel = _label
            .where((interest) =>
                interest.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.04;
    double progress = (1 / 6);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Interest2(userID: widget.userID),
                  ),
                );
              },
              child: Text(
                "Skip",
                style: GoogleFonts.outfit(
                    color: Colors.black, fontWeight: FontWeight.w800),
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: verticalPadding),
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
                          "1/6",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: (screenHeight * 0.035)),
                  Center(
                    child: Text(
                      "Select your Interests",
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  SizedBox(height: (screenHeight * 0.0012)),
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
                  SizedBox(height: (screenHeight * 0.035)),
                  Container(
                    height: 45,
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.1)),
                    child: TextField(
                      controller: _searchController,
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
                        hintText: "what are you into?",
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
                          padding: EdgeInsets.only(right: (screenWidth * 0.03)),
                          child: const Icon(
                            Icons.search_outlined,
                            color: Color(0XFF7C90D6),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: (screenWidth * 0.014)),
                    child: Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: _filteredLabel.map((label) {
                        final bool isSelected5 = _selected5.contains(label);
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              if (isSelected5) {
                                _selected5.remove(label);
                              } else {
                                _selected5.add(label);
                              }
                            });

                            try {
                                final userDoc = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.userID);

                                await userDoc.update({
                                  'interests': 
                                      _selected5
                                });
                            } catch (error) {
                              print(
                                  "Error updating interests in Firestore: $error");
                            }
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
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Column(
                      children: [
                        TextField(
                          controller: _newInterestController,
                          decoration: InputDecoration(
                            hintText: "Add a new interest",
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
                        const SizedBox(height: 15),
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
                            String newInterest =
                                _newInterestController.text.trim();
                            if (newInterest.isNotEmpty &&
                                !_label.contains(newInterest)) {
                              setState(() {
                                _label.add(newInterest);
                                _selected5.add(newInterest);
                                _newInterestController.clear();
                              });

                              try {
                                final userDoc = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.userID);

                                await userDoc.update({
                                  'interests': 
                                      _selected5
                                });
                              } catch (error) {
                                print(
                                    "Error updating interests in Firestore: $error");
                              }
                            }
                          },
                          child: Text(
                            "Add Interest",
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.041),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: screenWidth * 0.06,
                          bottom: (screenHeight * 0.02)),
                      child: InkWell(
                        onTap: () async {
                          if (_selected5.isNotEmpty) {
                           
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Interest2(
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
                  ),
                ],
              ),
            ),
    );
  }
}
