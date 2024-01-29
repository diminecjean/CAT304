import 'package:express_all/firebase_options.dart';
import 'package:express_all/src/config/config_color.dart';
import 'package:express_all/src/pages/account/addChild_page.dart';
import 'package:express_all/src/pages/account/login_page.dart';
import 'package:express_all/src/pages/dashboard/dashboard_page.dart';
import 'package:express_all/src/pages/facial_expression_recognition/emotionGestureRecognition_page.dart';
import 'package:express_all/src/pages/facial_expression_recognition/gestureRecognition_page.dart';
import 'package:express_all/src/pages/score_page.dart';
import 'package:express_all/src/pages/main_menu_page.dart';
import 'package:express_all/src/pages/onboarding_page.dart';
import 'package:express_all/src/pages/account/signup_page.dart';
import 'package:express_all/src/pages/account/chooseAccountType_page.dart';
import 'package:express_all/src/pages/account/signup_children_page.dart';
import 'package:express_all/src/pages/facial_expression_recognition/facialExpression_page.dart';
import 'package:express_all/src/pages/task_mangement/prioritySetting_page.dart';
import 'package:express_all/src/pages/task_mangement/taskIdentification_page.dart';
import 'package:express_all/src/pages/task_mangement/taskManagement_page.dart';
import 'package:express_all/src/pages/task_mangement/taskSequencing_page.dart';
import 'package:express_all/src/pages/emotion_detection/emotion_detect_page.dart';
import 'package:express_all/src/pages/parent_menu_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); // Replace with your app's name
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Express All',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 241, 233),
        primaryColor: ConfigColor.getMaterialColor(const Color(0xFF8F312C)),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        // primarySwatch: ConfigColor.getMaterialColor(Color(0xFF8F312C)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 245, 241, 233),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        // TODO
        // textTheme: const TextTheme(
        //   displayLarge: TextStyle(
        //     fontSize: 32.0,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'YourHeadingFont', // Replace with your heading font
        //     color: Colors.black, // Change to your preferred color
        //   ),
        //   displayMedium: TextStyle(
        //     fontSize: 24.0,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'YourTitleFont', // Replace with your title font
        //     color: Colors.black87, // Change to your preferred color
        //   ),
        //   // Add more text styles for different types of text here
        // ),
      ),
      initialRoute: '/Onboarding',
      routes: <String, WidgetBuilder>{
        '/Onboarding': (BuildContext context) => const OnBoardingPage(),
        '/Login': (BuildContext context) => const LoginPage(),
        '/ParentSignUp': (BuildContext context) => const ParentSignUpPage(),
        '/ChildSignUp': (BuildContext context) => const ChildSignUpPage(
              fromPage: "child",
            ),
        '/ChooseAccountType': (BuildContext context) =>
            const ChooseAccountTypePage(),
        '/MainMenu': (BuildContext context) => const MainMenuPage(),
        '/AddChild': (BuildContext context) => AddChildPage(),
        '/EmotionGestureRecognition': (BuildContext context) =>
            const emotionGestureRecognitionPage(),
        '/FacialExpression': (BuildContext context) =>
            const FacialExpressionPage(),
        '/GestureRecognition': (BuildContext context) =>
            const GestureRecognitionPage(),
        '/ScoreScreen': (BuildContext context) => const ScoreScreen(
              questionType: "none",
            ),
        '/TaskManagement': (BuildContext context) => const TaskManagementPage(),
        '/TaskIdentification': (BuildContext context) =>
            const TaskIdentificationPage(),
        '/TaskSequencing': (BuildContext context) => const TaskSequencingPage(),
        '/PrioritySetting': (BuildContext context) =>
            const PrioritySettingPage(),
        '/Dashboard': (BuildContext context) => const DashboardPage(),
        '/EmotionDetection': (BuildContext context) =>
            const EmotionDetectionPage(),
        '/ParentMenu': (BuildContext context) => const ParentMenuPage(),
      },
    );
  }
} 
