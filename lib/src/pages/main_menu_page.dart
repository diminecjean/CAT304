import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/services/auth/firebase_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:express_all/src/services/auth/firebase_auth.dart';
import 'package:get/get.dart';

// TODO: Have to let emotion button able to click and save something

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  String? selectedMood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
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
      ),
      drawer: Drawer(
        width: 240,
        backgroundColor: backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
                height: 300,
                child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: backgroundColor,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/expressall_icon.png",
                          height: 200,
                        ),
                        const Spacer(),
                      ],
                    ))),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  backgroundColor: backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 15),
                        const Text(
                          'Are you sure you want to log out?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            TextButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/Login', (route) => false);
                              },
                              child: const Text(
                                'Log Out',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Allows scrolling when content is too long for the screen
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FutureBuilder<User?>(
                        future: _auth.getCurrentUser(),
                        builder: (BuildContext context,
                            AsyncSnapshot<User?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text('Welcome back');
                          } else {
                            return Text(
                              'Welcome back, ${snapshot.data?.displayName ?? 'User'}',
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/images/menu_5_profile_pic.png",
                    height: 70,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(68, 252, 252, 252),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1F4F4F4F),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'How are you feeling today?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: primaryColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          EmotionButton(
                            imagePath: 'assets/images/face_1_happy.png',
                            color: Colors.lightGreen,
                            mood: "Happy",
                            selectedMood: selectedMood,
                            onSelect: (mood) =>
                                setState(() => selectedMood = mood),
                          ),
                          EmotionButton(
                            imagePath: 'assets/images/face_2_sad.png',
                            color: Colors.yellow,
                            mood: "Sad",
                            selectedMood: selectedMood,
                            onSelect: (mood) =>
                                setState(() => selectedMood = mood),
                          ),
                          EmotionButton(
                            imagePath: 'assets/images/face_3_angry.png',
                            color: Colors.redAccent,
                            mood: "Angry",
                            selectedMood: selectedMood,
                            onSelect: (mood) =>
                                setState(() => selectedMood = mood),
                          ),
                          EmotionButton(
                            imagePath: 'assets/images/face_4_normal.png',
                            color: Colors.lightBlue,
                            mood: "Normal",
                            selectedMood: selectedMood,
                            onSelect: (mood) =>
                                setState(() => selectedMood = mood),
                          ),
                        ],
                      )
                    ],
                  )),
              const SizedBox(height: 30, width: 100),
              Center(
                child: MenuCard(
                  title: 'Emotion and Gesture Recognition Practice',
                  onTap: () {
                    Navigator.pushNamed(context, "/EmotionGestureRecognition");
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
                    Navigator.pushNamed(context, "/EmotionDetection");
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
  final String mood;
  final String? selectedMood;
  final ValueChanged<String> onSelect;

  const EmotionButton({
    Key? key,
    required this.imagePath,
    required this.color,
    required this.mood,
    this.selectedMood,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestoreService _firestore = FirebaseFirestoreService();

    return GestureDetector(
      onTap: () {
        // Update the selected mood
        onSelect(mood);

        // TODO: Add your tap handling logic
        _firestore.updateUserMood(mood, DateTime.now());
      },
      child: Opacity(
        // Dim the button if it's selected
        opacity: selectedMood == mood ? 0.4 : 1,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 40, // Set the image width
              height: 58, // Set the image height
              fit: BoxFit
                  .cover, // Covers the area without changing the aspect ratio
            ),
          ],
        ),
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
        color: Colors.white,
        // shadowColor: Color(0x1F4F4F4F),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(imagePath,
                    width: 100, height: 100), // Image for the card
                const SizedBox(height: 10),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
