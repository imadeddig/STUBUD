import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/edit_username_bloc.dart';
import '../../bloc/phone_number_bloc.dart';
import '../styles/style.dart';
import 'edit_username.dart';
import 'edit_phone_number.dart';
import 'edit_password.dart';
import 'connected_app.dart';
import '../../database/db_helper.dart';

class EditAccountInfoScreen extends StatefulWidget {
   final int userID;
  const EditAccountInfoScreen ({super.key, required this.userID});

  @override
  State<EditAccountInfoScreen> createState() => _EditAccountInfoScreenState();
}

class _EditAccountInfoScreenState extends State<EditAccountInfoScreen> {
  // This method gets the dummy user's info from the database
  Future<Map<String, dynamic>?> getUserInfo(int id) async {
    final db = await DBHelper.getDatabase();

    // Query to fetch dummy user info
    List<Map<String, dynamic>> result = await db.query(
      'StudentProfile',
      where: 'userID = ?',
      whereArgs: [id],
      limit: 1, // Limit to 1 user
    );
    print('Query result: $result');
    if (result.isNotEmpty) {
      return result.first; // Return the first result
    } else {
      return null; // Return null if no user is found
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
      body: FutureBuilder<Map<String, dynamic>?>( // Fetch user info from DB
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

          return BlocBuilder<EditUsernameBloc, String>(
            builder: (context, username) {
              // If the username is updated in the EditUsernameBloc, it will be reflected here
              final currentUsername = username.isEmpty ? initialUsername : username;

              return BlocBuilder<PhoneNumberBloc, String>(
                builder: (context, phoneNumber) {
                  // If the phone number is updated in the PhoneNumberBloc, it will be reflected here
                  final currentPhoneNumber = phoneNumber.isEmpty ? initialPhoneNumber : phoneNumber;
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
                                  builder: (context) =>  EditUsernameScreen(userID:widget.userID),
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
                                  builder: (context) =>  EditPhoneNumberScreen(userID:widget.userID),
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
                                  builder: (context) => EditPasswordScreen(userID:widget.userID),
                                ),
                              );
                            },
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text(
                              'Connected Apps',
                              style: AppStyles.listTitleTextStyle,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              // Navigate to ConnectedApp
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ConnectedApp(),
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
