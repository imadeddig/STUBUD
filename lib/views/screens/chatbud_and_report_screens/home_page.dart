import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import './messages_page.dart';
import 'package:stubudmvp/constant/constant.dart';

class ChatListPage extends StatefulWidget {
  final String currentUserID;

  const ChatListPage({super.key, required this.currentUserID});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late Stream<List<dynamic>> _chatsStream;
  List<dynamic> _previousChats = [];

  @override
  void initState() {
    super.initState();
    _chatsStream = _fetchChatsStream(widget.currentUserID);
  }

  Stream<List<dynamic>> _fetchChatsStream(String userID) async* {
    while (true) {
      try {
        final response = await http.get(
          Uri.parse(
              '$flaskBaseUrl/get_chats/${widget.currentUserID}'),
        );

        if (response.statusCode == 200) {
          List<dynamic> chats = json.decode(response.body);

          chats.sort((a, b) {
            DateTime timeA = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz')
                .parse(a['lastMessageTime']);
            DateTime timeB = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz')
                .parse(b['lastMessageTime']);
            return timeB.compareTo(timeA);
          });

          if (!_isEqual(_previousChats, chats)) {
            _previousChats = chats;
            yield chats;
          }
        } else {
          throw Exception('Failed to load chats');
        }
      } catch (error) {
        if (kDebugMode) {
          print('Error fetching chats: $error');
        }
        yield [];
      }

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  bool _isEqual(List<dynamic> list1, List<dynamic> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i]['id'] != list2[i]['id'] ||
          list1[i]['lastMessage'] != list2[i]['lastMessage']) {
        return false;
      }
    }
    return true;
  }

  Future<Map<String, String>> _fetchReceiverDetails(String userId) async {
    if (kDebugMode) {
      print("Fetching details for userId: $userId");
    }
    try {
      final response = await http.get(
        Uri.parse('$flaskBaseUrl/get_user/$userId'),
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        return {
          'username': userData['username'] ?? 'Unknown User',
          'avatarUrl': userData['profilePicture'] ??
              'https://www.example.com/default-avatar.png',
        };
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching receiver details: $error');
      }
      return {
        'username': 'Unknown User',
        'avatarUrl': 'https://www.example.com/default-avatar.png',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<List<dynamic>>(
        stream: _chatsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chats available.'));
          }

          final chats = snapshot.data!;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              var chat = chats[index];
              String lastMessageTimeFormatted = '';
              if (chat['lastMessageTime'] != null) {
                try {
                  DateTime lastMessageTime =
                      DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz')
                          .parse(chat['lastMessageTime']);
                  lastMessageTimeFormatted =
                      DateFormat('yyyy-MM-dd HH:mm').format(lastMessageTime);
                } catch (e) {
                  if (kDebugMode) {
                    print('Error parsing date: $e');
                  }
                }
              }

              if (chat['lastMessage'] == null || chat['lastMessage']!.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  Divider(thickness: 0.75, color: Colors.grey.shade300),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.028,
                      vertical: screenHeight * 0.012,
                    ),
                    leading: FutureBuilder<Map<String, String>>(
                      future: _fetchReceiverDetails(
                        chat['user1ID'] == widget.currentUserID
                            ? chat['user2ID']
                            : chat['user1ID'],
                      ),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircleAvatar(
                            radius: 25,
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (userSnapshot.hasError || !userSnapshot.hasData) {
                          return const CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.person),
                          );
                        }

                        return CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage(userSnapshot.data!['avatarUrl']!),
                          onBackgroundImageError: (_, __) =>
                              const Icon(Icons.person),
                        );
                      },
                    ),
                    title: FutureBuilder<Map<String, String>>(
                      future: _fetchReceiverDetails(
                        chat['user1ID'] == widget.currentUserID
                            ? chat['user2ID']
                            : chat['user1ID'],
                      ),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            'Loading...',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          );
                        }

                        if (userSnapshot.hasError || !userSnapshot.hasData) {
                          return Text(
                            'Unknown User',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          );
                        }

                        return Text(
                          userSnapshot.data!['username']!,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                    subtitle: Text(
                      chat['lastMessageSender'] == widget.currentUserID
                          ? 'You: ${chat['lastMessage']}'
                          : chat['lastMessage'] ?? 'No last message',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: Text(
                      lastMessageTimeFormatted,
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        color: Colors.black38,
                      ),
                    ),
                    onTap: () async {
                      try {
                        Map<String, String> receiverDetails =
                            await _fetchReceiverDetails(
                                chat['user1ID'] == widget.currentUserID
                                    ? chat['user2ID']
                                    : chat['user1ID']);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              chatID: chat['id'],
                              currentUserID: widget.currentUserID,
                              receiverUsername: receiverDetails['username']!,
                              receiverAvatarUrl: receiverDetails['avatarUrl']!,
                            ),
                          ),
                        );
                      } catch (error) {
                        if (kDebugMode) {
                          print('Error fetching receiver details: $error');
                        }
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
