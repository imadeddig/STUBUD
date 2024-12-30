import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'filterPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeactivatedProfileScreen(),
    );
  }
}

class DeactivatedProfileScreen extends StatelessWidget {
  const DeactivatedProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.outfit(
                fontSize:
                    40, // Responsive font size // Optional: Customize font family
              ),
              children: const [
                TextSpan(
                  text: 'S',
                  style: TextStyle(
                    color: Color(0xFF7C90D6),
                    fontWeight: FontWeight.bold,
                  ), // Purple color for 'S'
                ),
                TextSpan(
                  text: 'tu',
                  style: TextStyle(color: Colors.black), // Black for 'tu'
                ),
                TextSpan(
                  text: 'B',
                  style: TextStyle(
                    color: Color(0xFF7C90D6),
                    fontWeight: FontWeight.bold,
                  ), // Purple color for 'B'
                ),
                TextSpan(
                  text: 'ud',
                  style: TextStyle(color: Colors.black), // Black for 'ud'
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                top: 50, right: 10), // Adjust icon position
            child: IconButton(
              icon: const Icon(
                Icons.settings, // Replace with your desired icon
                size: 30, // Icon size
                color: Color.fromARGB(255, 0, 0, 0), // Icon color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Filterpage()));
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0), // Padding for the first text
                child: Text(
                  'You Are on a Break... \nYour Profile is Out of Sight',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 20, // Customize font size
                    color: Colors.black,
                    height: 1.1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15), // Padding for the first text
                child: Text(
                  'take your time, whenever you are ready to jump back, \n just flip the switch and jump back into action!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 14, // Customize font size
                    fontWeight: FontWeight.normal,
                    height: 1.1,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0), // Adjust padding as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Add navigation logic here later
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 60),
                    backgroundColor: const Color(0xFF7C90D6),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(100), // Rounded button corners
                    ),
                  ),
                  child: const Text(
                    'Get Back In',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white // Font size for the button text

                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: 30.0), // Add padding above the bottom edge
        child: SizedBox(
          height: 70, // Adjust the height of the BottomNavigationBar

          child: BottomNavigationBar(
            elevation: 0,

            selectedItemColor: const Color(0xFF7C90D6),
            unselectedItemColor:
                const Color.fromARGB(255, 0, 0, 0), // Inactive item color
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
