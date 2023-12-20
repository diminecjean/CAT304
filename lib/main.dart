import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Express All',
      home: Scaffold(
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
                    minimumSize: Size(double.infinity, 50), // double.infinity is the width and 50 is the height
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInPage()),
                    );
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text('Don\'t have an account yet? Create one now!'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F1E9),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateAccountPage()),
                    );
                  },
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(child: Text('Welcome to the Sign In Page')),
    );
  }
}

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Center(child: Text('Welcome to the Create Account Page')),
    );
  }
}

