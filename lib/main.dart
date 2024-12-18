import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stubudmvp/aiteur/screens/edit_account_info.dart';
import 'package:stubudmvp/aiteur/screens/report.dart';
import 'package:stubudmvp/bloc/change_password_bloc.dart';
import 'package:stubudmvp/bloc/edit_username_bloc.dart';
import 'package:stubudmvp/bloc/phone_number_bloc.dart';
import 'package:stubudmvp/chatbud/chat_screen.dart';
import 'package:stubudmvp/database/initialization.dart';
import 'package:stubudmvp/farial/signIn.dart';
import 'package:stubudmvp/imad/buddyProfile.dart';
import 'package:stubudmvp/imad/deactivatedProfile.dart';
import 'package:stubudmvp/login.dart';
import 'package:flutter/material.dart';
import 'package:stubudmvp/welcome.dart';

import 'package:stubudmvp/farial/profileInfo.dart';
import 'package:stubudmvp/farial/more.dart';
import 'package:stubudmvp/farial/blocked.dart';


import 'package:stubudmvp/farial/causes.dart';

import 'package:stubudmvp/farial/sure.dart';

import 'database/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Print the content of the StudentProfile table
  await printTableContent('StudentProfile');
  await initializeData(); 

  // Run the Flutter application
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<EditUsernameBloc>(
          create: (_) => EditUsernameBloc(), // Initialize EditUsernameBloc
        ),
        BlocProvider<PhoneNumberBloc>(
          create: (_) => PhoneNumberBloc(), // Initialize PhoneNumberBloc
        ),
        BlocProvider<ChangePasswordBloc>(
          create: (_) => ChangePasswordBloc(), // Initialize PhoneNumberBloc
        ),
      ],
      child: const App(),
    ),);
}

Future<void> printTableContent(String tableName) async {
  try {
    final database = await DBHelper.getDatabase();

    // Fetch all rows from the specified table
    final List<Map<String, dynamic>> tableContent = await database.query(tableName);

    // Check if the table has content
    if (tableContent.isEmpty) {
      print("The table '$tableName' is empty.");
    } else {
      print("Content of the table '$tableName':");
      for (var row in tableContent) {
        print(row); // Each row is a Map<String, dynamic>
      }
    }
  } catch (error) {
    print("Error occurred while fetching table content: $error");
  }
}


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      
      home: const Welcome(),
      theme: ThemeData(fontFamily: "Outfit"),
     routes: {
  "login": (context) => const Login(),
  "signin": (context) => const signIn(),
  "mainpage": (context) => const DeactivatedProfileScreen(),
  "report": (context) => ReportScreen(),
  "chatpage": (context) => const ChatScreen(
        name: "cc",
        image: "images/profile .png",
        initialMessages: [],
      ),
  "Explorebuddiespage": (context) => const buddyProfile(),
  "ProfileInfo": (context) => const Profileinfo(),
  "more": (context) => const More(),
  "blocked": (context) => const Blocked(),
  "causes": (context) => const Causes(),
  "sure": (context) => const Sure(),
},

    );
  }
}
