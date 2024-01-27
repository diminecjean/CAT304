import 'package:flutter/material.dart';

class ParentMenuPage extends StatelessWidget {
  const ParentMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home (Parents)'),
        // ... other AppBar properties
      ),
      // ... other Scaffold properties
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Welcome back, Choo',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Your Child',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/child_avatar.png'),
                      // Replace with NetworkImage if the image is online
                    ),
                    title: Text('Brendan'),
                    subtitle: Text('7 years old'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to child details or actions
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor, // Use white color for the button text
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0), // Rounded corners for the button
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0), // Padding inside the button
                  ),
                  child: const Text(
                    '+ Add your child',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () {
                    // Define what happens when the button is pressed
                    // Usually, navigate to a new screen where the user can add a child
                  },
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Articles for you',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/autisticEvent1.jpeg'),
                      ListTile(
                        title: Text('The Art of Autism Exhibition'),
                        subtitle: Text('A Autism Awareness Programme'),
                        onTap: () {
                          // Handle tap on this article
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/autisticEvent2.png'),
                      ListTile(
                        title: Text('Parenting a Child on the Autism Spectrum'),
                        onTap: () {
                          // Handle tap on this article
                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
