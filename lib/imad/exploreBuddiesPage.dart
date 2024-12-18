import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/chatbud/chatbud1.dart';
import 'package:stubudmvp/farial/settings.dart';
import 'package:stubudmvp/imad/filterPage.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class Explorebuddiespage extends StatefulWidget {
  final int userID;
  const Explorebuddiespage ({super.key, required this.userID});

  @override
  State<Explorebuddiespage> createState() => _ExplorebuddiespageState();
}

class _ExplorebuddiespageState extends State<Explorebuddiespage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                   Chatbud1(userID:widget.userID)), 
          (route) =>
              false, 
        );
        break;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                   Settings(userID:widget.userID)), 
          (route) =>
              false,  
        );
        break;
    }
  }

  final List<Map<String, String>> _users = [
    {
      'name': 'Maissa, 22',
      'detail': 'Student at ESI',
      'image': 'images/ae95db324a7d14c53b4d54357312d477.jpg',
    },
    {
      'name': 'Mouna, 20',
      'detail': 'Student at UNIV ALG 01',
      'image': 'images/93766a913ebcc8c70cc49ab515d7f01e.jpg',
    },
    {
      'name': 'Feriel, 25',
      'detail': 'Student at EPAU',
      'image': 'images/844adbebc4ce2fe9b38eec782ca9ac6b.jpg',
    },
    {
      'name': 'Jassmine, 19',
      'detail': 'Student At ENSIA',
      'image': 'images/d09a3b2d9087739c7fcbd1b804f4279d.jpg',
    },
  ];

  int _currentUserIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool isFinished = false;

  void _scrollToTopAndShowNextUser() {
    _scrollController
        .animateTo(
      0, // Position to scroll to
      duration: const Duration(milliseconds: 500), 
      curve: Curves.easeInOut, 
    )
        .then((_) {
      
      Future.delayed(const Duration(milliseconds: 0), () {
        setState(() {
          
        });
      });
    });
  }

  void _showNextUser() {
    setState(() {
      _currentUserIndex = (_currentUserIndex + 1) % _users.length;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    double screenHeight = MediaQuery.of(context).size.height;

    
    double appBarHeight = AppBar().preferredSize.height;

    
    double bottomBarHeight = kBottomNavigationBarHeight;

    var currentUser = _users[_currentUserIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.outfit(fontSize: 40),
              children: const [
                TextSpan(
                  text: 'S',
                  style: TextStyle(
                    color: Color(0xFF7C90D6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: 'tu', style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: 'B',
                  style: TextStyle(
                    color: Color(0xFF7C90D6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: 'ud', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.tune_outlined,
                size: 30, 
                color: Color.fromARGB(255, 0, 0, 0), 
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  Filterpage(userID:widget.userID)));
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                scrolledUnderElevation: 0,
                elevation: 0,
                expandedHeight: screenHeight - bottomBarHeight,
                pinned: true,
                snap: false,
                floating: false,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                    left: 20,
                    top: 20,
                    bottom: bottomBarHeight * 3.2,
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        currentUser['name']!,
                        style: GoogleFonts.outfit(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.9),
                              offset: const Offset(5, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        " - ${currentUser['detail']}",
                        style: GoogleFonts.outfit(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.9),
                              offset: const Offset(1, 1),
                              blurRadius: 50,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  background: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      currentUser['image']!,
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
                                label: Text(
                                  'Coding',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'Medecine',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'innovation',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'honesty',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'English',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'Japanesse',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                            ],
                          ),

                          

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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'Evening',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0),
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0),
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'finding study buddies',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0),
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'learning others field',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124, 143,
                                    214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10),
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0),
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'finding study buddies',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'learning others field',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
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
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'Problem Solving',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0), 
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              Chip(
                                label: Text(
                                  'Physics',
                                  style: GoogleFonts.outfit(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                backgroundColor: const Color.fromARGB(22, 124,
                                    143, 214), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                  side: const BorderSide(
                                    color: Color.fromARGB(
                                        66, 0, 0, 0),
                                    width: 1, 
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                          
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
            top: 16.0, 
            right: 16.0, 
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    0, 255, 255, 255), 
                shape: BoxShape.circle, 
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.4), 
                    blurRadius: 8.0, 
                    offset: const Offset(3, 3), 
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  _showNextUser();

                },
                icon: const Icon(Icons.close, size: 30),
                color:
                    const Color.fromARGB(255, 255, 255, 255), 
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: SwipeableButtonView(
                buttonText: "Slide To Befriend",
                buttonWidget: const Icon(
                  Icons.heart_broken,
                  color: Colors.grey,
                ),
                activeColor: const Color.fromARGB(200, 124, 143, 214),
                isFinished: isFinished,
                onWaitingProcess: () {
                  setState(() {
                    isFinished = false;
                  });
 _showFilterDialog(context);
                  Future.delayed(const Duration(milliseconds: 0), () {
                   
                    _showNextUser();
                    _scrollToTopAndShowNextUser();

                    setState(() {
                      isFinished = true; 
                    });
                  });
                },
                onFinish: () {
                  setState(() {
                    isFinished = false;
                  });
                },
              ),
            ),
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
}

void _showFilterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.45,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Center(
                child: Text("Congrats ! \n You have made a Study Buddy!?",
                textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      fontSize: 13,
                    ))),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("chutbud1", (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C8FD6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 25,
                  ),
                ),
                child: Text(
                  "Start a Conversation",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      fontSize:12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  "keep exploring",
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
