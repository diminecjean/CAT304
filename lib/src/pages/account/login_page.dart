import 'package:express_all/src/auth/firebase_auth.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Express All',
          style: TextStyle(
              fontSize: 20, color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/expressall_icon.png", height: 180),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFFE894),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Email Address',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFFE894),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Password',
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot your password?',
                  style: TextStyle(color: primaryColor),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9051),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: const Size(double.infinity,
                      50), // double.infinity is the width and 50 is the height
                ),
                onPressed: () => _signIn(),
                child: Center(
                  child: _isSigning
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/MainMenu');
                },
                child: const Text(
                  'Don\'t have an account yet? Create one now!',
                  style: TextStyle(color: primaryColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, "/ChooseAccountType"),
              ),
            ],
          )),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user =
        await _auth.signInWithEmailAndPassword(email, password, context);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "Successfully signed in");
      Navigator.pushNamed(context, "/MainMenu");
    } else {
      showToast(message: "some error occured");
    }
  }
}
