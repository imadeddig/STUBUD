import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/interest3.dart';

class Interest2 extends StatefulWidget {
  final int userID;

  const Interest2({super.key, required this.userID});

  @override
  State<Interest2> createState() => _Interest2State();
}

class _Interest2State extends State<Interest2> {
  bool isSelected = false;

  final List<String> _labels = [
    'Confidence',
    'Creativity',
    'Integrity',
    'Collaboration',
    'Accountability',
    'Respect',
    'Innovation',
    'Generosity',
    'Compassion',
    'Honest',
    'Respect',
    'Curiosity',
    'Resilience',
    'add others +'
  ];

  final Set<String> _selectedLabels = {'Integrity', 'Respect', 'Honest'};

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verticalPadding = screenHeight * 0.028;
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Interest3(userID:widget.userID)));
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
      body: Stack(
        children: [
          Container(
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
                            valueColor:
                                const AlwaysStoppedAnimation(Color(0XFF7C90D6)),
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
                SizedBox(height: screenHeight * 0.035),
                Center(
                  child: Text(
                    "share your sparkle",
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
                    "what do you value ?",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.7,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.08),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: (screenWidth * 0.015)),
                  child: Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: _labels.map((label) {
                     
                      final bool isSelected = _selectedLabels.contains(
                          label); 
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedLabels.remove(label);
                            } else {
                              _selectedLabels.add(label);
                            }
                          });
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
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          Positioned(
            bottom: screenHeight * 0.041,
            right: screenWidth * 0.06,
            child: InkWell(
              onTap: () {
                if (_selectedLabels.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Interest3(userID:widget.userID)));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: _selectedLabels.isEmpty
                      ? const Color(0XFF7C90D6)
                      : const Color(
                          0XFF5A6EA5), 

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
    );
  }
}
