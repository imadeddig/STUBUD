import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:stubudmvp/constant/constant.dart';
import 'interest3.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Interest2 extends StatefulWidget {
  final String userID;
  const Interest2({super.key, required this.userID});

  @override
  State<Interest2> createState() => _Interest2State();
}

class _Interest2State extends State<Interest2> {
  List<String> _label = [];
  final Set<String> _selectedLabels = {"humor"};
  List<String> _filteredLabel = [];
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

  
Future<void> updateUserInterests(String userId, List<String> interests) async {
  final url = Uri.parse('$flaskBaseUrl/update_interests2');
  
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userID': userId, 'values': interests}),
    );

    if (response.statusCode == 200) {
      print('Interests updated successfully');
    } else {
      print('Failed to update interests: ${response.body}');
    }
  } catch (e) {
    print('Error updating interests: $e');
  }
}

 Future<void> _fetchInterests() async {
  try {
    final response = await http.get(Uri.parse('$flaskBaseUrl/fetch_interests2'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _label = List<String>.from(data['interests']);
        _filteredLabel = List<String>.from(_label);
        _isLoading = false;
      });
    } else {
      print("Failed to fetch interests: ${response.body}");
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
    double progress = (2 / 6);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Interest3(userID: widget.userID)));
              },
              child: Text(
                "Skip",
                style: GoogleFonts.outfit(
                    color: Colors.black, fontWeight: FontWeight.w800),
              ),
            ),
          ),
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
                          "2/6",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: (screenHeight * 0.035)),
                  Center(
                    child: Text(
                      "Share your sparkle",
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
                      "What do you value?",
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
                      textAlignVertical: TextAlignVertical.center,
                      controller: _searchController,
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
                        hintText: "what are your values?",
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
                        final bool isSelected = _selectedLabels.contains(label);
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              if (isSelected) {
                                _selectedLabels.remove(label);
                              } else {
                                _selectedLabels.add(label);
                              }
                            });
                            try {
                                await updateUserInterests(widget.userID, _selectedLabels.toList());
                              } catch (error) {
                                print(
                                    "Error updating interests in Firestore: $error");
                              }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
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
                              label,
                              style: GoogleFonts.outfit(
                                color: isSelected ? Colors.white : Colors.black,
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
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Column(
                      children: [
                        TextField(
                          controller: _newInterestController,
                          decoration: InputDecoration(
                            hintText: "add a new value",
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
                                _selectedLabels.add(newInterest);
                                _newInterestController.clear();
                              });
                               try {
                                final userDoc = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.userID);

                                await userDoc.update({
                                  'values': 
                                      _selectedLabels
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: screenWidth * 0.06,
                          bottom: (screenHeight * 0.02)),
                      child: InkWell(
                        onTap: () async {
                          if (_selectedLabels.isNotEmpty) {
                      
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Interest3(
                                  userID: widget.userID,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
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
                            color: _selectedLabels.isEmpty
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
