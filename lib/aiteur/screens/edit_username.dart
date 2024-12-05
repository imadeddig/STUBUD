import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../styles/style.dart';

class EditUsernameScreen extends StatelessWidget {
  const EditUsernameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppStyles.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
             Navigator.pop(context);
            },
            child: Text(
              'Done',
              style: AppStyles.buttonTextStyle.copyWith(color: AppStyles.accentColor),
            ),
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Padding(
        padding: AppStyles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
          'Username',
          style: AppStyles.headerTextStyle,
           ),
           const Text(
            '''usernames are best used for fast and simple access to your stubud account, updates will let you know search for students using their username''',
                style: AppStyles.subtitleTextStyle,
           ),
           const SizedBox(height:45 ),
            const Text(
              'Username',
              style: AppStyles.listSubtitleTextStyle,
              
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter your username',
                hintStyle: AppStyles.subtitleTextStyle,
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: 'You can change your username once every two months. ',
                style: AppStyles.listSubtitleTextStyle,
                children: [
                  TextSpan(
                    text: 'Learn more',
                    style: const TextStyle(
                      color: Colors.black, // Link color
                      fontFamily: 'Outfit',
                      decoration: TextDecoration.underline, // Underlined
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Action when the link is tapped
                        debugPrint('Learn more tapped!');
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

