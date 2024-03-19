import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/pages/user_type_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboard_disp/order_details_page.dart';

class DashBoardDisp extends StatefulWidget {
  const DashBoardDisp({super.key});
  @override
  State<DashBoardDisp> createState() => _DashBoardDispState();
}
class _DashBoardDispState extends State<DashBoardDisp> {
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
      "Material Request",
    ];
    List<IconData> icons = [
      Icons.person,
      Icons.local_activity,
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard_Disp'),
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
        ],),
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
                                                  width: 185,
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
                                    decoration: BoxDecoration(
                                      color: Color(0xffEEEEEE),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.only(top: 30),
                                    width: 360,
                                    height: 450,
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
        return Container(
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.only(top: 30),
          width: 360,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDetailRow('Name', documentSnapshot.data?.get('name')),
              _buildDetailRow('Email', documentSnapshot.data?.get('email')),
              _buildDetailRow('Password', documentSnapshot.data?.get('password')),
              _buildDetailRow('Location', documentSnapshot.data?.get('address')),
              _buildDetailRow('Phone', documentSnapshot.data?.get('contact')),
            ],
          ),
        );
      case 1: // Material Request Page
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('dispatch_order').where('number', isGreaterThan: '').snapshots(),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
              // Iterate through each document in the snapshot
              snapshot.data!.docs.forEach((doc) {
                final orderNumber = doc['number'];
                final status = doc['status'];
                // Create a widget for each document's details
                final orderWidget = Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '$orderNumber',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailsPage(orderNumber:orderNumber),
                              ),
                            );
                          },
                          child: Text(
                            '$status',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                            ),
                          ),
                        ),
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
