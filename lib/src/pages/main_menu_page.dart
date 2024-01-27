import 'package:flutter/material.dart';

// TODO: Retrieve username for the AppBar
// TODO: Have to let emotion button able to click and save something

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Welcome back, Brendan'), // TODO: Have to retrieve the username.
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Text color
        elevation: 0, // Removes the shadow
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Allows scrolling when content is too long for the screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  EmotionButton(
                      imagePath: 'assets/images/face_1_happy.png',
                      color: Colors.lightGreen),
                  EmotionButton(
                      imagePath: 'assets/images/face_2_sad.png',
                      color: Colors.yellow),
                  EmotionButton(
                      imagePath: 'assets/images/face_3_angry.png',
                      color: Colors.redAccent),
                  EmotionButton(
                      imagePath: 'assets/images/face_4_normal.png',
                      color: Colors.lightBlue),
                ],
              ),
              const SizedBox(height: 30, width: 100),
              Center(
                child: MenuCard(
                  title: 'Ready to learn?',
                  onTap: () {
                    Navigator.pushNamed(context, "/FacialExpression");
                  },
                  imagePath:
                      'assets/images/menu_1.png', // Replace with your asset image path
                ),
              ),
              Center(
                child: MenuCard(
                  title: 'Emotion and Gesture Recognition Practice',
                  onTap: () {
                    Navigator.pushNamed(context, "/FacialExpression");
                  },
                  imagePath:
                      'assets/images/menu_2.png', // Replace with your asset image path
                ),
              ),
              Center(
                child: MenuCard(
                  title: 'Task Management',
                  onTap: () {
                    Navigator.pushNamed(context, "/TaskManagement");
                  },
                  imagePath:
                      'assets/images/menu_3_task_mngment.png', // Replace with your asset image path
                ),
              ),
              Center(
                child: MenuCard(
                  title: 'Emotion Detection',
                  onTap: () {
                    Navigator.pushNamed(context, "/Dashboard");
                  },
                  imagePath:
                      'assets/images/menu_4_emotion_detection.png', // Replace with your asset image path
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmotionButton extends StatelessWidget {
  final String imagePath;
  final Color color;

  const EmotionButton({
    Key? key,
    required this.imagePath,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Add your tap handling logic here
      },
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 50, // Set the image width
            height: 68, // Set the image height
            fit: BoxFit
                .cover, // Covers the area without changing the aspect ratio
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String imagePath;
  final double width;

  const MenuCard({
    Key? key,
    required this.title,
    required this.onTap,
    required this.imagePath,
    this.width = 700,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: width, // Apply minimum width constraints
        maxWidth: width, // Apply maximum width constraints
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(imagePath,
                    width: 100, height: 100), // Image for the card
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
