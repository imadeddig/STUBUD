import 'package:stubudmvp/aiteur/screens/report.dart';
import 'package:stubudmvp/chatbud/chat_screen.dart';
import 'package:stubudmvp/database/initialization.dart';
import 'package:stubudmvp/farial/signIn.dart';
import 'package:stubudmvp/imad/buddyProfile.dart';
import 'package:stubudmvp/imad/deactivatedProfile.dart';
import 'package:stubudmvp/imad/moreFilters.dart';
import 'package:stubudmvp/login.dart';
import 'package:flutter/material.dart';
import 'package:stubudmvp/welcome.dart';

import 'package:stubudmvp/farial/profileInfo.dart';
import 'package:stubudmvp/farial/more.dart';
import 'package:stubudmvp/farial/blocked.dart';

import 'package:stubudmvp/farial/causes.dart';

import 'package:stubudmvp/farial/sure.dart';


import 'package:firebase_core/firebase_core.dart';
import 'init.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully!");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  init();

  // Initialize your data asynchronously
  await initializeData();

  // Run the Flutter application
  runApp(
    const App(),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Welcome(),
      theme: ThemeData(fontFamily: "Outfit"),
      routes: {
        "login": (context) => const Login(),
        "signin": (context) => const signIn(),
        "mainpage": (context) => const DeactivatedProfileScreen(),
        "report": (context) => ReportScreen(),
        "chatpage": (context) => const ChatScreen(
              name: "cc",
              image: "images/profile.png", // Fixed extra space in image path
              initialMessages: [],
            ),
        "Explorebuddiespage": (context) => const buddyProfile(),
        "more": (context) => const More(),
      },
    );
  }
}
