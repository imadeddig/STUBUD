import 'package:flutter/material.dart';
import '../styles/style.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppStyles.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      resizeToAvoidBottomInset: true, // Ensures resizing when the keyboard appears
      body: SingleChildScrollView( // Makes the content scrollable
        child: Padding(
          padding: AppStyles.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Password',
                style: AppStyles.headerTextStyle,
              ),
              const Text(
                '''Passwords must be at least 6 characters, and should include a combination of numbers and letters.''',
              ),
              const SizedBox(height: 45),
              const Text(
                'Current Password',
                style: AppStyles.listSubtitleTextStyle,
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter current password',
                  hintStyle: AppStyles.subtitleTextStyle,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'New Password',
                style: AppStyles.listSubtitleTextStyle,
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter new password',
                  hintStyle: AppStyles.subtitleTextStyle,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Confirm New Password',
                style: AppStyles.listSubtitleTextStyle,
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm new password',
                  hintStyle: AppStyles.subtitleTextStyle,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle forget password action
                      debugPrint("Forget Password tapped!");
                    },
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Adding an Expanded widget to push the button to the bottom
              // You can use `Spacer()` as well, but `Expanded` ensures the button
              // takes the remaining space.
              Container(
                height: MediaQuery.of(context).size.height * 0.2, // Ensure there's enough space for scrolling
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      // Add your save password logic here
                    },
                    child: const Text(
                      'Change Password',
                      style: AppStyles.buttonTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

