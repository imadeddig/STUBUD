import 'package:flutter/material.dart';
import '../styles/style.dart';

class ConnectedApp extends StatelessWidget{
  const ConnectedApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: Padding(
        padding: AppStyles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        const Text('Connected apps',
          textAlign: TextAlign.left,
          style: AppStyles.headerTextStyle,
        ),
        const Text(
            "these apps are used by you to connect to your stubud account faster",
            style: AppStyles.subtitleTextStyle,
          ),
              const SizedBox(height: 30),
            ListTile(
              title: const Text(
                'Instagram',
                style: AppStyles.listTitleTextStyle,
              ),
              subtitle: const Text(
                'add Instagram',
                style: AppStyles.listSubtitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                //add action
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Facebook',
                style: AppStyles.listTitleTextStyle,
              ),
              subtitle: const Text(
                'add Facebook',
                style: AppStyles.listSubtitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
               //add action
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Email',
                style: AppStyles.listTitleTextStyle,
              ),
              subtitle: const Text(
                'add email',
                style: AppStyles.listSubtitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
               // do action
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'LinkedIn',
                style: AppStyles.listTitleTextStyle,
              ),
              subtitle: const Text(
                'add LinkedIn',
                style: AppStyles.listSubtitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Add navigation 
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

}