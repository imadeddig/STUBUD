import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubudmvp/views/screens/chatbud_and_report_screens/chatbud1.dart';
import 'package:stubudmvp/views/screens/profile_and_filtering_screens/filterPage.dart';
import 'package:stubudmvp/views/screens/profile_and_filtering_screens/matchHandler.dart';
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
  Map<String, dynamic> filters = {};
  @override
  void initState() {
    print('initial state, users list length is ${_users.length}');
    super.initState();
    // add 3fays that are default comme distance of 30km and gender
    _fetchData();
  }

  Future<void> _fetchData({Map<String, dynamic>? appliedFilters}) async {
    print(appliedFilters);
    setState(() {
      _isLoading = true; // Show loading indicator while fetching data
    });

    int minAge = -1;
    int maxAge = -1;
    double distanceUser = -1;

    try {
      // Fetch the logged-in user's document
      final loggedInUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();
      if (!loggedInUserDoc.exists) {
        throw Exception("Logged-in user document not found");
      }

      // Extract friends list and location
      List<String> friends =
          List<String>.from(loggedInUserDoc.data()?['friendsList'] ?? []);
      final currentUserLocation = loggedInUserDoc.data()?['location'];
      final currentUserInterests = loggedInUserDoc.data()?['interests'] ?? [];
      final currentUserLanguages =
          loggedInUserDoc.data()?['languagesSpoken'] ?? [];
      final currentUserStudyMethods =
          loggedInUserDoc.data()?['preferredStudyMethods'] ?? [];
      final currentUserStudyTimes =
          loggedInUserDoc.data()?['preferredStudyTimes'] ?? [];
      final currentUserGoals = loggedInUserDoc.data()?['studyGoals'] ?? [];
      final currentUserCommunicationMethods =
          loggedInUserDoc.data()?['communicationMethods'] ?? [];

      // Initialize Firestore query
      Query query = FirebaseFirestore.instance.collection('users');

      // Apply filters to the query
      if (appliedFilters != null) {
        if (appliedFilters.containsKey('gender') &&
            appliedFilters['gender'].isNotEmpty) {
              if(appliedFilters['gender'] != 'any gender')
              {
 query = query.where('gender', isEqualTo: appliedFilters['gender']);
              }
         
        }

        if (appliedFilters.containsKey('selectedStudyMethods') &&
            appliedFilters['selectedStudyMethods'].isNotEmpty) {
          query = query.where('preferredStudyMethods',
              arrayContainsAny: appliedFilters['selectedStudyMethods']);
        }
/*
      if (appliedFilters.containsKey('selectedStudyTimes') &&
          appliedFilters['selectedStudyTimes'].isNotEmpty) {
        query = query.where('preferredStudyTimes',
            arrayContainsAny: appliedFilters['selectedStudyTimes']);
      }

      if (appliedFilters.containsKey('selectedGoals') &&
          appliedFilters['selectedGoals'].isNotEmpty) {
        query = query.where('studyGoals', arrayContainsAny: appliedFilters['selectedGoals']);
      }

      if (appliedFilters.containsKey('selectedCommunicationMethods') &&
          appliedFilters['selectedCommunicationMethods'].isNotEmpty) {
        query = query.where('communicationMethods',
            arrayContainsAny: appliedFilters['selectedCommunicationMethods']);
      }

      if (appliedFilters.containsKey('languages') && appliedFilters['languages'].isNotEmpty) {
        query = query.where('languagesSpoken', arrayContainsAny: appliedFilters['languages']);
      }

      if (appliedFilters.containsKey('interests') && appliedFilters['interests'].isNotEmpty) {
        query = query.where('interests', arrayContainsAny: appliedFilters['interests']);
      }
*/
        if (appliedFilters.containsKey('ageRange')) {
          final ageRange = appliedFilters['ageRange'];
          minAge = ageRange['start'].toInt();
          maxAge = ageRange['end'].toInt();
        }

        if (appliedFilters.containsKey('distance')) {
          distanceUser = appliedFilters['distance'];
          print(distanceUser);
        }
      }

      // Fetch users based on the query
      final snapshot = await query.get();
      final documents = snapshot.docs.where((doc) {
        return doc.id != widget.userID && !friends.contains(doc.id);
      }).toList();

      // Process each user
      _users = documents.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Calculate age from dateOfBirth
        DateTime? dateOfBirth;
        int? age;
        if (data.containsKey('dateOfBirth') && data['dateOfBirth'] != null) {
          dateOfBirth = (data['dateOfBirth'] as Timestamp).toDate();
          final now = DateTime.now();
          age = now.year - dateOfBirth.year;
          if (now.month < dateOfBirth.month ||
              (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
            age--;
          }
        }

        // Calculate distance between users
        double? distance;
        if (currentUserLocation != null && data['location'] != null) {
          final currentUserGeoPoint = currentUserLocation as GeoPoint;
          final otherUserGeoPoint = data['location'] as GeoPoint;
          distance = Geolocator.distanceBetween(
                currentUserGeoPoint.latitude,
                currentUserGeoPoint.longitude,
                otherUserGeoPoint.latitude,
                otherUserGeoPoint.longitude,
              ) /
              1000; // Convert to kilometers
        }

        // Calculate similarity score
        int similarityScore = 0;
        final otherUserInterests = data['interests'] ?? [];
        final otherUserLanguages = data['languagesSpoken'] ?? [];
        final otherUserStudyMethods = data['preferredStudyMethods'] ?? [];
        final otherUserStudyTimes = data['preferredStudyTimes'] ?? [];
        final otherUserGoals = data['studyGoals'] ?? [];
        final otherUserCommunicationMethods =
            data['communicationMethods'] ?? [];

        similarityScore += currentUserInterests
            .toSet()
            .intersection(otherUserInterests.toSet())
            .length as int;
        similarityScore += currentUserLanguages
            .toSet()
            .intersection(otherUserLanguages.toSet())
            .length as int;
        similarityScore += currentUserStudyMethods
            .toSet()
            .intersection(otherUserStudyMethods.toSet())
            .length as int;
        similarityScore += currentUserStudyTimes
            .toSet()
            .intersection(otherUserStudyTimes.toSet())
            .length as int;
        similarityScore += currentUserGoals
            .toSet()
            .intersection(otherUserGoals.toSet())
            .length as int;
        similarityScore += currentUserCommunicationMethods
            .toSet()
            .intersection(otherUserCommunicationMethods.toSet())
            .length as int;

        return {
          'userID': doc.id,
          'name': data['fullName'],
          'bio': data['bio'],
          'detail': 'Student at ${data['school']}',
          'image': data['profilePic'] ?? 'default_image.jpg',
          'interests': otherUserInterests,
          'academicStrengths': data['academicStrengths'] ?? [],
          'languagesSpoken': otherUserLanguages,
          'communicationMethods': otherUserCommunicationMethods,
          'preferredStudyMethods': otherUserStudyMethods,
          'preferredStudyTimes': otherUserStudyTimes,
          'studyGoals': otherUserGoals,
          'values': data['values'] ?? [],
          'images': data['images'] ?? [],
          'imagesSize': (data['images'] ?? []).length,
          'dateOfBirth': dateOfBirth,
          'age': age,
          'distance': distance?.toInt() ?? 0,
          'similarity_score': similarityScore,
        };
      }).toList();
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    // Apply additional filters
    if (minAge > 0 && maxAge > 0) {
      _users = _users.where((user) {
        return user['age'] >= minAge && user['age'] <= maxAge;
      }).toList();
    }

/*
_users = _users.where((user) {
  // Ensure that appliedFilters and selectedStudyMethods are not null or empty
  if (appliedFilters?['selectedStudyMethods'] == null ||
      appliedFilters?['selectedStudyMethods'].isEmpty) {
    return true; // No filter applied, keep the user
  }

  // Ensure that user['preferredStudyMethods'] is not null or empty
  List<dynamic> userStudyMethods = user['preferredStudyMethods'] ?? [];
  bool studyMethodsMatch = appliedFilters?['selectedStudyMethods']
      .any((method) => userStudyMethods.contains(method));

  return studyMethodsMatch;
}).toList();
*/

    _users = _users.where((user) {
      // Ensure that appliedFilters and selectedStudyMethods are not null or empty
      if (appliedFilters?['selectedStudyTimes'] == null ||
          appliedFilters?['selectedStudyTimes'].isEmpty) {
        return true; // No filter applied, keep the user
      }

      // Ensure that user['preferredStudyMethods'] is not null or empty
      List<dynamic> userStudyMethods = user['preferredStudyTimes'] ?? [];
      bool studyMethodsMatch = appliedFilters?['selectedStudyTimes']
          .any((method) => userStudyMethods.contains(method));

      return studyMethodsMatch;
    }).toList();

    _users = _users.where((user) {
      // Ensure that appliedFilters and selectedStudyMethods are not null or empty
      if (appliedFilters?['selectedGoals'] == null ||
          appliedFilters?['selectedGoals'].isEmpty) {
        return true; // No filter applied, keep the user
      }

      // Ensure that user['preferredStudyMethods'] is not null or empty
      List<dynamic> userStudyMethods = user['studyGoals'] ?? [];
      bool studyMethodsMatch = appliedFilters?['selectedGoals']
          .any((method) => userStudyMethods.contains(method));

      return studyMethodsMatch;
    }).toList();

    _users = _users.where((user) {
      // Ensure that appliedFilters and selectedStudyMethods are not null or empty
      if (appliedFilters?['selectedCommunicationMethods'] == null ||
          appliedFilters?['selectedCommunicationMethods'].isEmpty) {
        return true; // No filter applied, keep the user
      }

      // Ensure that user['preferredStudyMethods'] is not null or empty
      List<dynamic> userStudyMethods = user['communicationMethods'] ?? [];
      bool studyMethodsMatch = appliedFilters?['selectedCommunicationMethods']
          .any((method) => userStudyMethods.contains(method));

      return studyMethodsMatch;
    }).toList();

    _users = _users.where((user) {
      // Ensure that appliedFilters and selectedStudyMethods are not null or empty
      if (appliedFilters?['languages'] == null ||
          appliedFilters?['languages'].isEmpty) {
        return true; // No filter applied, keep the user
      }

      // Ensure that user['preferredStudyMethods'] is not null or empty
      List<dynamic> userStudyMethods = user['languagesSpoken'] ?? [];
      bool studyMethodsMatch = appliedFilters?['languages']
          .any((method) => userStudyMethods.contains(method));

      return studyMethodsMatch;
    }).toList();

    _users = _users.where((user) {
      // Ensure that appliedFilters and selectedStudyMethods are not null or empty
      if (appliedFilters?['interests'] == null ||
          appliedFilters?['interests'].isEmpty) {
        return true; // No filter applied, keep the user
      }

      // Ensure that user['preferredStudyMethods'] is not null or empty
      List<dynamic> userStudyMethods = user['interests'] ?? [];
      bool studyMethodsMatch = appliedFilters?['interests']
          .any((method) => userStudyMethods.contains(method));

      return studyMethodsMatch;
    }).toList();

    if (distanceUser > 0) {
      _users = _users.where((user) {
        return user['distance'] <= distanceUser;
      }).toList();
    }

    // Sort users by similarity score and distance
    _users.sort((a, b) {
      if (b['similarity_score'] != a['similarity_score']) {
        return b['similarity_score'].compareTo(a['similarity_score']);
      } else {
        return (a['distance'] ?? double.infinity)
            .compareTo(b['distance'] ?? double.infinity);
      }
    });

    print('After filtering and sorting, users list length is ${_users.length}');
    if (_users.isEmpty) {
      noMoreUsers = true;
    }
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
              builder: (context) => Chatbud1(currentUserId:widget.userID)),
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
      print('currently on index $_currentUserIndex');
      if (_currentUserIndex < _users.length - 1) {
        _currentUserIndex = (_currentUserIndex + 1) % _users.length;
      } else {
        print('no more users to show');
        noMoreUsers = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double bottomBarHeight = kBottomNavigationBarHeight;

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
              onPressed: () async {
                // Navigate to filtering page and await filters
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Filterpage(initialFilters: filters)),
                );

                if (result != null) {
                  setState(() async {
                    if (result != null) {
                      setState(() {
                        filters = result; // Update filters
                        _currentUserIndex = 0;
                        noMoreUsers = false;
                      });

                      // Refetch data with new filters
                      await _fetchData(appliedFilters: filters);
                    }
                  });
                }
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : noMoreUsers == false
              ? Stack(
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
                              bottom: bottomBarHeight * 3.4,
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_users[_currentUserIndex]['name'].toString()} - ${_users[_currentUserIndex]['age'].toString()}',
                                  style: GoogleFonts.outfit(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
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
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  " ${_users[_currentUserIndex]['detail']}",
                                  style: GoogleFonts.outfit(
                                    fontSize: 10,
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
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "thid year",
                                  style: GoogleFonts.outfit(
                                    fontSize: 10,
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
                                _users[_currentUserIndex]['image']!,
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
                                      _users[_currentUserIndex]['bio']!,
                                      style: GoogleFonts.outfit(fontSize: 16),
                                    ),
                                    const SizedBox(height: 20),
                                    styledText('Interests'),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: (_users[_currentUserIndex]
                                              ['interests'] as List<dynamic>)
                                          .map((interest) {
                                        return styledChip(
                                            interest.toString(), 20);
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
                                      children: (_users[_currentUserIndex]
                                              ['values'] as List<dynamic>)
                                          .map((interest) {
                                        return styledChip(
                                            interest.toString(), 20);
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
                                      children: (_users[_currentUserIndex]
                                                  ['languagesSpoken']
                                              as List<dynamic>)
                                          .map((interest) {
                                        return styledChip(
                                            interest.toString(), 20);
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 10),
                                    _users[_currentUserIndex]['images'].length >
                                            0 // Check if the array has at least one image
                                        ? Image.asset(
                                            _users[_currentUserIndex]['images'][
                                                0]!, // Only attempt to load the first image if the array size is > 0
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                      children: (_users[_currentUserIndex]
                                                  ['preferredStudyTimes']
                                              as List<dynamic>)
                                          .map((interest) {
                                        return styledChip(
                                            interest.toString(), 10);
                                      }).toList(),
                                    ),
                                    styledText('Preferred Study Methods'),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: (_users[_currentUserIndex]
                                                  ['preferredStudyMethods']
                                              as List<dynamic>)
                                          .map((interest) {
                                        return styledChip(
                                            interest.toString(), 10);
                                      }).toList(),
                                    ),
                                    styledText('Purposes and Goals'),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: (_users[_currentUserIndex]
                                              ['studyGoals'] as List<dynamic>)
                                          .map((interest) {
                                        return styledChip(
                                            interest.toString(), 10);
                                      }).toList(),
                                    ),
                                    styledText('Communication Methods'),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: (_users[_currentUserIndex]
                                                  ['communicationMethods']
                                              as List<dynamic>)
                                          .map((interest) {
                                        return styledChip(
                                            interest.toString(), 10);
                                      }).toList(),
                                    ),
                                    styledText('Academic Strengths'),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: (_users[_currentUserIndex]
                                              ['academicStrengths'] as List<dynamic>)
                                          .map((interest) {
                                        return styledChip(
                                            interest.toString(), 20);
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 10),
                                    _users[_currentUserIndex]['images'].length >
                                            1 // Check if the array has at least one image
                                        ? Image.asset(
                                            _users[_currentUserIndex]['images'][
                                                1]!, // Only attempt to load the first image if the array size is > 0
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return SizedBox
                                                  .shrink(); // Show nothing if the image fails to load
                                            },
                                          )
                                        : SizedBox
                                            .shrink(), // Show nothing if the array is empty

                                    const SizedBox(height: 10),

                                    const SizedBox(height: 20),
                                    Text(
                                      '${_users[_currentUserIndex]['similarity_score']} ${_users[_currentUserIndex]['distance']}km away',
                                      style: GoogleFonts.outfit(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
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
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userID)
                                .update({
                              'slides': FieldValue.arrayUnion([
                                _users[_currentUserIndex]['userID'].toString()
                              ])
                            });
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
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

                            Future.delayed(const Duration(milliseconds: 0),
                                () async {
                              var isMatch = onSwipeButtonPressed(
                                  widget.userID,
                                  _users[_currentUserIndex]['userID']
                                      .toString());
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
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          'No More Students for You to be Study Buddies With in this Area.',
                          style: GoogleFonts.outfit(
                            fontSize: 20, // Customize font size
                            color: Colors.black,
                            height: 1.1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add navigation logic here later
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 60),
                          backgroundColor: const Color(0xFF7C90D6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                100), // Rounded button corners
                          ),
                        ),
                        child: const Text(
                          'Expand More',
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Colors.white // Font size for the button text

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

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Earth's radius in kilometers

  // Convert latitude and longitude from degrees to radians
  double lat1Rad = lat1 * pi / 180;
  double lon1Rad = lon1 * pi / 180;
  double lat2Rad = lat2 * pi / 180;
  double lon2Rad = lon2 * pi / 180;

  // Differences in coordinates
  double deltaLat = lat2Rad - lat1Rad;
  double deltaLon = lon2Rad - lon1Rad;

  // Haversine formula
  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Distance in kilometers
  double distance = earthRadius * c;

  // Optionally, convert to meters if needed
  return distance * 1000; // Returns distance in meters
}
