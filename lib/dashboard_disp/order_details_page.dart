import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../dashboard_learner/get_inspired_page.dart';
import '../dashboard_learner/view_com_achive_page.dart';
import '../pages/dashboard_disp.dart';
import 'google_map.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderNumber;
  const OrderDetailsPage({Key? key, required this.orderNumber});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  bool _collectedPressed = false;
  bool _deliveredPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Order: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                TextSpan(
                  text: '${widget.orderNumber}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: Container(
              width: 370,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Set background color to gray
                borderRadius: BorderRadius.circular(20), // Round the borders
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 10, 10),
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Text('Collection',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 40,),
                            Text('Vendor1',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 40,),
                            Center(
                              child: Text(
                                '100, ABC Avenue, \nSri Lanka',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 40,),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Open Navigation',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: _collectedPressed ? FontWeight.bold : FontWeight.normal,
                                  decoration: _collectedPressed ? TextDecoration.underline : TextDecoration.none,
                                  decorationThickness: _collectedPressed ? 2.0 : 1.0,
                                ),
                              ),
                            ),

                            SizedBox(height: 40,),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _collectedPressed = true;
                                  _deliveredPressed = false;
                                });
                              },
                              child: Text(
                                'Collected',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _collectedPressed ? Colors.green : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50,30,0,0),
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Text('Delivery',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 40,),
                            Text('Aakeef Marickar',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 40,),
                            Center(child: Text('111, XYZ Avenue, \nSri Lanka',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),),
                            SizedBox(height: 30,),
                            TextButton(
                              onPressed: () {
                                print('pressed2');
                              },
                              child: Text(
                                'Open Navigation',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: _collectedPressed ? FontWeight.normal : FontWeight.bold,
                                  decoration: _collectedPressed ? TextDecoration.none : TextDecoration.underline,
                                  decorationThickness: _collectedPressed ? 1.0 : 2.0,
                                ),
                              ),
                            ),


                            SizedBox(height: 40,),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _collectedPressed = false;
                                  _deliveredPressed = true;
                                });
                              },
                              child: Text(
                                'Delivered',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _deliveredPressed ? Colors.green : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
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
          SizedBox(height: 30,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashBoardDisp(),
                ),
              );
            },

            child: Text(
              '      Back      ',
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
        ],
      ),
    );
  }
}
