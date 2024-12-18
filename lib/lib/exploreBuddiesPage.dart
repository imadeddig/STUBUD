import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'filterPage.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class Explorebuddiespage extends StatefulWidget {
  const Explorebuddiespage({super.key});

  @override
  State<Explorebuddiespage> createState() => _ExplorebuddiespageState();
}

class _ExplorebuddiespageState extends State<Explorebuddiespage> {
  @override
  Widget build(BuildContext context) {
        // Get screen height
    double screenHeight = MediaQuery.of(context).size.height;
var isFinished = false;
    // Get AppBar height
    double appBarHeight = AppBar().preferredSize.height;

    // Get BottomNavigationBar height
    double bottomBarHeight = kBottomNavigationBarHeight;


    // Calculate the height for the expanded image
    double expandedImageHeight = screenHeight - appBarHeight - bottomBarHeight - 100;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
           scrolledUnderElevation: 0,
           elevation: 0,
        toolbarHeight: 120,
        title:
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.outfit(
                fontSize: 40, // Responsive font size // Optional: Customize font family
              ),
              children: const [
                TextSpan(
          text: 'S',
          style: TextStyle(color: Color(0xFF7C90D6), fontWeight: FontWeight.bold,), // Purple color for 'S'
           
                ),
                TextSpan(
          text: 'tu',
          style: TextStyle(color: Colors.black), // Black for 'tu'
                ),
                TextSpan(
          text: 'B',
          style: TextStyle(color: Color(0xFF7C90D6), fontWeight: FontWeight.bold,), // Purple color for 'B'
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
        padding: const EdgeInsets.only(top: 50, right: 10), // Adjust icon position
        child: IconButton(
          icon: const Icon(
            Icons.settings, // Replace with your desired icon
            size: 30, // Icon size
            color: Color.fromARGB(255, 0, 0, 0), // Icon color
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Filterpage()));
          },
        ),
      ),
        ],
      ),
      
      body: Stack(
        children: [ CustomScrollView(
          
          
          slivers: [
            // Sliver AppBar
            
            SliverAppBar(
               scrolledUnderElevation: 0,
              elevation: 0,
              expandedHeight: expandedImageHeight, // Height of the image
              pinned: true,
              snap: false,
              floating: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                
                titlePadding: const EdgeInsets.only(left:20, top:20, bottom: 110),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Emily, 19',
                      style: GoogleFonts.outfit(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255),
                         shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.9), // Shadow color with opacity
          offset: const Offset(5, 5), // Horizontal and vertical offset
          blurRadius: 10, // How blurry the shadow should be
        ),]
                      ),
                      
                    ),
                    Text(" - Student At ENSIA",  style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 255, 255, 255),
                          shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.9), // Shadow color with opacity
          offset: const Offset(1, 1), // Horizontal and vertical offset
          blurRadius: 50, // How blurry the shadow should be
        ),
            ],
                      ),)
                  ],
                ),
                
                
                
                background: ClipRRect(
          borderRadius: BorderRadius.circular(16), // Adjust radius as needed
          child: Image.asset(
            'assets/emily.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
              ),
            ),
            // SliverList for the scrollable content
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                       
                        // Bio
                        Text(
                          'Bio',
                          style: GoogleFonts.outfit(
                            color: const Color.fromARGB(133, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text('Hi! I amm Amani, a 19-year-old AI grad student at MIT, I am passionate about developing ethical AI technologies.',
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
                            Chip(label: Text('Coding',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                             Chip(label: Text('Sports',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                           Chip(label: Text('Film Making',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            Chip(label: Text('Medecine',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                           Chip(label: Text('Artificial Intelligence',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          ],
                        ),
                       
                       const SizedBox(height: 15,),
        
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
                            Chip(label: Text('Integrity',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                             Chip(label: Text('innovation',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                           Chip(label: Text('honesty',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          
                         
                          ],
                        ),
                       
                       const SizedBox(height: 15,),
        
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
                            Chip(label: Text('Korean',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                             Chip(label: Text('English',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                           Chip(label: Text('Japanesse',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          
                         
                          ],
                        ),
                       
                        // Additional Photos
                      
                        const SizedBox(height: 10),
                        Image.asset(
                          
                          'assets/emily.jpg',
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
                            Chip(label: Text('Night',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                             Chip(label: Text('Evening',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            Chip(label: Text('group discussions',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                             Chip(label: Text('finding study buddies',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                           Chip(label: Text('learning others field',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            Chip(label: Text('networking',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                             Chip(label: Text('finding study buddies',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                           Chip(label: Text('learning others field',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            Chip(label: Text('Coffee Shope',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            Chip(label: Text('Mahematics',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                             Chip(label: Text('Problem Solving',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                           Chip(label: Text('Physics',  style: GoogleFonts.outfit(color: const Color.fromARGB(255, 0, 0, 0)),),
                             backgroundColor: const Color.fromARGB(22, 124, 143, 214), // Background color of the chip
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            side: const BorderSide(
        color: Color.fromARGB(66, 0, 0, 0), // Border color
        width: 1, // Border width
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        const SizedBox(height: 30),
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
                    print('Floating Icon Pressed');
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black ,
                  
                  
                ),
              ),
            ),




    Positioned(
      bottom: 0,  // Adjust this value to your desired bottom spacing
      left: 10,    // Adjust this value to control the horizontal position
      right: 10,   // Adjust this value to control the horizontal position
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
       
        child: SwipeableButtonView(
          buttonText: "Slide To Befriend",
          buttonWidget: Container(
            child: const Icon(
              Icons.heart_broken,
              color: Colors.grey,
            ),
          ),
          activeColor: const Color.fromARGB(132, 124, 143, 214),
          isFinished: isFinished,
          onWaitingProcess: () {
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                isFinished = true;
              });
            });
          },
          onFinish: () async {
            // Add your logic here for after the button is finished
          },
        ),
      ),
    )        ,
      
            Positioned(child: Container(

            ))
        
        
        ]
      ),
       bottomNavigationBar: Padding(
    padding: const EdgeInsets.only(bottom: 30.0), // Add padding above the bottom edge
    child: SizedBox(
      height: 70, // Adjust the height of the BottomNavigationBar
      
      child: BottomNavigationBar(
      
        elevation:0,
       
        selectedItemColor: const Color(0xFF7C90D6),
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0), // Inactive item color
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

