import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/cart_page.dart';
import 'package:craftroots/dashboard_learner/paymentdetails_page.dart';
import 'package:craftroots/dashboard_learner/shop_page.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const CheckoutPage({Key? key, required this.data}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch Firestore document data
  Future<void> _fetchUserData(String email) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('learner_users').doc(email).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        setState(() {
          phoneNumberController.text = userData['contact'] ?? ''; // Populate phone number field
          cityController.text = userData['city'] ?? ''; // Populate city field
          addressController.text = userData['address'] ?? ''; // Populate address field
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
        'contact': phoneNumberController.text,
        'city': cityController.text,
        'address': addressController.text,
      });
      print('User data updated successfully');
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    _fetchUserData('ashen4@gmail.com'); // Replace with user's email
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        title: Text(
          'Enter Your Delivery Details',
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
              'Phone number',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
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
              'City',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: 'Enter your city',
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
              'Address',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: addressController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter your address',
                filled: true,
                fillColor: Colors.grey[200], // Set your desired background color here
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Set the desired radius here
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 90,),
            Row(
              children: [
              SizedBox(width: 40,),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopPage(),
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
                  onPressed: () {
                    // Call function to update Firestore document
                    _updateUserData('ashen4@gmail.com'); // Replace with user's email

                    // Navigate to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(data:widget.data),
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
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    phoneNumberController.dispose();
    cityController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
