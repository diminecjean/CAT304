import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParentSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Create a parent account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(context, icon: Icons.person, label: 'Username'),
            const SizedBox(height: 16),
            _buildTextField(context, icon: Icons.phone, label: 'Phone'),
            const SizedBox(height: 16),
            _buildTextField(context, icon: Icons.email, label: 'Email'),
            const SizedBox(height: 16),
            _buildTextField(context, icon: Icons.lock, label: 'Password', obscureText: true),
            const SizedBox(height: 16),
            _buildTextField(context, icon: Icons.lock, label: 'Confirm password', obscureText: true),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity, // Match parent width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0), // Padding inside the button
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/AddChild');
                },
                child: const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required IconData icon, required String label, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.yellow[100], // Change this to match your color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: Colors.grey[600]), // Change this to match your color
        labelText: label,
      ),
    );
  }
}

