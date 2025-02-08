import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../styles/style.dart';
import '../../../bloc/edit_username_bloc.dart';

class EditUsernameScreen extends StatefulWidget {
  final String userID;
  const EditUsernameScreen({super.key, required this.userID});

  @override
  _EditUsernameScreenState createState() => _EditUsernameScreenState();
}

class _EditUsernameScreenState extends State<EditUsernameScreen> {
  TextEditingController usernameController = TextEditingController();
  String message = ''; // To display messages

  @override
  void initState() {
    super.initState();
    // Call loadUsername once during initialization
    context.read<EditUsernameBloc>().loadUsername(widget.userID);
  }

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
              // Get the updated username from the TextField
              final newUsername = (usernameController.text).trim();

              // Call updateUsername method of Cubit
              context.read<EditUsernameBloc>().updateUsername(newUsername, widget.userID);
              
            },
            child: Text(
              'Done',
              style: AppStyles.buttonTextStyle.copyWith(color: AppStyles.accentColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppStyles.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Username', style: AppStyles.headerTextStyle),
              const Text(
                '''Usernames are best used for fast and simple access to your account. Updates will let others search for you using your username.''',
                style: AppStyles.subtitleTextStyle,
              ),
              const SizedBox(height: 45),
              const Text('Username', style: AppStyles.listSubtitleTextStyle),

              // Use BlocBuilder to listen to the state changes
              BlocBuilder<EditUsernameBloc, EditUsernameState>(
                builder: (context, state) {
                  usernameController.text = state.username; // Update the username input field
                  return TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your username',
                      hintStyle: AppStyles.subtitleTextStyle,
                      border: UnderlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

            BlocListener<EditUsernameBloc, EditUsernameState>(
                listener: (context, state) {
                  if (state.message.contains('successfully')) {
                    // Show success message briefly before navigating back
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                    );

                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context); // Navigate back after showing the message
                    });
                  } else if (state.message.isNotEmpty) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                    );
                  }
                },
                child: Container(),
              ),

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

