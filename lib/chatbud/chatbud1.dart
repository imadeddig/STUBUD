import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/farial/settings.dart';
import 'package:stubudmvp/imad/exploreBuddiesPage.dart';
import 'list_messages.dart';

class Chatbud1 extends StatefulWidget {
  const Chatbud1({super.key});

  @override
  _Chatbud1State createState() => _Chatbud1State();
}

class _Chatbud1State extends State<Chatbud1> {
  bool isStudyBuddiesSelected = true;
  int _currentIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  const Explorebuddiespage()), // Replace `ImadPage` with your actual widget
          (route) =>
              false, // This removes all the previous routes from the stack
        );

        break;
      case 1:
        break;
      case 2:
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  const Settings()), // Replace `ImadPage` with your actual widget
          (route) =>
              false, // This removes all the previous routes from the stack
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //  double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChatBud',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 30,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0XFF7C90D6), width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isStudyBuddiesSelected = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isStudyBuddiesSelected
                            ? const Color(0XFF7C90D6)
                            : Colors.transparent, // Highlight if selected
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: Text(
                          'study buddies',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: isStudyBuddiesSelected
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isStudyBuddiesSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isStudyBuddiesSelected
                            ? const Color(0XFF7C90D6)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: Text(
                          'messages',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: !isStudyBuddiesSelected
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          // Search Bar with Filter Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
            height: 35,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'search for study buddies',
                      hintStyle: GoogleFonts.outfit(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: const Color.fromARGB(255, 24, 24, 24),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE8EAF6),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 0, horizontal: screenWidth * 0.035),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color(0XFF7C90D6), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color(0XFF7C90D6), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color(0XFF7C90D6), width: 1),
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Content area
          Expanded(
            child: isStudyBuddiesSelected
                ? _buildStudyBuddiesList(screenWidth)
                : ChatListScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF7C90D6),
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'buddies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'ChatHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'profile',
          ),
        ],
      ),
    );
  }

  // Mock data for Study Buddies
  Widget _buildStudyBuddiesList(double screenwidth) {
    return ListView(
      children: [
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenwidth * 0.025, vertical: 4),
          leading: const CircleAvatar(
            radius: 24, // Adjust the size of the avatar
            backgroundImage:
                AssetImage('images/ae95db324a7d14c53b4d54357312d477.jpg'),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Emily, 19',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              Text(
                'new',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: const Color(0xFF7C90D6),
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'the national higher school of artificial intelligence\nAI & data science - 2nd',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'sidi abdellah, algiers\n~ 15km away',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenwidth * 0.035, vertical: 4),
          leading: const CircleAvatar(
            radius: 24,
            backgroundImage:
                AssetImage('images/ae95db324a7d14c53b4d54357312d477.jpg'),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Emily, 19',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              Text(
                'new',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: const Color(0xFF7C90D6),
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'the national higher school of artificial intelligence\nAI & data science - 2nd',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'sidi abdellah, algiers\n~ 15km away',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider()
      ],
    );
  }

  // Mock data for Messages
}
