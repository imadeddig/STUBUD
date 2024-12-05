import 'package:flutter/material.dart';
import '../styles/style.dart';
import 'edit_username.dart';
import 'edit_phone_number.dart';
import 'edit_password.dart';
import 'connected_app.dart';


class EditAccountInfoScreen extends StatelessWidget {
  const EditAccountInfoScreen({super.key});

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
              subtitle: const Text(
                'your_username',
                style: AppStyles.listSubtitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditUsernameScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Phone Number',
                style: AppStyles.listTitleTextStyle,
              ),
              subtitle: const Text(
                '+213000000000',
                style: AppStyles.listSubtitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditPhoneNumberScreen()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditPasswordScreen()),
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
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConnectedApp()),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
      ),
    );
  }
}




