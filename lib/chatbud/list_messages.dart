import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Emily',
      'image': 'images/ae95db324a7d14c53b4d54357312d477.jpg',
      'messages': [
        {"isSent": false, "text": "hey!"},
        {"isSent": true, "text": "hello there!"},
        {
          "isSent": false,
          "text": "are you down to study at this cool place I found?"
        },
        {"isSent": true, "text": "sure! show me"},
        {
          "isSent": false,
          "text": "what do you think?",
          "image": "images/study_space.jpg"
        },
        {"isSent": true, "text": "nice!"},
      ],
    },
    {
      'name': 'billel',
      'image': 'images/ae95db324a7d14c53b4d54357312d477.jpg',
      'messages': [
        {"isSent": false, "text": "Hello!"},
        {"isSent": true, "text": "Hi Alex, how are you?"},
      ],
    },
  ];

   ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: chats.map((chat) {
        return Column(
          children: [
            Divider(thickness: 0.75, color: Colors.grey.shade300),
            ListTile(
              contentPadding:
                   EdgeInsets.symmetric(horizontal: (screenWidth*0.028), vertical: (screenHeight*0.012)),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(chat['image']),
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
                chat['messages'].last['text'],
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
  }
}
