import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:express_all/src/models/articles.dart';
import 'package:flutter/material.dart';
import 'package:express_all/src/services/auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

class ParentMenuPage extends StatefulWidget {
  const ParentMenuPage({Key? key}) : super(key: key);

  @override
  _ParentMenuPageState createState() => _ParentMenuPageState();
}

class _ParentMenuPageState extends State<ParentMenuPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final List<ArticlesModel> _articles = articles
      .map(
        (question) => ArticlesModel(
          id: question['id'],
          title: question['title'],
          caption: question['caption'],
          image: question['image'],
        ),
      )
      .toList();
  int _index = 0;

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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<User?>(
                  future: _auth.getCurrentUser(),
                  builder:
                      (BuildContext context, AsyncSnapshot<User?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      Logger().i('loading firestore');
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Welcome back');
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back, ${snapshot.data?.displayName ?? 'User'}',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 20.0),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('userType', isEqualTo: 'child')
                                .where('parent',
                                    isEqualTo: (snapshot.data?.email))
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError ||
                                  snapshot.data!.docs.isEmpty) {
                                showToast(message: 'Error: ${snapshot.error}');
                                Logger().i('No child found');
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/addChild.png",
                                      height: 120,
                                    ),
                                    const Text('⚠️ No child found',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const Text('Add your child now!',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                );
                              } else {
                                Logger().i('child found');
                                return Column(
                                  children: [
                                    const Text(
                                      'Your Child',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document
                                              .data() as Map<String, dynamic>;
                                          Logger().i('Data: $data');
                                          return Card(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Color(0xFF270303),
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/menu_5_profile_pic.png",
                                                        height: 80,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data['username'],
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            "${data['age']} years old",
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.arrow_circle_right,
                                                      color: Color(0xFFFF9051),
                                                      size: 50,
                                                    ),
                                                    // TODO: Load dashboard based on user data
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          "/Dashboard");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),

                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context)
                              .primaryColor, // Use white color for the button text
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                18.0), // Rounded corners for the button
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 12.0), // Padding inside the button
                        ),
                        child: const Text(
                          '+   Add your child',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/AddChild');
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                ),
                const SizedBox(height: 40.0),
                const Text(
                  '  Articles for you',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  height: 380,
                  width: 380,
                  child: PageView.builder(
                    itemCount: _articles.length,
                    controller: PageController(viewportFraction: 0.8),
                    onPageChanged: (index) => setState(() => _index = index),
                    itemBuilder: (context, index) {
                      var item = _articles[index];
                      return AnimatedPadding(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastOutSlowIn,
                        padding: EdgeInsets.all(_index == index ? 0.0 : 8.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 4,
                          child: Column(
                            children: [
                              Image.asset(
                                item.image,
                                height: 200,
                              ),
                              ListTile(
                                title: Text(
                                  item.title,
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text(
                                  item.caption,
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                onTap: () {
                                  // Handle tap on this article
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Card(
                //   child: Column(
                //     children: <Widget>[
                //       Image.asset('assets/images/autisticEvent1.jpeg'),
                //       ListTile(
                //         title: Text('The Art of Autism Exhibition'),
                //         subtitle: Text('A Autism Awareness Programme'),
                //         onTap: () {
                //           // Handle tap on this article
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10.0),
                // Card(
                //   child: Column(
                //     children: <Widget>[
                //       Image.asset('assets/images/autisticEvent2.png'),
                //       ListTile(
                //         title: Text('Parenting a Child on the Autism Spectrum'),
                //         onTap: () {
                //           // Handle tap on this article
                //         },
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
