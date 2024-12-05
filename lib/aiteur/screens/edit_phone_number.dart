import 'package:flutter/material.dart';
import '../styles/style.dart';

class EditPhoneNumberScreen extends StatelessWidget {
  const EditPhoneNumberScreen({super.key});

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
              // Add your save logic here
            },
            child: Text(
              'Next',
              style: AppStyles.buttonTextStyle.copyWith(color: AppStyles.accentColor),
            ),
          ),
        ],
      ),
      body:SingleChildScrollView(
        child:Padding(
        padding: AppStyles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text(
          'Phone Number',
          style: AppStyles.headerTextStyle,
           ),
           const Text(
            '''changing phone numbers will require a confirmation code sent by our community to your new phone number''',
                style: AppStyles.subtitleTextStyle,
           ),
           const SizedBox(height:45 ),
            const Text(
              'Phone Number',
              style: AppStyles.listSubtitleTextStyle,
            ),
            const TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                hintStyle: AppStyles.subtitleTextStyle,
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height:15 ),
             RichText(
              text: const TextSpan(
                text: 'after typing your new phone number, please press ',
                style: AppStyles.listSubtitleTextStyle,
                children: [
                TextSpan(
                    text: 'Next ',
                    style: TextStyle(
                      color: AppStyles.accentColor,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )
                ),
                TextSpan(
                  text: 'to continue.',
                  style: AppStyles.listSubtitleTextStyle,
                ),
                ],
              ),
            ),
           
          ],
        ),
      ),
      ) ,
    );
  }
}

