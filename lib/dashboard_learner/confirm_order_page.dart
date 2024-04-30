import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/paymentdetails_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/home_controller.dart';
import 'checkout_page.dart';
import 'order_palced_page.dart';

class ConfirmOrderPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const ConfirmOrderPage({Key? key, required this.data}) : super(key: key);

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  String address = '';
  String cardNumber = '';
  String cart ='';

  // Function to fetch Firestore document data
  Future<void> _fetchUserData(String email) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('learner_users').doc(email).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        setState(() {
          address = userData['address'] ?? ''; // Get address field
          cardNumber = userData['card_number'] ?? ''; // Get card_number field
        });
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
  Future<void> _fetchCartData(String documentId) async {
    try {
      DocumentSnapshot cartSnapshot = await _firestore.collection('cart').doc(documentId).get();
      if (cartSnapshot.exists) {
        Map<String, dynamic> cartData = cartSnapshot.data() as Map<String, dynamic>;
        setState(() {
          cart = '${cartData['item1name']},${cartData['item2name']}';
        });
      } else {
        print('Cart document does not exist');
      }
    } catch (e) {
      print('Error fetching cart data: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    _fetchCartData('0HTfP8QTisE8GzRUcq1G');
    _fetchUserData(user?.email as String); // Replace with user's email
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffEEEEEE),
          title: Text(
            'Confirm Order',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),

              Text(
                'DELIVERY ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 25,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15,),
                  Text(
                    address, // Display address here
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Divider(
                thickness: 2,
              ),

              SizedBox(height: 40,),

              Text(
                'CART ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: Colors.black,
                  ),
                  Text(
                    cart,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text(
                    'LKR: 1500.00',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Divider(
                thickness: 2,
              ),

              SizedBox(height: 40,),

              Text(
                'PAYMENT ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Icon(
                    Icons.credit_card_outlined,
                    // This is the icon you want to display
                    size: 25, // Adjust the size of the icon as needed
                    color: Colors.black, // Set the color of the icon
                  ),
                  SizedBox(width: 20,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'VISA ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue, // Set the color for VISA text
                          ),
                        ),
                        TextSpan(
                          text: cardNumber,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 20,),

              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 40,),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(data: {},),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Back',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black),
                      // Add border color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Add border radius here
                      ),
                    ),
                  ),
                  SizedBox(width: 50,),
                  ElevatedButton(
                    onPressed: () {
                      ctrl.addVideos(widget.data['by'],widget.data['level'],widget.data['name'],widget.data['imageUrl'],widget.data['videoUrl']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPlacePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffebd9b4),
                      // Change button color to black
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Set the desired border radius
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Align children to start and end
                      children: [
                        Text(
                          'Next Step ',
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
