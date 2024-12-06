import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../imad/filterPage.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class buddyProfile extends StatefulWidget {
  const buddyProfile({super.key});

  @override
  State<buddyProfile> createState() => _buddyProfileState();
}

class _buddyProfileState extends State<buddyProfile> {
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushNamed("imad");
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
    
    double screenHeight = MediaQuery.of(context).size.height;
    var isFinished = false;
    
    double appBarHeight = AppBar().preferredSize.height;
    double bottomBarHeight = kBottomNavigationBarHeight;
    double expandedImageHeight =
        screenHeight - appBarHeight - bottomBarHeight - 100;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    
     
      body: Stack(children: [
        CustomScrollView(
          slivers: [
                        SliverAppBar(
              scrolledUnderElevation: 0,
              elevation: 0,
              expandedHeight: screenHeight/2 , 
              pinned: true,
              snap: false,
              floating: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 20, top: 100, bottom: 10),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Emily, 19',
                      style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(
                                  0.9), 
                              offset: const Offset(
                                  5, 5), 
                              blurRadius: 10, 
                            ),
                          ]),
                    ),
                    Text(
                      " - Student At ENSIA",
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        shadows: [
                          Shadow(
                            color: Colors.black
                                .withOpacity(0.9), 
                            offset:
                                Offset(1, 1), 
                            blurRadius: 50, 
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                background: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(16),  
                  child: Image.asset(
                    'images/ae95db324a7d14c53b4d54357312d477.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        
                        Text(
                          'Bio',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Hi! I amm imad, a 19-year-old AI grad student at MIT, I am passionate about developing ethical AI technologies.',
                          style: GoogleFonts.outfit(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        // Interests
                        Text(
                          'Interests',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            Chip(
                              label:  Text(
                                'Coding',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), 
                                side: const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), l
                                  width: 1, 
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'Sports',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor: const Color.fromARGB(22, 124, 143,
                                  214), 
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), 
                                side: const BorderSide(
                                  color: const Color.fromARGB(
                                      66, 0, 0, 0), 
                                  width: 1, 
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'Film Making',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
                                side: const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'Medecine',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const  Color.fromARGB(22, 124, 143,
                                  214), 
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), 
                                side: const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), 
                                  width: 1, 
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'Artificial Intelligence',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), 
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
                                side: const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), 
                                  width: 1, 
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Text(
                          'Value',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            Chip(
                              label: Text(
                                'Integrity',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
                                side: const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, 
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'innovation',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), 
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
                                side:const BorderSide(
                                  color: const Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'honesty',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
                                side:const BorderSide(
                                  color: const Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ],
                        ),

                         SizedBox(
                          height: 15,
                        ),

                        Text(
                          'Languages Spoken',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            Chip(
                              label: Text(
                                'Korean',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
                                side:const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'English',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
                                side:const BorderSide(
                                  color: const Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'Japanesse',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
                                side:const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ],
                        ),

                        // Additional Photos

                        const SizedBox(height: 10),
                        Image.asset(
                          'images/becool.png',
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),

                        Text(
                          'Study Times',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            Chip(
                              label: Text(
                                'Night',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const BorderSide(
                                  color: const Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'Evening',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor: const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ],
                        ),

                        Text(
                          'Preffered Study Methods',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            Chip(
                              label: Text(
                                'group discussions',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const BorderSide(
                                  color: const Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'finding study buddies',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'learning others field',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor: Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side: BorderSide(
                                  color: const Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ],
                        ),

                        Text(
                          'Purposes and goals',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            Chip(
                              label: Text(
                                'networking',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side: const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'finding study buddies',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'learning others field',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor: const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ],
                        ),

                        Text(
                          'Communication Methods',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            Chip(
                              label: Text(
                                'Coffee Shope',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const  BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ],
                        ),

                        Text(
                          'Academic Strenghts',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            Chip(
                              label: Text(
                                'Mahematics',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'Problem Solving',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            Chip(
                              label: Text(
                                'Physics',
                                style: GoogleFonts.outfit(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              backgroundColor:const Color.fromARGB(22, 124, 143,
                                  214), // Background color of the chip
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                side:const BorderSide(
                                  color:  Color.fromARGB(
                                      66, 0, 0, 0), // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        // Location
                        Text(
                          'Algiers, Algeria\n~ 20km away',
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 16.0, // Distance from the top
          right: 16.0, // Distance from the right

          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  blurRadius: 20.0, // Spread of the shadow
                  offset: const Offset(3, 3), // Offset from the widget
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
              
              },
              icon: const Icon(Icons.close),
              color: Colors.black,
            ),
          ),
        ),
      ]),
    );
  }
}
