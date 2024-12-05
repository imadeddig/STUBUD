import 'package:flutter/material.dart';
import '../screens/report_specific.dart';
import 'report_details.dart';
import '../styles/style.dart';



class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body:SingleChildScrollView(
        child:Padding(
        padding: AppStyles.screenPadding,
        child: Column(
          children: [
          const Text(
          'Why are you reporting this user ?',
          style: AppStyles.headerTextStyle,
         ),
        const Text(
                '''reporting users helps keep our community safe and enjoyable for everyone, Your report is completely anonymous. Together, we can maintain a positive environment for all!''',
                style: AppStyles.listSubtitleTextStyle,
              ),
              const SizedBox(height: 30),
            ListTile(
              title: const Text(
                'Harassment or Bullying',
                style: AppStyles.listTitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportSpecific(title:'Harassment or Bullying', options: _bullying_option)),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Inappropriate Content',
                style: AppStyles.listTitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportSpecific(title: 'Inappropriate Content', options: _innapropriate)),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Spam or Scams',
                style: AppStyles.listTitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportDetailsScreen(title:'Spam or Scams')),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Impersonation',
                style: AppStyles.listTitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportDetailsScreen(title: 'Impersonation')),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Violation of Terls',
                style: AppStyles.listTitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportDetailsScreen(title: 'Violation of Terls')),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Suspicious Behavior',
                style: AppStyles.listTitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportDetailsScreen(title: 'Suspicious Behavior')),
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
 
 final List<String> _bullying_option = ['Verbal Abuse', 'Threats', 'Cyberstalking', 'Name Calling','Spreading Rumors','Persistent Unwanted Contact'];
 final List<String> _innapropriate = ['Graphic Content', 'Hate Speech', 'Explicit Images'];

  ReportScreen({super.key});
}