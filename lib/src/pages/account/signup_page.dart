import 'package:express_all/src/services/auth/firebase_auth.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ParentSignUpPage extends StatefulWidget {
  const ParentSignUpPage({Key? key}) : super(key: key);

  @override
  _ParentSignUpPageState createState() => _ParentSignUpPageState();
}

class _ParentSignUpPageState extends State<ParentSignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
          'Create a parent account',
          style: TextStyle(
              fontSize: 20, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/parents.png", height: 120),
              const SizedBox(height: 10),
              _buildTextField(context,
                  controller: _usernameController,
                  icon: Icons.person,
                  label: 'Username'),
              const SizedBox(height: 16),
              _buildTextField(
                context,
                controller: _emailController,
                icon: Icons.email,
                label: 'Email',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context,
                controller: _phoneController,
                icon: Icons.phone,
                label: 'Phone Number',
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
              const SizedBox(height: 32),
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
    String email = _emailController.text;
    String password = _passwordController.text;
    String checkPassword = _checkpasswordController.text;
    String userType = "parent";
    if (password == checkPassword) {
      User? user = await _auth.signUpParent(
          email, password, username, userType, context);
      if (user != null) {
        showToast(message: "User is successfully created");
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

  Widget _buildTextField(BuildContext context,
      {required IconData icon,
      required String label,
      bool obscureText = false,
      TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.yellow[100], // Change this to match your color
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
}
