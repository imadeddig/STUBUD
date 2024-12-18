import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeactivatedProfileScreen extends StatefulWidget {
  const DeactivatedProfileScreen({super.key});

  @override
  _DeactivatedProfileScreenState createState() =>
      _DeactivatedProfileScreenState();
}

class _DeactivatedProfileScreenState extends State<DeactivatedProfileScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushNamed("buddiesPage");
        break;
      case 1:
        Navigator.of(context).pushNamed("chutbud1");
        break;
      case 2:
        Navigator.of(context).pushNamed("settings");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
       
        title: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.outfit(
                fontSize: 40, // Responsive font size
              ),
              children: const [
                TextSpan(
                  text: 'S',
                  style: TextStyle(
                    color: Color(0xFF7C90D6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'tu',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'B',
                  style: TextStyle(
                    color: Color(0xFF7C90D6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'ud',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
       
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  'You Are on a Break... \nYour Profile is Out of Sight',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    color: Colors.black,
                    height: 1.1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'Take your time, whenever you are ready to jump back, \njust flip the switch and jump back into action!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    height: 1.1,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("imad");
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 60),
                    backgroundColor: const Color(0xFF7C90D6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Get Back In',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
}
