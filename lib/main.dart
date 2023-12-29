import 'package:express_all/src/config/config_color.dart';
import 'package:express_all/src/pages/home_page.dart';
import 'package:express_all/src/pages/login_page.dart';
import 'package:express_all/src/pages/onboarding_page.dart';
import 'package:express_all/src/pages/signup_page.dart';
import 'package:express_all/src/pages/chooseAccountType_page.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Express All',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ConfigColor.getMaterialColor(Color(0xFF8F312C)),
        // textTheme: GoogleFonts.robotoTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        // primarySwatch: ConfigColor.getMaterialColor(Color(0xFF8F312C)),
        // TODO
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'YourHeadingFont', // Replace with your heading font
            color: Colors.black, // Change to your preferred color
          ),
          displayMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'YourTitleFont', // Replace with your title font
            color: Colors.black87, // Change to your preferred color
          ),
          // Add more text styles for different types of text here
        ),
      ),
      initialRoute: '/onboarding',
      routes: <String, WidgetBuilder>{
        '/onboarding': (BuildContext context) => OnBoardingPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/signup': (BuildContext context) => SignUpPage(),
        '/home': (BuildContext context) => HomePage(),
        '/chooseAccountType': (BuildContext context) => ChooseAccountTypePage()
      },
    );
  }
}

// class SignInPage extends StatelessWidget {
//   const SignInPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign In')),
//       body: Center(child: Text('Welcome to the Sign In Page')),
//     );
//   }
// }

// class CreateAccountPage extends StatelessWidget {
//   const CreateAccountPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Create Account')),
//       body: Center(child: Text('Welcome to the Create Account Page')),
//     );
//   }
// }

