import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/chatbud/chatbud1.dart';
import 'package:stubudmvp/imad/filterPage.dart';
import 'package:stubudmvp/imad/matchHandler.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

//import 'package:stubudmvp/farial/settings.dart';

class Explorebuddiespage extends StatefulWidget {
  final String userID;
  const Explorebuddiespage({super.key, required this.userID});

  @override
  State<Explorebuddiespage> createState() => _ExplorebuddiespageState();
}

class _ExplorebuddiespageState extends State<Explorebuddiespage> {
  // TODO: implement print
  bool displayMatchMessage = false;
  bool noMoreUsers = false;
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    print('initial state, users list length is ${ _users.length}');
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      //print('UserID: ${widget.userID}');
      final loggedInUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();
      if (!loggedInUserDoc.exists) {
        throw Exception("Logged-in user document not found");
      }

      List<String> friends =
          List<String>.from(loggedInUserDoc.data()?['friendsList'] ?? []);

      final snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      final documents = snapshot.docs
          .where((doc) =>
              doc.id != widget.userID &&
              !friends.contains(doc.id)) // Exclude logged-in user and friends
          .toList();

      //  FirebaseFirestore firestore = FirebaseFirestore.instance;

      //Create a document reference to the "users" collection
      // CollectionReference users = firestore.collection('users');

      _users = documents.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'userID': doc.id, // Add the userID here
          'name': data['fullName'],
          'bio': data['bio'],
          'detail': 'Student at ${data['school']}',
          'image': data['profilePic'] ?? 'default_image.jpg',
          'interests': data['interests'] ?? [],
          'academicStrengths': data['academic strengths'] ?? [],
          'languagesSpoken': data['languagesSpoken'] ?? [],
          'communicationMethods': data['communicationMethods'] ?? [],
          'preferredStudyMethods': data['preferredStudyMethods'] ?? [],
          'preferredStudyTimes': data['preferredStudyTimes'] ?? [],
          'studyGoals': data['studyGoals'] ?? [],
          'values': data['values'] ?? [],
          'images': data['images'] ?? [],
          'imagesSize': (data['images'] ?? []).length,
        };
      }).toList();
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
        print('after getting data from database, users list length is ${ _users.length}');
  }
  

  Widget styledText(String text) {
    return Text(
      text,
      style: GoogleFonts.outfit(
        color: const Color.fromARGB(133, 0, 0, 0),
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget styledChip(String label, double borderRadius) {
    // Custom algorithm for border radius based on input factor
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.outfit(
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      backgroundColor: const Color.fromARGB(22, 124, 143, 214),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: const BorderSide(
          color: Color.fromARGB(66, 0, 0, 0),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

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
              builder: (context) => Chatbud1(userID: widget.userID)),
          (route) => false,
        );
        break;
        /*  case 2:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                   Settings(userID:widget.userID)), 
          (route) =>
              false,  
        );
        */
        break;
    }
  }

  int _currentUserIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool isFinished = false;

  Object? get userID => null;

  void _scrollToTopAndShowNextUser() {
    _scrollController
        .animateTo(
      0, // Position to scroll to
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    )
        .then((_) {
      Future.delayed(const Duration(milliseconds: 0), () {
        setState(() {});
      });
    });
  }

  void _showNextUser() {
    setState(() {
          print('currently on index ${ _currentUserIndex}');
          if(_currentUserIndex<_users.length-1)
          {
      _currentUserIndex = (_currentUserIndex + 1) % _users.length;
          }
          else{
            print('no more users to show');
             noMoreUsers=true;
          }

    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double appBarHeight = AppBar().preferredSize.height;

    double bottomBarHeight = kBottomNavigationBarHeight;

    var currentUser = _users[_currentUserIndex];
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
                        builder: (context) =>
                            Filterpage(userID: widget.userID)));
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: noMoreUsers==false? Stack(
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
                        currentUser['name'].toString()!,
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
                          styledText('Bio'),
                          const SizedBox(height: 2),
                          Text(
                            currentUser['bio']!,
                            style: GoogleFonts.outfit(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          styledText('Interests'),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children:
                                (currentUser['interests'] as List<dynamic>)
                                    .map((interest) {
                              return styledChip(interest.toString(), 20);
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          styledText('value'),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: (currentUser['values'] as List<dynamic>)
                                .map((interest) {
                              return styledChip(interest.toString(), 20);
                            }).toList(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          styledText('Languages Spoken'),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: (currentUser['languagesSpoken']
                                    as List<dynamic>)
                                .map((interest) {
                              return styledChip(interest.toString(), 20);
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                          currentUser['images'].length >
                                  0 // Check if the array has at least one image
                              ? Image.asset(
                                  currentUser['images'][
                                      0]!, // Only attempt to load the first image if the array size is > 0
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SizedBox
                                        .shrink(); // Show nothing if the image fails to load
                                  },
                                )
                              : SizedBox
                                  .shrink(), // Show nothing if the array is empty

                          const SizedBox(height: 10),
                          styledText('Study Times'),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: (currentUser['preferredStudyTimes']
                                    as List<dynamic>)
                                .map((interest) {
                              return styledChip(interest.toString(), 10);
                            }).toList(),
                          ),
                          styledText('Preferred Study Methods'),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: (currentUser['preferredStudyMethods']
                                    as List<dynamic>)
                                .map((interest) {
                              return styledChip(interest.toString(), 10);
                            }).toList(),
                          ),
                          styledText('Purposes and Goals'),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children:
                                (currentUser['studyGoals'] as List<dynamic>)
                                    .map((interest) {
                              return styledChip(interest.toString(), 10);
                            }).toList(),
                          ),
                          styledText('Communication Methods'),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: (currentUser['communicationMethods']
                                    as List<dynamic>)
                                .map((interest) {
                              return styledChip(interest.toString(), 10);
                            }).toList(),
                          ),
                          styledText('Academic Strengths'),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children:
                                (currentUser['interests'] as List<dynamic>)
                                    .map((interest) {
                              return styledChip(interest.toString(), 20);
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                          currentUser['images'].length >
                                  1 // Check if the array has at least one image
                              ? Image.asset(
                                  currentUser['images'][
                                      1]!, // Only attempt to load the first image if the array size is > 0
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SizedBox
                                        .shrink(); // Show nothing if the image fails to load
                                  },
                                )
                              : SizedBox
                                  .shrink(), // Show nothing if the array is empty

                          const SizedBox(height: 10),

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
                color: const Color.fromARGB(0, 255, 255, 255),
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
                color: const Color.fromARGB(255, 255, 255, 255),
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

                  // _showFilterDialog(context);

                  Future.delayed(const Duration(milliseconds: 0), () async {
                    var isMatch = onSwipeButtonPressed(
                        '${widget.userID}', currentUser['userID'].toString()!);
                    if (await isMatch) {
                      showMatchMessage(context);
                    }
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
      ): Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              textAlign: TextAlign.center,
              'No More Students for You to be Study Buddies With in this Area.',   style: GoogleFonts.outfit(
              
              fontSize: 20, // Customize font size
              color: Colors.black,
               height: 1.1,
              fontWeight: FontWeight.w600,
            ),),
          ),
           ElevatedButton(
    onPressed: () {
      // Add navigation logic here later
    },
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 60),
      backgroundColor: const Color(0xFF7C90D6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100), // Rounded button corners
      ),
    ),
    child: const Text(
      'Expand More',
      style: TextStyle(
        fontSize: 16, 
        color: Colors.white// Font size for the button text

      ),
    ),
  ),
        ],
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
