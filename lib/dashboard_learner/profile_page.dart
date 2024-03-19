import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/shop_page.dart';
import 'package:craftroots/dashboard_learner/track_order_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/user_type_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int current = 0;
  late PageController pageController; // Define PageController

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: current); // Initialize PageController
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
                // Navigate to the login screen or home screen after sign out
                // Example:
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
            icon: const Icon(Icons.logout), // Change the icon to your signout icon
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
                  if (user != null){
                    return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance.collection('learner_users').doc(user.email).get(),
                        builder: (context, documentSnapshot){
                          if (documentSnapshot.hasData && documentSnapshot.data != null) {
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
                                                  setState(() {
                                                    current = index;
                                                  });
                                                  pageController.animateToPage(
                                                    current,
                                                    duration: const Duration(milliseconds: 200),
                                                    curve: Curves.ease,
                                                  );
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
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
                                                        color: Colors.deepPurpleAccent,
                                                        width: 2.5)
                                                        : null,
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          icons[index],
                                                          size: current == index ? 23 : 20,
                                                          color: current == index
                                                              ? Colors.black
                                                              : Colors.black,
                                                        ),
                                                        Text(
                                                          items[index],
                                                          style: GoogleFonts.ubuntu(
                                                            fontWeight: FontWeight.w500,
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
                                                      shape: BoxShape.circle),
                                                ),
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                  /// MAIN BODY
                                  Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    width: 370,
                                    height: 575,
                                    child: PageView.builder(
                                      itemCount: icons.length,
                                      controller: pageController,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return _buildPage(index, documentSnapshot);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          else {
                            return const CircularProgressIndicator();
                          }
                        }
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }  else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPage(int index, AsyncSnapshot<DocumentSnapshot> documentSnapshot) {
    switch (index) {
      case 0: // Profile Page
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Basic Details',
                      style: TextStyle(
                        fontSize: 18, // Set the desired font size
                        fontWeight: FontWeight.bold, // Make the text bold
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  'Name :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Text(
                                  'Email :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Text(
                                  'Password :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documentSnapshot.data?.get('name'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  documentSnapshot.data?.get('email'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  documentSnapshot.data?.get('password'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 190,
                decoration: BoxDecoration(
                  color: Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Delivery Details',
                    style: TextStyle(
                    fontSize: 18, // Set the desired font size
                    fontWeight: FontWeight.bold, // Make the text bold
                    ),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  'Address :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Text(
                                  'Contact :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Text(
                                  'City :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documentSnapshot.data?.get('address'),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  documentSnapshot.data?.get('contact'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  documentSnapshot.data?.get('city'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 190,
                decoration: BoxDecoration(
                  color: Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Card Details',
                      style: TextStyle(
                      fontSize: 18, // Set the desired font size
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  'Cardholder Name :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Text(
                                  'Card Number :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Text(
                                  'End Date :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documentSnapshot.data?.get('cardholder_name'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  documentSnapshot.data?.get('card_number'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  documentSnapshot.data?.get('expire_date'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
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
      case 1: // Material Request Page
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffEEEEEE),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 285,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('active_order').where('id', isGreaterThan: '').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator while waiting for data
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Show error if encountered
                  } else {
                    final List<Widget> orderWidgets = [];
                    // Add "Order" and "Status" text widgets
                    orderWidgets.add(
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Active Order',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                    // Iterate through each document in the snapshot
                    snapshot.data!.docs.forEach((doc) {
                      final date = doc['date'];
                      final amount = doc['amount'];
                      final package = doc['package'];

                      // Create a widget for each document's details
                      final orderWidget = Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        'Date:',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                                      child: Text(
                                        'Package:',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                                      child: Text(
                                        'Total:',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$date',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        '$amount',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        '$package',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          SizedBox(height: 10,),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TrackOrderPage(),
                                  ),
                                );
                              },// Add your icon here
                              child: Text(
                                'Track Order',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffebd9b4), // Change button color to black
                              ),
                            ),
                            Divider(
                              color: Colors.grey, // Change the color to blue
                              height: 20, // Change the height to 20
                              thickness: 2, // Optional: Set the thickness of the Divider
                              indent: 20, // Optional: Set the left indentation
                              endIndent: 20, // Optional: Set the right indentation
                            ),

                          ],
                        ),
                      );
                      // Add the widget to the list of order widgets
                      orderWidgets.add(orderWidget);
                    },);
                    // Return a ListView to display all order widgets
                    return ListView(
                      children: orderWidgets,
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffEEEEEE),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 270,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('past_order').where('id', isGreaterThan: '').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator while waiting for data
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Show error if encountered
                  } else {
                    final List<Widget> orderWidgets = [];

                    // Add "Order" and "Status" text widgets
                    orderWidgets.add(
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Past Order',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );

                    // Iterate through each document in the snapshot
                    snapshot.data!.docs.forEach((doc) {
                      final date = doc['date'];
                      final amount = doc['amount'];
                      final package = doc['package'];

                      // Create a widget for each document's details
                      final orderWidget = Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(
                                        'Date:',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                                      child: Text(
                                        'Package:',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                                      child: Text(
                                        'Total:',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$date',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        '$amount',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        '$package',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey, // Change the color to blue
                              height: 20, // Change the height to 20
                              thickness: 2, // Optional: Set the thickness of the Divider
                              indent: 20, // Optional: Set the left indentation
                              endIndent: 20, // Optional: Set the right indentation
                            ),
                          ],
                        ),
                      );
                      // Add the widget to the list of order widgets
                      orderWidgets.add(orderWidget);
                    });

                    // Return a ListView to display all order widgets
                    return ListView(
                      children: orderWidgets,
                    );
                  }
                },
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Text(
            value ?? '-',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
