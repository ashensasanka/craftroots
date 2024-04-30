import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/checkout_page.dart';
import 'package:craftroots/dashboard_learner/confirm_order_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'cart_page.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const PaymentPage({Key? key, required this.data}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isChecked = false;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch Firestore document data
  Future<void> _fetchUserData(String email) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('learner_users').doc(email).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        setState(() {
          cardNumberController.text = userData['card_number'] ?? ''; // Populate phone number field
          cardNameController.text = userData['cardholder_name'] ?? ''; // Populate city field
          endDateController.text = userData['expire_date'] ?? '';// Populate address field
        });
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // Function to update Firestore document
  Future<void> _updateUserData(String email) async {
    try {
      await _firestore.collection('learner_users').doc(email).update({
        'card_number': cardNumberController.text,
        'cardholder_name': cardNameController.text,
        'expire_date': endDateController.text,
      });
      print('User data updated successfully');
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email ?? ''; // Get the user's email
      // Now you can use the email to fetch user data
      _fetchUserData(email);
    } else {
      print('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        title: Text(
          'Enter Your Payment Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              Text(
                'Cardholder Name ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: cardNameController,
                decoration: InputDecoration(
                  hintText: 'Enter name',
                  filled: true,
                  fillColor: Colors.grey[200], // Set your desired background color here
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Set the desired radius here
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Card Number ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: cardNumberController,
                decoration: InputDecoration(
                  hintText: 'Enter Card Number  ',
                  filled: true,
                  fillColor: Colors.grey[200], // Set your desired background color here
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Set the desired radius here
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'End Date',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10), // Add some spacing between the text and the TextFormField
                      Container(
                        width: 150, // Set the desired width here
                        child: TextFormField(
                          controller: endDateController,
                          decoration: InputDecoration(
                            hintText: 'MM/YYYY',
                            filled: true,
                            fillColor: Colors.grey[200], // Set your desired background color here
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0), // Set the desired radius here
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width:60,),
                  Column(
                    children: [
                      Text(
                        'CVV',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10), // Add some spacing between the text and the TextFormField
                      Container(
                        width: 150, // Set the desired width here
                        child: TextFormField(
                          controller: cvvController,
                          decoration: InputDecoration(
                            hintText: 'xxx',
                            filled: true,
                            fillColor: Colors.grey[200], // Set your desired background color here
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0), // Set the desired radius here
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Save Card Details ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked = newValue!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 70,),
              Row(
                children: [
                  SizedBox(width: 40,),
                  ElevatedButton.icon(
                    onPressed: () {
                                         // Navigate to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(data: {},),
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
                      side: BorderSide(color: Colors.black), // Add border color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Add border radius here
                      ),
                    ),
                  ),
                  SizedBox(width: 50,),
                  ElevatedButton(
                    onPressed:  _isChecked
                        ? () {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        String email = user.email ?? ''; // Get the user's email
                        // Now you can use the email to fetch user data
                        _updateUserData(email);
                      } else {
                        print('User not logged in');
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmOrderPage(data: widget.data,),
                        ),
                      );
                    }
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmOrderPage(data:widget.data),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffebd9b4), // Change button color to black
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Set the desired border radius
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to start and end
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
      ),
    );
  }
}
