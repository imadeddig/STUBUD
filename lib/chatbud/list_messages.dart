import 'package:flutter/material.dart';
import 'package:stubudmvp/database/chatSession.dart';
import 'chat_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListScreen extends StatefulWidget {
  final String userID;

  const ChatListScreen({super.key, required this.userID});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late Future<List<Map<String, dynamic>>> chats;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //fetchChats(); 
  }



  // Future<void> fetchChats() async {
  //   try {
  //     // Fetch chat sessions and update state
  //     List<Map<String, dynamic>> fetchedChats =
  //         await ChatSessionsDB.getChatSessions(widget.userID);
  //     print('Chats fetched: $fetchedChats');
  //     setState(() {
  //       chats =
  //           Future.value(fetchedChats); // Update state with the fetched chats
  //       isLoading = false;
  //     });
  //   } catch (error) {
  //     print('Error fetching chats: $error');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: chats, // Use the Future to wait for the chats
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No chats available',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          );
        }

        return ListView(
          children: snapshot.data!.map((chat) {
            return Column(
              children: [
                Divider(thickness: 0.75, color: Colors.grey.shade300),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.028,
                      vertical: screenHeight * 0.012),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(chat['image']),
                  ),
                  title: Text(
                    chat['name'],
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    chat['messages'].isNotEmpty
                        ? chat['messages'].last['text']
                        : 'No messages yet',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.circle,
                    color: Color(0xFF7C90D6),
                    size: 10,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          name: chat['name'],
                          image: chat['image'],
                          initialMessages: chat['messages'],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
