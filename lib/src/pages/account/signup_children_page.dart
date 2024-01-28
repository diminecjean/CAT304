import 'package:express_all/src/services/auth/firebase_auth.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChildSignUpPage extends StatefulWidget {
  final String fromPage;
  const ChildSignUpPage({Key? key, required this.fromPage}) : super(key: key);

  @override
  _ChildSignUpPageState createState() => _ChildSignUpPageState();
}

class _ChildSignUpPageState extends State<ChildSignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkpasswordController =
      TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Create a child account',
          style: TextStyle(
              fontSize: 20, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/children.png", height: 120),
              const SizedBox(height: 10),
              _buildTextField(context,
                  controller: _usernameController,
                  icon: Icons.person,
                  label: 'Username'),
              const SizedBox(height: 16),
              _buildTextField(context,
                  controller: _ageController,
                  icon: Icons.person_2,
                  label: 'Age'),
              const SizedBox(height: 16),
              _buildTextField(
                context,
                controller: _emailController,
                icon: Icons.email,
                label: 'Email',
              ),
              const SizedBox(height: 16),
              _buildTextField(context,
                  controller: _passwordController,
                  icon: Icons.lock,
                  label: 'Password',
                  obscureText: true),
              const SizedBox(height: 16),
              _buildTextField(
                context,
                controller: _checkpasswordController,
                icon: Icons.lock,
                label: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // SizedBox(
              //   width: double.infinity, // Match parent width
              //   child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  _signUp();
                },
                child: Center(
                  child: isSigningUp
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Create Account",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String age = _ageController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String checkPassword = _checkpasswordController.text;
    String userType = "child";

    if (password == checkPassword) {
      User? user = await _auth.signUpChild(
          email, password, username, age, userType, context, widget.fromPage);
      if (user != null) {
        showToast(message: "User is successfully created");
        // Navigator.pushNamed(context, "/MainMenu");
      } else {
        showToast(message: "Fail to create user");
      }
    } else {
      showToast(message: "Password does not match");
    }
    setState(() {
      isSigningUp = false;
    });
  }
}

Widget _buildTextField(
  BuildContext context, {
  TextEditingController? controller,
  required IconData icon,
  required String label,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFFFE894), // Change this to match your color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(icon,
          color: Colors.grey[600]), // Change this to match your color
      labelText: label,
    ),
  );
}
