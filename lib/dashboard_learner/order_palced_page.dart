import 'package:craftroots/dashboard_learner/track_order_page.dart';
import 'package:flutter/material.dart';

import '../pages/dashboard_learner.dart';
import '../screens/video_list.dart';
import 'checkout_page.dart';

class OrderPlacePage extends StatefulWidget {
  const OrderPlacePage({Key? key}) : super(key: key);

  @override
  State<OrderPlacePage> createState() => _OrderPlacePageState();
}

class _OrderPlacePageState extends State<OrderPlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        title: Text(
          'Your Order has been Placed',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 125,),
          Center(
            child: Icon(
              Icons.check_circle_outline, // You can change the icon as needed
              size: 150, // Adjust the size of the icon as needed
              color: Colors.black, // Set the color of the icon
            ),
          ),
          SizedBox(height: 40,),
          Center(
            child: Text(
              'Congratulations. Your order is \nsuccessful.',
              textAlign: TextAlign.center, // Align text to center
              style: TextStyle(
                fontSize: 20, // Increase text size
              ),
            ),
          ),

              Text(
                  'your order has been Placed',
                  textAlign: TextAlign.center, // Align text to center
                  style: TextStyle(
                    fontSize: 15, // Increase text size
                  ),
                ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoList(),
                    ),
                  );
                },
                child: Text(
                  'Click here to access the video',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5,
                    decorationColor: Colors.blue,
                  ),
                ),
              ),

          SizedBox(height: 70,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackOrderPage(),
                ),
              );
            },
            child: Text(
              'Track Order',
              style: TextStyle(color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffebd9b4),
              side: BorderSide(color: Colors.white), // Add border color here
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Add border radius here
              ),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashBoard(),
                ),
              );
            },
            child: Text(
              'Home',
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
        ],
      ),
    );
  }
}
