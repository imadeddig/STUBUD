import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/report_and_block_cubit.dart';
import 'report_details.dart';
import '../../../styles/style.dart';

class ReportSpecific extends StatefulWidget {
  final String title;
  final List<String> options;
  final String userId;
  final String raportedId;

  const ReportSpecific({
    super.key,
    required this.title,
    required this.options,
    required this.userId,
    required this.raportedId
  });

  @override
  State<ReportSpecific> createState() => _ReportSpecificState();
}

class _ReportSpecificState extends State<ReportSpecific> {
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
              Text(
                widget.title,
                style: AppStyles.listSubtitleTextStyle,
              ),
              const SizedBox(height: 25),
              for (var option in widget.options)
                Column(
                  children: [
                    ListTile(
                      title: Text(
                        option,
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
                                title: option,
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
                )
            ],
          ),
        ),
      ),
    );
  }
}
