import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/report_and_block_cubit.dart';
import 'report_specific.dart';
import 'report_details.dart';
import '../../../styles/style.dart';

class ReportScreen extends StatefulWidget {
  final String userId;
  final String raportedId;
  const ReportScreen({super.key, required this.userId,required this.raportedId});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final List<String> _bullyingOption = [
    'Verbal Abuse',
    'Threats',
    'Cyberstalking',
    'Name Calling',
    'Spreading Rumors',
    'Persistent Unwanted Contact'
  ];

  final List<String> _inappropriate = [
    'Graphic Content',
    'Hate Speech',
    'Explicit Images'
  ];

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
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<ReportBlockCubit>(),
                        child: ReportSpecific(
                          title: 'Harassment or Bullying',
                          options: _bullyingOption,
                          userId: widget.userId,
                          raportedId: widget.raportedId,
                        ),
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<ReportBlockCubit>(),
                        child: ReportSpecific(
                          title: 'Inappropriate Content',
                          options: _inappropriate,
                          userId: widget.userId,
                          raportedId: widget.raportedId,
                        ),
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<ReportBlockCubit>(),
                        child: ReportDetailsScreen(
                          title: 'Spam or Scams',
                          userId: widget.userId,
                          reportedId: widget.raportedId,
                        ),
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<ReportBlockCubit>(),
                        child: ReportDetailsScreen(
                          title: 'Impersonation',
                          userId: widget.userId,
                          reportedId: widget.raportedId,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Violation of Terms',
                  style: AppStyles.listTitleTextStyle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<ReportBlockCubit>(),
                        child: ReportDetailsScreen(
                          title: 'Violation of Terms',
                          userId: widget.userId,
                          reportedId: widget.raportedId,
                        ),
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<ReportBlockCubit>(),
                        child: ReportDetailsScreen(
                          title: 'Suspicious Behavior',
                          userId: widget.userId,
                          reportedId: widget.raportedId,
                        ),
                      ),
                    ),
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
