import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:express_all/src/components/toast.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/services/auth/firebase_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:express_all/src/models/articles.dart';
import 'package:express_all/src/pages/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:express_all/src/services/auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
          url: question['url'],
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
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
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
              ListTile(
                leading: Icon(Icons.house_outlined),
                title: Text('Autistic Centres'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AutisticCentres()),
                  );
                },
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FutureBuilder<User?>(
                            future: _auth.getCurrentUser(),
                            builder: (BuildContext context,
                                AsyncSnapshot<User?> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                Logger().i('loading firestore');
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text('Welcome back');
                              } else {
                                var parentEmail = snapshot.data?.email;
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
                                            .where('userType',
                                                isEqualTo: 'child')
                                            .where('parent',
                                                isEqualTo: parentEmail)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasError ||
                                              snapshot.data!.docs.isEmpty) {
                                            showToast(
                                                message:
                                                    'Error: ${snapshot.error}');
                                            Logger().i('No child found');
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/addChild.png",
                                                  height: 120,
                                                ),
                                                const Text('⚠️ No child found',
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                const Text(
                                                    'Add your child now!',
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      foregroundColor:
                                                          Colors.white,
                                                      backgroundColor: Theme.of(
                                                              context)
                                                          .primaryColor, // Use white color for the button text
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                18.0), // Rounded corners for the button
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 32.0,
                                                          vertical:
                                                              12.0), // Padding inside the button
                                                    ),
                                                    child: const Text(
                                                      '+   Add your child',
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context, '/AddChild');
                                                    },
                                                  ),
                                                ),
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
                                                    children: snapshot
                                                        .data!.docs
                                                        .map((DocumentSnapshot
                                                            document) {
                                                      Map<String, dynamic>
                                                          data = document.data()
                                                              as Map<String,
                                                                  dynamic>;
                                                      Logger().i('Data: $data');
                                                      return Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xFF270303),
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        color: Colors.white,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  IconButton(
                                                                    icon: Icon(Icons
                                                                        .cancel_outlined),
                                                                    onPressed: () =>
                                                                        showDialog<
                                                                            String>(
                                                                      context:
                                                                          context,
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          Dialog(
                                                                        backgroundColor:
                                                                            backgroundColor,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 5,
                                                                              horizontal: 10),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              const SizedBox(height: 15),
                                                                              Text(
                                                                                'Are you sure you want to remove ${data['username']}?',
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
                                                                                    child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () async {
                                                                                      await FirebaseAuthService().removeChildFromParent(data['email'], parentEmail!);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: const Text(
                                                                                      'Remove Child',
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
                                                                  ),
                                                                ],
                                                              ),
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
                                                                        data[
                                                                            'username'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                primaryColor,
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        "${data['age']} years old",
                                                                        style: TextStyle(
                                                                            color:
                                                                                primaryColor,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_circle_right,
                                                                  color: Color(
                                                                      0xFFFF9051),
                                                                  size: 50,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              DashboardPage(
                                                                        userEmail:
                                                                            data['email'],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                                const SizedBox(height: 5.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(width: 10.0),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor: Theme
                                                                  .of(context)
                                                              .primaryColor, // Use white color for the button text
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18.0), // Rounded corners for the button
                                                          ),
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 32.0,
                                                              vertical:
                                                                  12.0), // Padding inside the button
                                                        ),
                                                        child: const Text(
                                                          '+   Add your child',
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/AddChild');
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                  ],
                                                ),
                                                const SizedBox(height: 20.0),
                                                const Text(
                                                  '  Articles for you',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w700,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0),
                                                  height: 380,
                                                  width: 380,
                                                  child: ArticlesPageView(
                                                      articles: _articles),
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                  ],
                                );
                              }
                            })
                      ]))
            ]));
  }
}

class ArticlesPageView extends StatefulWidget {
  final List<ArticlesModel> articles;

  const ArticlesPageView({Key? key, required this.articles}) : super(key: key);

  @override
  _ArticlesPageViewState createState() => _ArticlesPageViewState();
}

class _ArticlesPageViewState extends State<ArticlesPageView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      key: const PageStorageKey('articlePageView'),
      itemCount: widget.articles.length,
      controller: PageController(viewportFraction: 0.8),
      onPageChanged: (index) => setState(() => _index = index),
      itemBuilder: (context, index) {
        var item = widget.articles[index];
        return AnimatedPadding(
          duration: const Duration(milliseconds: 400),
          padding: EdgeInsets.all(2.0),
          child: Container(
            width: 230, // Set the width of the card here
            child: Card(
              color: Colors.white,
              elevation: 4,
              child: Column(
                children: [
                  Image.asset(
                    item.image,
                    height: 180,
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
                      _launchURL(item.url);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _launchURL(String url) async {
    Uri ssUrl = Uri.parse(url);
    Logger().i(ssUrl);
    if (await canLaunchUrlString("<$url>")) {
      Logger().i('Launching url: $url');
      await launchUrlString("<$url>");
    } else {
      Logger().e('Could not launch $url');
      showToast(message: 'Could not launch $url');
    }
  }
}

class AutisticCentres extends StatefulWidget {
  AutisticCentres({Key? key}) : super(key: key);

  @override
  _AutisticCentresState createState() => _AutisticCentresState();
}

class _AutisticCentresState extends State<AutisticCentres> {
  String? selectedState;
  List<AutisticCentreModel> centres = [
    AutisticCentreModel(
        name: "Autism Behavioral Center",
        state: "Kuala Lumpur",
        district: "Bangsar",
        description:
            "This center is located in Bangsar, Kuala Lumpur. It is the largest 1:1 ABA (Applied Behavior Analysis) Center in Malaysia, with 40 individual therapy rooms. They offer center-based behavioral intervention using principles of ABA (Applied Behavior Analysis) to improve speech and communication, social skills, behavior, independence, and school readiness skills. They also provide home-based behavioral intervention, shadow AIDE/PLA support, free autism screening, and autism awareness talk in schools/organizations. The center is supervised directly by a Board Certified Behavior Analyst (BCBA) ensuring high-quality ABA therapy is delivered according to international standards.",
        contactNumber: "+6012-2852007"),
    AutisticCentreModel(
        name: "Alisther Rehabilitation & Intervention Centre",
        state: "Kuala Lumpur",
        district: "Bukit Jalil",
        description:
            "This center is located in Bukit Jalil, Kuala Lumpur. They provide early intervention programs for children with autism, ADHD, and other developmental disorders. They offer occupational therapy, speech therapy, and physiotherapy services. ",
        contactNumber: "+603-8999 2020"),
    AutisticCentreModel(
        name: "Enso International Academy",
        state: "Kuala Lumpur",
        district: "TTDI",
        description:
            "This center is located in TTDI, Kuala Lumpur. They provide early intervention programs for children with autism, ADHD, and other developmental disorders. They offer occupational therapy, speech therapy, and physiotherapy services.",
        contactNumber: "+603-7733 8555"),
    AutisticCentreModel(
        name: "HappyLand Psychology & Therapy Centre",
        state: "Johor",
        district: "Johor Bahru",
        description:
            "They provide early intervention programs for children with autism, ADHD, and other developmental disorders. They offer occupational therapy, speech therapy, and physiotherapy services.",
        contactNumber: "+607-361 3366"),
    AutisticCentreModel(
        name: "Miles Autism Academy",
        state: "Selangor",
        district: "Petaling Jaya",
        description:
            "This center is located in Petaling Jaya, Selangor. They provide early intervention programs for children with autism, ADHD, and other developmental disorders. They offer occupational therapy, speech therapy, and physiotherapy services.",
        contactNumber: "+603-7957 1118"),
    AutisticCentreModel(
        name: "The Lions REACh",
        state: "Penang",
        district: "Bukit Gelugor",
        description:
            "This center is located in Bukit Gelugor, Penang. They provide early intervention programs for children with autism, ADHD, and other developmental disorders. They offer occupational therapy, speech therapy, and physiotherapy services.",
        contactNumber: "+604-656 4357",
        email: "lionsreach@yahoo.com"),
    AutisticCentreModel(
        name: "Caterpillar ABA House",
        state: "Penang",
        district: "Tanjung Tokong",
        description:
            "This center is located in Tanjung Tokong, Penang. They provide 1-to-1 intensive ABA therapy for children with Autism Spectrum Disorder (ASD) and other Special Needs in Penang. They offer occupational therapy, speech therapy, and physiotherapy services.",
        contactNumber: "+6012-4949532"),
    AutisticCentreModel(
        name: "NASOM Penang",
        state: "Penang",
        district: "Bayan Lepas",
        description:
            "This center is located in Bayan Lepas, Penang. They provide early intervention programs for children and adults with autism. They offer occupational therapy, speech therapy, and physiotherapy services. ",
        contactNumber: "+604-658 7034",
        email: "nasompg@gmail.com"),
  ];

  @override
  Widget build(BuildContext context) {
    var states = centres.map((centre) => centre.state).toSet().toList();
    var centresInSelectedState =
        centres.where((centre) => centre.state == selectedState).toList();

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Autistic Centres",
        style: TextStyle(
            color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
      )),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedState,
            items: states.map((state) {
              return DropdownMenuItem<String>(
                value: state,
                child: Text(state),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedState = value;
              });
            },
            hint: Text('Select a state'),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: centresInSelectedState.length,
              itemBuilder: (context, index) {
                var centre = centresInSelectedState[index];
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.all(8),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            centre.name,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${centre.district}, ${centre.state}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(children: [
                            Text(
                              centre.description,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: const Color.fromARGB(221, 0, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextButton(
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
                                      vertical:
                                          12.0), // Padding inside the button
                                ),
                                onPressed: () => launchUrl(
                                    Uri.parse("tel:${centre.contactNumber}")),
                                child: Text("Contact: ${centre.contactNumber}"),
                              ),
                            ),
                            if (centre.email !=
                                null) // Check if email is not null
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextButton(
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
                                        vertical:
                                            12.0), // Padding inside the button
                                  ),
                                  onPressed: () => launchUrl(
                                      Uri.parse("mailto:${centre.email}")),
                                  child: Text("Email: ${centre.email}"),
                                ),
                              ),
                          ]),
                        )
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AutisticCentreModel {
  final String name;
  final String state;
  final String district;
  final String description;
  final String contactNumber;
  final String? email;

  AutisticCentreModel(
      {required this.name,
      required this.state,
      required this.district,
      required this.description,
      required this.contactNumber,
      this.email});
}
