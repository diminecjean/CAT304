import 'package:flutter/material.dart';

class AddChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your child'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Text color
        elevation: 0, // Removes the shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20), // Spacing at the top
            Image.asset('assets/images/children.png', height: 100), // Replace with your asset image for child icon
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.yellow[100], // Adjust the color to match the design
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.person),
                hintText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // Button background color
                onPrimary: Colors.white, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                minimumSize: Size(double.infinity, 50), // Button width and height
              ),
              onPressed: () {
                // Action to add the child
              },
              child: const Text('Add'),
            ),
            const Spacer(), // Pushes the below content to the bottom of the screen
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ChildSignUp');
              },
              child: const Text("Your child don't have an account yet? Create one now!"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Button background color
                onPrimary: Colors.black, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                side: BorderSide(color: Colors.orange), // Border color
                minimumSize: Size(double.infinity, 50), // Button width and height
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/ChildSignUp');
              },
              child: Text('Create Child Account'),
            ),
          ],
        ),
      ),
    );
  }
}
