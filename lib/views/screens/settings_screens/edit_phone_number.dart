import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stubudmvp/views/screens/settings_screens/edit_account_info.dart';
import '../../../styles/style.dart';
import '../../../bloc/phone_number_bloc.dart';

class EditPhoneNumberScreen extends StatefulWidget {
  final String userID;
  const EditPhoneNumberScreen({super.key, required this.userID});

  @override
  _EditPhoneNumberScreenState createState() => _EditPhoneNumberScreenState();
}

class _EditPhoneNumberScreenState extends State<EditPhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    _phoneNumberController.dispose();
    super.dispose();
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
            onPressed: () async {
              final phoneNumber = _phoneNumberController.text.trim();

              if (phoneNumber.isNotEmpty) {
                // Trigger the updatePhoneNumber event in the bloc
                context.read<PhoneNumberBloc>().add(
                  PhoneNumberUpdateRequested(
                    phoneNumber: phoneNumber,
                    userId: widget.userID,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a phone number')),
                );
              }
            },
            child: Text(
              'Next',
              style: AppStyles.buttonTextStyle.copyWith(color: AppStyles.accentColor),
            ),
          ),
        ],
      ),
      body: BlocListener<PhoneNumberBloc, PhoneNumberState>(
        listener: (context, state) {
          if (state is PhoneNumberFailure) {
            // Handle the failure state (show error message)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          } else if (state is PhoneNumberSuccess) {
            // Navigate to the next screen on success
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EditAccountInfoScreen(userID: widget.userID),
              ),
            );
          }
        },
        child: BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: AppStyles.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phone Number',
                      style: AppStyles.headerTextStyle,
                    ),
                    const Text(
                      '''Changing phone numbers will require a confirmation code sent by our community to your new phone number.''',
                      style: AppStyles.subtitleTextStyle,
                    ),
                    const SizedBox(height: 45),
                    const Text(
                      'Phone Number',
                      style: AppStyles.listSubtitleTextStyle,
                    ),
                    TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                        hintStyle: AppStyles.subtitleTextStyle,
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: const TextSpan(
                        text: 'After typing your new phone number, please press ',
                        style: AppStyles.listSubtitleTextStyle,
                        children: [
                          TextSpan(
                            text: 'Next ',
                            style: TextStyle(
                              color: AppStyles.accentColor,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: 'to continue.',
                            style: AppStyles.listSubtitleTextStyle,
                          ),
                        ],
                      ),
                    ),
                    if (state is PhoneNumberLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
