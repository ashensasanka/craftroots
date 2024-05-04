import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/shop_page.dart';
import 'package:craftroots/dashboard_learner/track_order_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/profile_text_box.dart';
import '../components/text_box.dart';
import '../pages/user_type_page.dart';
import '../widget/page_builder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int current = 0;
  late PageController pageController;
  final userCollection = FirebaseFirestore.instance.collection("learner_users");
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(user?.email).update({field: newValue});
    }
  }

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: current); // Initialize PageController
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      "Profile",
      "History",
    ];

    List<IconData> icons = [
      Icons.person,
      Icons.history,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            onPressed: () async {
              // Sign out the current user
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserTypePage(),
                  ),
                );
              } catch (e) {
                print('Error signing out: $e');
                // Handle signout error
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User? user = snapshot.data;
                  if (user != null) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('learner_users')
                          .doc(user.email)
                          .get(),
                      builder: (context, documentSnapshot) {
                        if (documentSnapshot.hasData &&
                            documentSnapshot.data != null) {
                          String username = documentSnapshot.data!.get('name');
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  'Hi, $username !',
                                  style: TextStyle(fontSize: 18),
                                ),

                                /// Tab Bar
                                SizedBox(
                                  width: double.infinity,
                                  height: 80,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: items.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) {
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  current = index;
                                                },
                                              );
                                              pageController.animateToPage(
                                                current,
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                curve: Curves.ease,
                                              );
                                            },
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              margin: const EdgeInsets.all(5),
                                              width: 183,
                                              height: 55,
                                              decoration: BoxDecoration(
                                                color: current == index
                                                    ? Colors.white70
                                                    : Color(0xffebd9b4),
                                                borderRadius: current == index
                                                    ? BorderRadius.circular(12)
                                                    : BorderRadius.circular(7),
                                                border: current == index
                                                    ? Border.all(
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                        width: 2.5)
                                                    : null,
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      icons[index],
                                                      size: current == index
                                                          ? 23
                                                          : 20,
                                                      color: current == index
                                                          ? Colors.black
                                                          : Colors.black,
                                                    ),
                                                    Text(
                                                      items[index],
                                                      style: GoogleFonts.ubuntu(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: current == index
                                                            ? Colors.black
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: current == index,
                                            child: Container(
                                              width: 5,
                                              height: 5,
                                              decoration: const BoxDecoration(
                                                color: Colors.deepPurpleAccent,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),

                                /// MAIN BODY
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  width: 370,
                                  height: 575,
                                  child: PageView.builder(
                                    itemCount: icons.length,
                                    controller: pageController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return PageBuilder.buildPage(
                                          index, context, documentSnapshot);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    );
                  }
                  return const Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
