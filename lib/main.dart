import 'package:express_all/src/config/config_color.dart';
import 'package:express_all/src/pages/account/addChild_page.dart';
import 'package:express_all/src/pages/home_page.dart';
import 'package:express_all/src/pages/account/login_page.dart';
import 'package:express_all/src/pages/onboarding_page.dart';
import 'package:express_all/src/pages/account/signup_page.dart';
import 'package:express_all/src/pages/account/chooseAccountType_page.dart';
import 'package:express_all/src/pages/account/signup_children_page.dart';
import 'package:express_all/src/pages/facial_expression_recognition/facialExpression_page.dart';

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
        '/ChildSignUp': (BuildContext context) => const ChildSignUpPage(),
        '/Home': (BuildContext context) => const HomePage(),
        '/ChooseAccountType': (BuildContext context) => const ChooseAccountTypePage(),
        '/AddChild': (BuildContext context) => const AddChildPage(),
        '/FacialExpression': (BuildContext context) => const FacialExpressionPage(),
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

