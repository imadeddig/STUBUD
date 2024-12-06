import 'package:stubudmvp/aiteur/screens/edit_account_info.dart';
import 'package:stubudmvp/aiteur/screens/report.dart';
import 'package:stubudmvp/chatbud/chat_screen.dart';
import 'package:stubudmvp/chatbud/list_messages.dart';
import 'package:stubudmvp/farial/beCool.dart';
import 'package:stubudmvp/farial/field.dart';
import 'package:stubudmvp/farial/settings.dart';
import 'package:stubudmvp/farial/shots.dart';
import 'package:stubudmvp/farial/signIn.dart';
import 'package:stubudmvp/farial/speciality.dart';
import 'package:stubudmvp/farial/year.dart';
import 'package:stubudmvp/imad/buddyProfile.dart';
import 'package:stubudmvp/imad/deactivatedProfile.dart';
import 'package:stubudmvp/imad/exploreBuddiesPage.dart';
import 'package:stubudmvp/information.dart';
import 'package:stubudmvp/interest1.dart';
import 'package:stubudmvp/interest2.dart';
import 'package:stubudmvp/interest3.dart';
import 'package:stubudmvp/interest4.dart';
import 'package:stubudmvp/interest5.dart';
import 'package:stubudmvp/login.dart';
import 'package:flutter/material.dart';
import 'package:stubudmvp/welcome.dart';
import 'package:stubudmvp/chatbud/chatbud1.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized(); 


  runApp(const App());
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
        'signin': (context) => const signIn(),
        'info': (context) => const Infor(),
        "interest": (context) => const Interest1(),
        "interest5": (context) => const Interest5(),
        "interest4": (context) => const Interest4(),
        "interest2": (context) => const Interest2(),
        "interest3": (context) => const Interest3(),
        "chutbud1": (context) => const Chatbud1(),
        "aiteur": (context) => const EditAccountInfoScreen(),
        "farial": (context) => const beCool(),
        "imad": (context) => const Explorebuddiespage(),
        "specialite": (context) => const Speciality(),
        "shots": (context) => const Shots(),
        'mainpage': (context) => DeactivatedProfileScreen(),
        "settings": (context) => const Settings(),
        "field": (context) => const Field(),
        "year": (context) => const Year(),
        "report": (context) => ReportScreen(),
        "chatlist": (context) => ChatListScreen(),
        "editinfoscreen"  :(context) =>const  EditAccountInfoScreen()  , 
        "becool":(context) =>const beCool(),
        "chatpage" : (context) =>const  ChatScreen(name: "cc", image:"images/profile .png" , initialMessages: [],) , 
        "Explorebuddiespage" : (context)=> const  buddyProfile()
        
      },
    );
  }
}
