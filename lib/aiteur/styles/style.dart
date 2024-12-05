import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFF000000); // Black
  static const Color accentColor = Color(0xFF7C90D6); // Blue (for "Done")
  static const Color subtitleColor = Color(0xFF6E6E6E); // Grey for subtitles

  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 22,
    fontFamily: 'Outfit',
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Outfit',
    fontWeight: FontWeight.normal,
    color: primaryColor,
    
  );

  static const TextStyle listTitleTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'Outfit',
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static const TextStyle listSubtitleTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Outfit',
    fontWeight: FontWeight.normal,
    color: subtitleColor,
  );

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16.0);
  
  static const TextTheme textTheme = TextTheme(
    bodyLarge: headerTextStyle,
    bodyMedium: subtitleTextStyle,
  );
   static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white, // Buttons will use white text by default
  );
}

