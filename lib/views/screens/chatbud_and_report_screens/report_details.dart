import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stubudmvp/views/screens/chatbud_and_report_screens/chatbud1.dart';
import '../../../bloc/report_and_block_cubit.dart';
import '../../../styles/style.dart';

class ReportDetailsScreen extends StatefulWidget {
  final String title;
  final String userId;
  final String reportedId;

  const ReportDetailsScreen({
    super.key,
    required this.title,
    required this.userId,
    required this.reportedId,
  });

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  final TextEditingController _detailsController = TextEditingController();

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
                widget.title,
                style: AppStyles.listTitleTextStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '${widget.title} is prohibited',
                style: AppStyles.listSubtitleTextStyle,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _detailsController,
                decoration: const InputDecoration(
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
                        return BlocProvider.value(
                          value: context.read<ReportBlockCubit>(),
                          child: FullScreenConfirmationDialog(
                            userId: widget.userId,
                            reportedId: widget.reportedId,
                            reportDetails: {
                              'reason': widget.title,
                              'details': _detailsController.text,
                            },
                          ),
                        );
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
  final String userId;
  final String reportedId;
  final Map<String, dynamic> reportDetails;

  const FullScreenConfirmationDialog({
    super.key,
    required this.userId,
    required this.reportedId,
    required this.reportDetails,
  });

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
                const Text(
                  "Thanks for the lookout!\nWe’ll take it from here",
                  textAlign: TextAlign.center,
                  style: AppStyles.headerTextStyle,
                ),
                const SizedBox(height: 40),
                const Text(
                  "Would you want to block this person?",
                  textAlign: TextAlign.center,
                  style: AppStyles.subtitleTextStyle,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final cubit = context.read<ReportBlockCubit>();
                    final navigator = Navigator.of(context); // Capture local reference

                    try {
                      // Report the user
                      await cubit.reportUser(userId, reportedId, reportDetails);

                      // Block the user
                      await cubit.blockUser(userId, reportedId);

                      // Navigate upon success
                      navigator.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => Chatbud1(currentUserId:userId),
                        ),
                        (route) => false,
                      );
                    } catch (error) {
                      // Handle errors gracefully
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $error')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.accentColor,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Block",
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    final cubit = context.read<ReportBlockCubit>();
                    final navigator = Navigator.of(context); // Capture local reference

                    try {
                      // Report the user
                      await cubit.reportUser(userId, reportedId, reportDetails);

                      // Navigate upon success
                      navigator.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => Chatbud1(currentUserId: userId),
                        ),
                        (route) => false,
                      );
                    } catch (error) {
                      // Handle errors gracefully
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $error')),
                      );
                    }
                  },
                  child: const Text(
                    "Done",
                    style: AppStyles.subtitleTextStyle,
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