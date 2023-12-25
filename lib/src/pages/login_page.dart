import 'package:express_all/src/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../config/config_color.dart';
import '../config/style/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Express All'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ICON',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFFE894),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Username',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFFE894),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot your password?'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9051),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(double.infinity,
                      50), // double.infinity is the width and 50 is the height
                ),
                //TODO: change navigation
                onPressed: () => Navigator.pushNamed(context, "/signup"),
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child:
                    const Text('Don\'t have an account yet? Create one now!'),
              ),
              const SizedBox(height: 20),
              //  GestureDetector(
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F1E9),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text('Create Account'),
                onPressed: () => Navigator.pushNamed(context, "/signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
