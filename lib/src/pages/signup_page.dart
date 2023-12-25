// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../components/custom_text_field.dart';
import '../config/config_color.dart';
import '../config/style/style.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text("Sign Up", style: Style.pageName()),
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 400,
                  height: 250,
                  child: Image(
                    image: AssetImage('static/images/Log In Picture.png'),
                    width: 250,
                  ),
                ),
              ),
            ),
            CustomTextField(
                labelText: 'Email',
                hintText: 'Enter a valid email. E.g. abc@gmail.com'),
            CustomTextField(
              labelText: 'Password',
              hintText: 'Enter secure password',
              obscureText: true,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                  color: ConfigColor.getMaterialColor(Color(0xFF22541D)),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
            SizedBox(
              height: 80,
            ),
            GestureDetector(
              child: Text("Already have an account? Log in here."),
              onTap: () => Navigator.pushNamed(context, "/login"),
            ),
          ],
        ),
      ),
    );
  }
}
