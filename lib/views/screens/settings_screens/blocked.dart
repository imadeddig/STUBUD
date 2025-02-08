import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../bloc/report_and_block_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blocked extends StatefulWidget {
  final String userId;
  

  const Blocked({super.key, required this.userId});

  @override
  State<Blocked> createState() => _BlockedState();
}

class _BlockedState extends State<Blocked> {
  @override
  void initState() {
    super.initState();
    // Fetch blocked users when the screen is initialized
    context.read<ReportBlockCubit>().getBlockedUsers(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Done",
                    style: GoogleFonts.outfit(
                        color: const Color(0xFF7C90D6),
                        fontWeight: FontWeight.bold))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Blocked Accounts ",
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            BlocBuilder<ReportBlockCubit, ReportBlockState>(
              builder: (context, state) {
                if (state is ReportBlockLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BlockedUsersFetched) {
                  final blockedUsers = state.blockedUsers;
                  if (blockedUsers.isEmpty) {
                    return Center(
                      child: Text(
                        "No blocked accounts.",
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true, // Ensures that the ListView does not take up too much space
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: blockedUsers.length,
                    itemBuilder: (context, index) {
                      final blockedUser = blockedUsers[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blockedUser['fullName']!, // Display name
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '@${blockedUser['username']}', // Display username as handle
                                  style: GoogleFonts.outfit(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                           TextButton(
                              onPressed: () {
                                context.read<ReportBlockCubit>().unblockUser(widget.userId, blockedUser['userId']!);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                'Unblock',
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  );
                } else if (state is ReportBlockError) {
                  return Center(
                    child: Text(
                      "Error: ${state.error}",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return Center(
                  child: Text(
                    "No data available.",
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

