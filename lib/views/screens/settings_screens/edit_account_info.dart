import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import '../../../bloc/edit_username_bloc.dart';
import '../../../bloc/phone_number_bloc.dart';
import '../../../styles/style.dart';
import 'edit_username.dart';
import 'edit_phone_number.dart';
import 'edit_password.dart';


class EditAccountInfoScreen extends StatefulWidget {
  final String userID;
  const EditAccountInfoScreen({super.key, required this.userID});

  @override
  State<EditAccountInfoScreen> createState() => _EditAccountInfoScreenState();
}

class _EditAccountInfoScreenState extends State<EditAccountInfoScreen> {
  // This method fetches the user's info from Firestore
  Future<Map<String, dynamic>?> getUserInfo(String id) async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(id).get();

      if (userDoc.exists) {
        return userDoc.data(); // Return the user's data if the document exists
      } else {
        return null; // Return null if the user is not found
      }
    } catch (e) {
      print('Error fetching user info: $e');
      return null; // Return null in case of error
    }
  }

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
      body: FutureBuilder<Map<String, dynamic>?>( // Fetch user info from Firestore
        future: getUserInfo(widget.userID), // Call to fetch user info
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading while fetching data
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('User not found.'));
          }

          final userInfo = snapshot.data!;
          final initialUsername = userInfo['username'] ?? 'N/A';
          final initialPhoneNumber = userInfo['phoneNumber'] ?? 'N/A';

          return BlocBuilder<EditUsernameBloc, EditUsernameState>( 
            builder: (context, usernameState) {
              // If the username is updated in the EditUsernameBloc, it will be reflected here
              final currentUsername = usernameState.username.isEmpty ? initialUsername : usernameState.username;

              return BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
  builder: (context, phoneNumberState) {
    // If the phone number is updated in the PhoneNumberBloc, it will be reflected here
    String currentPhoneNumber = initialPhoneNumber; // Default to the initial phone number

    if (phoneNumberState is PhoneNumberSuccess) {
      currentPhoneNumber = phoneNumberState.phoneNumber; // Update if the phone number is successfully loaded
    } else if (phoneNumberState is PhoneNumberFailure) {
      currentPhoneNumber = 'Error: ${phoneNumberState.errorMessage}'; // Show error message if fetching fails
    }

    return SingleChildScrollView(
      child: Padding(
        padding: AppStyles.screenPadding,
        child: Column(
          children: [
            const Text(
              'Account Personal Information',
              style: AppStyles.headerTextStyle,
            ),
            const Text(
              "We use this info to confirm it's really you, making it easier for you to log in quickly and securely while keeping the community safe!",
              style: AppStyles.subtitleTextStyle,
            ),
            const SizedBox(height: 30),
            ListTile(
              title: const Text(
                'Username',
                style: AppStyles.listTitleTextStyle,
              ),
              subtitle: Text(
                currentUsername, // Display updated username
                style: AppStyles.listSubtitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to EditUsernameScreen when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUsernameScreen(userID: widget.userID),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Phone Number',
                style: AppStyles.listTitleTextStyle,
              ),
              subtitle: Text(
                currentPhoneNumber, // Display updated phone number
                style: AppStyles.listSubtitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to EditPhoneNumberScreen when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPhoneNumberScreen(userID: widget.userID),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Password',
                style: AppStyles.listTitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to EditPasswordScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPasswordScreen(userID: widget.userID),
                  ),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  },
);

            },
          );
        },
      ),
    );
  }
}

