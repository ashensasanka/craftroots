import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/screens/video_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../dashboard_learner/chat_bot.dart';
import '../dashboard_learner/chat_page.dart';
import '../dashboard_learner/find_learning_page.dart';
import '../dashboard_learner/forum_page.dart';
import '../dashboard_learner/get_inspired_page.dart';
import '../dashboard_learner/learning_material_page.dart';
import '../dashboard_learner/profile_page.dart';
import '../dashboard_learner/shop_page.dart';
import '../dashboard_learner/track_learning_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isPurchased = false; // Flag to track premium status

  @override
  void initState() {
    super.initState();
    // Call function to check premium status when the widget initializes
    checkPremiumStatus();
  }

  Future<void> checkPremiumStatus() async {
    // Retrieve the premium field value for the current user from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('learner_users')
        .doc('ashen1@gmail.com')
        .get();
    // Check if the premium field exists and if it's true
    if (userDoc.exists && userDoc.get('purchase') == true) {
      setState(() {
        isPurchased = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard_learner'),
          actions: [
            IconButton(
              iconSize: 45,
              icon: Icon(Icons.person_pin_circle_outlined), // Icon to display
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  String username =
                                      documentSnapshot.data!.get('name');
                                  return Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Hi, $username !',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              });
                        }
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        height: 175,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FindLearningPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffDADADA),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(0, 3), // Offset of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 10,
                                  right: 10,
                                  child: Container(
                                    height: 110,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Adjust the radius according to your preference
                                      child: Image.asset(
                                        'images/find_learning.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                //
                                Positioned(
                                  bottom: 5,
                                  left: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Find Learning",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Have you got no idea \nabout what suits you most",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 175,
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to MyListingPage only if the user is premium
                            if (isPurchased) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrackLearningPage(),
                                ),
                              );
                            } else {
                              // Show a message or handle the case when the user is not premium
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'You need to be a premium user to access this feature.'),
                              ));
                            }
                          },
                          child: Container(
                            width: 160,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffDADADA),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(0, 3), // Offset of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 10,
                                  right: 10,
                                  child: Container(
                                    height: 112,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Adjust the radius according to your preference
                                      child: Image.asset(
                                        'images/track_learning.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 15,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Track Learning",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      Text(
                                        "Track learning progress",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        height: 175,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffDADADA),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(0, 3), // Offset of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 10,
                                  right: 10,
                                  child: Container(
                                    height: 110,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Adjust the radius according to your preference
                                      child: Image.asset(
                                        'images/shop.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 18,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Shop",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      Text(
                                        "You can find different\n packages available",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 175,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoList(),
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffDADADA),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(0, 3), // Offset of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 10,
                                  right: 10,
                                  child: Container(
                                    height: 110,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Adjust the radius according to your preference
                                      child: Image.asset(
                                        'images/learning_material.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Learning Material",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      Text(
                                        "Access the video for the\n package you have purchased",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        height: 175,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForumPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffDADADA),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(0, 3), // Offset of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 10,
                                  right: 10,
                                  child: Container(
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Adjust the radius according to your preference
                                      child: Image.asset(
                                        'images/forum.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 17,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Forum",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      Text(
                                        "Find the CraftRoot’s \ncommunity",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 175,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GetInspiredPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffDADADA),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(0, 3), // Offset of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 10,
                                  right: 10,
                                  child: Container(
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Adjust the radius according to your preference
                                      child: Image.asset(
                                        'images/leader_board.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Get Inspired",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      Text(
                                        "Community achievement\n and add what you have \nlearned to get inspired",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 10, // Adjust the distance from the bottom as needed
                right: 75,
                child: Text(
                    'You can ask your \nquestions about \nthe sector or \nparticular craft')),
            Positioned(
              bottom: 20, // Adjust the distance from the bottom as needed
              right: 10, // Adjust the distance from the right as needed
              child: Container(
                width: 60, // Adjust the width of the container
                height: 60, // Adjust the height of the container
                decoration: BoxDecoration(
                    shape: BoxShape
                        .circle, // Shape of the container is set to circle
                    gradient: LinearGradient(colors: [
                      Color(0xfff9efdb),
                      Color(0xffebd9b4)
                    ]) // Background color of the container
                    ),
                child: IconButton(
                  iconSize: 30, // Adjust the size of the icon
                  icon:
                      Icon(Icons.messenger_outline_outlined), // Icon to display
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
