import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'messages_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:stubudmvp/constant/constant.dart';
import 'package:stubudmvp/views/screens/profile_and_filtering_screens/exploreBuddiesPage.dart';
import 'dart:convert';
import 'app_state.dart';
import '../settings_screens/settings.dart';
import 'package:intl/intl.dart';

class Chatbud1 extends StatefulWidget {
  final String currentUserId;

  const Chatbud1({super.key, required this.currentUserId});

  @override
  _Chatbud1State createState() => _Chatbud1State();
}

class _Chatbud1State extends State<Chatbud1> {
  bool isStudyBuddiesSelected = true;
  int _currentIndex = 1;
  List<Map<String, dynamic>> friendsList = [];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  Explorebuddiespage(userID: widget.currentUserId,)),
          (route) =>
              false,
        );

        break;
      case 1:
        break;
      case 2:
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
              Settings2(userID:widget.currentUserId)
               ), // Replace `ImadPage` with your actual widget
          (route) =>
              false, // This removes all the previous routes from the stack
        );
        break;
    }
  }

@override
void initState() {
  super.initState();
  fetchFriendsData();

  AppState.refreshChatList.addListener(_handleChatListRefresh);
}

void _handleChatListRefresh() {
  if (AppState.refreshChatList.value) {
    if (mounted) { // Ensure the widget is still in the tree
      setState(() {});
    }
    AppState.refreshChatList.value = false;
    print(AppState.refreshChatList.value);
  }
}

@override
void dispose() {
  AppState.refreshChatList.removeListener(_handleChatListRefresh); // Remove listener
  super.dispose();
}

  void fetchFriendsData() {
  FirebaseFirestore.instance
      .collection('users') 
      .doc(widget.currentUserId)
      .snapshots()
      .listen((DocumentSnapshot snapshot) async {
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
      List<dynamic> friends = userData?['friends'] ?? [];
      List<Map<String, dynamic>> tempFriendsList = [];
      print(friends);
      for (String friendId in friends) {
        print("Fetching data for friend: $friendId");
        final friendResponse = await http.get(
          Uri.parse('$flaskBaseUrl/get_user/$friendId'),
        );

        if (friendResponse.statusCode == 200) {
          Map<String, dynamic> friendData = jsonDecode(friendResponse.body);
          print("friendData $friendData");
          friendData['id'] = friendId;
          tempFriendsList.add(friendData);
        }
        print("tempFreind : $tempFriendsList");
      }

      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          friendsList = tempFriendsList;
        });
      }
    }
  }, onError: (error) {
    print("Error fetching friends data: $error");
  });
}


  @override
  Widget build(BuildContext context) {
    //  double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
                            : Colors.transparent,
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
                : ChatListPage(currentUserID: widget.currentUserId),
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

  Widget _buildStudyBuddiesList(double screenWidth) {
    List reversedFriendsList = List.from(friendsList.reversed);
    print("reversed list : $reversedFriendsList");
    return reversedFriendsList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : LayoutBuilder(
            builder: (context, constraints) {
              print("reversed list : $reversedFriendsList");
              return ListView.builder(
                itemCount: reversedFriendsList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final friend = reversedFriendsList[index];

                  return GestureDetector(
                    onTap: () async {
                      try {
                        final response = await http.get(
                          Uri.parse(
                              '$flaskBaseUrl/get_chats/${widget.currentUserId}'),
                        );

                        if (response.statusCode == 200) {
                          List<dynamic> chats = jsonDecode(response.body);

                          Map<String, dynamic>? chatSession;

                          for (var chat in chats) {
                            if ((chat['user1ID'] == widget.currentUserId &&
                                    chat['user2ID'] == friend['id']) ||
                                (chat['user1ID'] == friend['id'] &&
                                    chat['user2ID'] == widget.currentUserId)) {
                              chatSession = chat;
                              break;
                            }
                          }

                          if (chatSession == null) {
                            final createResponse = await http.post(
                              Uri.parse('$flaskBaseUrl/create_chat'),
                              headers: {'Content-Type': 'application/json'},
                              body: jsonEncode({
                                'user1ID': widget.currentUserId,
                                'user2ID': friend['id'],
                              }),
                            );

                            if (createResponse.statusCode == 200) {
                              chatSession = jsonDecode(createResponse.body);
                            } else {
                              throw 'Error creating chat: ${createResponse.body}';
                            }
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                chatID: chatSession!['id'],
                                currentUserID: widget.currentUserId,
                                receiverUsername: friend['username'],
                                receiverAvatarUrl: friend['profilePicture'] ??
                                    'https://th.bing.com/th/id/R.d064a09d90d5c177c4813b582941c189?rik=oRNqtsfDamTI7Q&pid=ImgRaw&r=0',
                              ),
                            ),
                          );
                        } else {
                          if (kDebugMode) {
                            print('Error fetching chats: ${response.body}');
                          }
                        }
                      } catch (error) {
                        if (kDebugMode) {
                          print('Error checking or creating chat: $error');
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Error creating chat: $error')),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025, vertical: 4),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundImage: friend['profilePicture'] != null
                                ? NetworkImage(friend['profilePicture'])
                                : const NetworkImage(
                                        'https://th.bing.com/th/id/R.d064a09d90d5c177c4813b582941c189?rik=oRNqtsfDamTI7Q&pid=ImgRaw&r=0')
                                    as ImageProvider,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${friend['fullName']}, ${friend['dateOfBirth'] != null ? (() {
                                    try {
                                      // Define the date format for RFC 1123
                                      DateFormat rfc1123Format = DateFormat(
                                          'EEE, dd MMM yyyy HH:mm:ss zzz');
                                      DateTime dob = rfc1123Format
                                          .parse(friend['dateOfBirth']);
                                      return DateTime.now().year - dob.year;
                                    } catch (e) {
                                      // Handle invalid date format
                                      print(
                                          'Invalid date format: ${friend['dateOfBirth']}');
                                      return 'Unknown';
                                    }
                                  })() : 'Unknown'}',
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
                                  friend['school'] ?? '',
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
                      ],
                    ),
                  );
                },
              );
            },
          );
  }

  // Mock data for Messages
}
