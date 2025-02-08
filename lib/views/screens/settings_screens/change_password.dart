import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/change_password_bloc.dart';
import '../../../styles/style.dart';

class ChangePasswordScreen extends StatefulWidget {
    final String userID;
  const ChangePasswordScreen ({super.key, required this.userID});
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: AppStyles.screenPadding,
          child: BlocProvider(
            create: (context) => ChangePasswordBloc(),
            child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully')),
                  );
                  Navigator.pop(context);
                } else if (state is ChangePasswordFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.error}')),
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Change Password', style: AppStyles.headerTextStyle),
                  const SizedBox(height: 45),
                  _buildPasswordField(
                    context,
                    'Current Password',
                    _currentPasswordController,
                    _isCurrentPasswordVisible,
                    () => setState(() {
                      _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                    }),
                  ),
                  const SizedBox(height: 10),
                  _buildPasswordField(
                    context,
                    'New Password',
                    _newPasswordController,
                    _isNewPasswordVisible,
                    () => setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    }),
                  ),
                  const SizedBox(height: 10),
                  _buildPasswordField(
                    context,
                    'Confirm New Password',
                    _confirmPasswordController,
                    _isConfirmPasswordVisible,
                    () => setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    }),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppStyles.accentColor,
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            ),
                            onPressed: state is ChangePasswordLoading
                                ? null
                                : () {
                                    context.read<ChangePasswordBloc>().add(
                                      SubmitChangePassword(
                                        userID: widget.userID,
                                        currentPassword: _currentPasswordController.text,
                                        newPassword: _newPasswordController.text,
                                        confirmPassword: _confirmPasswordController.text,
                                      ),
                                    );
                                  },
                            child: state is ChangePasswordLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text('Change Password', style: AppStyles.buttonTextStyle),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    BuildContext context,
    String label,
    TextEditingController controller,
    bool isPasswordVisible,
    VoidCallback toggleVisibility,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.listSubtitleTextStyle),
        TextField(
          controller: controller,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            hintStyle: AppStyles.subtitleTextStyle,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: toggleVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
