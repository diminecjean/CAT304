import 'package:express_all/src/components/toast.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/pages/account/signup_children_page.dart';
import 'package:express_all/src/services/auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// TODO: should have a skip button
// TODO: should have a backward button
class AddChildPage extends StatefulWidget {
  AddChildPage({Key? key}) : super(key: key);

  @override
  _AddChildPageState createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();

  bool isAddingChild = false;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Add Your Child"),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return backgroundColor;
                  },
                ),
              ),
              onPressed: () => {Navigator.pushNamed(context, "/ParentMenu")},
              child: const Text('Skip', style: TextStyle(color: primaryColor)),
            ),
          ],
        ),
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
            Image.asset(
              'assets/images/children.png',
              height: 100,
            ), // Replace with your asset image for child icon
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Colors.yellow[100], // Adjust the color to match the design
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.person),
                hintText: 'Email address',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                minimumSize:
                    const Size(double.infinity, 50), // Button width and height
              ),
              onPressed: () {
                _addChild();
              },
              child: const Text('Add'),
            ),
            const Spacer(), // Pushes the below content to the bottom of the screen
            Column(
              children: <Widget>[
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ChildSignUpPage(
                //           fromPage: "parent",
                //         ),
                //       ),
                //     );
                //   },
                //   child: const Text(
                //     "Your child don't have an account yet? Create one now!",
                //     style: TextStyle(color: primaryColor),
                //   ),
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Button text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    side:
                        const BorderSide(color: Colors.orange), // Border color
                    minimumSize: const Size(
                        double.infinity, 40), // Button width and height
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChildSignUpPage(
                          fromPage: "parent",
                        ),
                      ),
                    );
                  },
                  child: const Text('Create Child Account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addChild() async {
    setState(() {
      isAddingChild = true;
    });

    String childEmail = _emailController.text;
    User? user = await _auth.getCurrentUser();
    String? parentEmail = user?.email;
    bool success = await _auth.addChildtoParent(childEmail, parentEmail!);
    Logger().i(success);
    if (success) {
      Logger().i("Child is successfully added");
      showToast(message: "Child is successfully added");
      Navigator.pushNamed(context, "/ParentMenu");
    } else {
      Logger().e("Fail to add child");
    }

    setState(() {
      isAddingChild = false;
    });
  }
}
