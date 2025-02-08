import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'dart:convert';

// Define the ReportBlockState
abstract class ReportBlockState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReportBlockInitial extends ReportBlockState {}

class ReportBlockLoading extends ReportBlockState {}

class UserReported extends ReportBlockState {
  final String reportId;
  UserReported(this.reportId);

  @override
  List<Object?> get props => [reportId];
}

class UserBlocked extends ReportBlockState {
  final String blockedUserId;
  UserBlocked(this.blockedUserId);

  @override
  List<Object?> get props => [blockedUserId];
}

class BlockedUsersFetched extends ReportBlockState {
  final List<Map<String, dynamic>> blockedUsers;
  BlockedUsersFetched(this.blockedUsers);

  @override
  List<Object?> get props => [blockedUsers];
}

class ReportBlockError extends ReportBlockState {
  final String error;
  ReportBlockError(this.error);

  @override
  List<Object?> get props => [error];
}

class UserUnblocked extends ReportBlockState {
  final String unblockedUserId;
  UserUnblocked(this.unblockedUserId);

  @override
  List<Object?> get props => [unblockedUserId];
}

// ReportBlockCubit using Flask API for report and block actions
class ReportBlockCubit extends Cubit<ReportBlockState> {
  final String flaskBaseUrl;

  ReportBlockCubit(this.flaskBaseUrl) : super(ReportBlockInitial());

  // Report User
  Future<void> reportUser(String whoReportId, String reportedUserId, Map<String, dynamic> reportDetails) async {
    emit(ReportBlockLoading());
    try {
      final response = await http.post(
        Uri.parse('$flaskBaseUrl/report_user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'whoReportedId': whoReportId,
          'reportedUserId': reportedUserId,
          'reportDetails': reportDetails,
        }),
      );

      if (response.statusCode == 200) {
        final reportId = jsonDecode(response.body)['reportId'];
        emit(UserReported(reportId));
      } else {
        emit(ReportBlockError('Failed to report user'));
      }
    } catch (error) {
      emit(ReportBlockError(error.toString()));
    }
  }

  // Block User
  Future<void> blockUser(String currentUserId, String blockedUserId) async {
    emit(ReportBlockLoading());
    try {
      final response = await http.post(
        Uri.parse('$flaskBaseUrl/block_user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'currentUserId': currentUserId, 'blockedUserId': blockedUserId}),
      );

      if (response.statusCode == 200) {
        emit(UserBlocked(blockedUserId));
      } else {
        emit(ReportBlockError('Failed to block user'));
      }
    } catch (error) {
      emit(ReportBlockError(error.toString()));
    }
  }

  // Unblock User
  Future<void> unblockUser(String currentUserId, String blockedUserId) async {
  emit(ReportBlockLoading());
  try {
    final response = await http.post(
      Uri.parse('$flaskBaseUrl/unblock_user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'currentUserId': currentUserId, 'blockedUserId': blockedUserId}),
    );

    if (response.statusCode == 200) {
      // Fetch updated blocked users list after unblocking
      await getBlockedUsers(currentUserId);
    } else {
      emit(ReportBlockError('Failed to unblock user'));
    }
  } catch (error) {
    emit(ReportBlockError(error.toString()));
  }
}

// Get Blocked Users
Future<void> getBlockedUsers(String currentUserId) async {
  emit(ReportBlockLoading());
  try {
    final response = await http.get(Uri.parse('$flaskBaseUrl/get_blocked_users/$currentUserId'));

    if (response.statusCode == 200) {
      final List<dynamic> blockedUsers = jsonDecode(response.body);
      emit(BlockedUsersFetched(
          blockedUsers.map((user) => user as Map<String, dynamic>).toList()));
    } else {
      emit(ReportBlockError('Failed to fetch blocked users'));
    }
  } catch (error) {
    emit(ReportBlockError(error.toString()));
  }
}

}
