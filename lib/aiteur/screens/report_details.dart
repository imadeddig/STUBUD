import 'package:flutter/material.dart';
import 'package:stubudmvp/chatbud/chatbud1.dart';
import '../styles/style.dart';

class ReportDetailsScreen extends StatelessWidget {
  final String title;

  const ReportDetailsScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Report',
          style: AppStyles.headerTextStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppStyles.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.listTitleTextStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '$title is profibited',
                style: AppStyles.listSubtitleTextStyle,
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Tell us more about what happened...',
                  hintStyle: AppStyles.listSubtitleTextStyle,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.accentColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const FullScreenConfirmationDialog();
                      },
                    );
                  },
                  child: const Text(
                    'Submit',
                    style: AppStyles.buttonTextStyle,
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

class FullScreenConfirmationDialog extends StatelessWidget {
  const FullScreenConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Report',
          style: AppStyles.headerTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title text
                const Text(
                  "Thanks for the lookout!\nWe’ll take it from here",
                  textAlign: TextAlign.center,
                  style: AppStyles.headerTextStyle, // Use existing title style
                ),
                const SizedBox(height: 40),
                // Subtitle text
                const Text(
                  "Would you want to block this person?",
                  textAlign: TextAlign.center,
                  style: AppStyles
                      .subtitleTextStyle, // Use existing subtitle style
                ),
                const SizedBox(height: 20),
                // Block button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) =>
                            const Chatbud1(userID: 1,), // Replace with your desired screen/widget
                      ),
                      (route) =>
                          false, // Removes all previous routes from the stack
                    );
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.accentColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ), // Use existing button style
                  child: const Text(
                    "Block",
                    style: AppStyles
                        .buttonTextStyle, // Use existing button text style
                  ),
                ),
                const SizedBox(height: 10),
                // Done button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) =>
                            const Chatbud1(userID: 1,), // Replace with your desired screen/widget
                      ),
                      (route) =>
                          false, // Removes all previous routes from the stack
                    );
                  },
                  child: const Text(
                    "Done",
                    style: AppStyles
                        .subtitleTextStyle, // Use existing text button style
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
