import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stubudmvp/bloc/change_password_bloc.dart';
import 'package:stubudmvp/bloc/edit_username_bloc.dart';
import 'package:stubudmvp/bloc/phone_number_bloc.dart';
import 'package:stubudmvp/bloc/report_and_block_cubit.dart';
import 'package:stubudmvp/services/database/initialization.dart';
import 'package:stubudmvp/services/firebase_api.dart';
import 'package:stubudmvp/views/screens/signup_login_screens/signIn.dart';
import 'package:stubudmvp/views/screens/profile_and_filtering_screens/buddyProfile.dart';
import 'package:stubudmvp/views/screens/profile_and_filtering_screens/deactivatedProfile.dart';
import 'package:stubudmvp/views/screens/signup_login_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:stubudmvp/views/screens/welcome.dart';

import 'package:stubudmvp/views/screens/signup_login_screens/more.dart';


import 'package:stubudmvp/views/screens/deleteProfile_screens/causes.dart';

import 'package:stubudmvp/views/screens/deleteProfile_screens/sure.dart';

import 'services/database/db_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constant/constant.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
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
        
        BlocProvider<ReportBlockCubit>(
           create: (_) => ReportBlockCubit(flaskBaseUrl),
        )
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
        theme: ThemeData(fontFamily: 'Outfit'),
        routes: {
      "login": (context) => const Login(),
      "signin": (context) => const signIn(),
      "mainpage": (context) => const DeactivatedProfileScreen(),
      
      
          
      "Explorebuddiespage": (context) => const buddyProfile(),
      "more": (context) => const More(),
      "causes": (context) => const Causes(),
      "sure": (context) => const Sure(),
    },
    home: const Welcome(),

    );
  }
}
