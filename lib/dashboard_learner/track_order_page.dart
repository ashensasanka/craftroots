import 'package:craftroots/dashboard_learner/shop_page.dart';
import 'package:craftroots/pages/dashboard_learner.dart';
import 'package:flutter/material.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({super.key});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  int quantity = 0;
  int pageno=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        title: Text(
          'Status of your order',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 140,
            right: 21,
            child: SizedBox(
              width: 350,
              height: 500,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20), // Add spacing between button and text
                    Center(
                      child: Text(
                        'Status of your order',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 150),
                    Row(
                      children: [
                        Column(
                          children: [
                            Center(
                              child: Text(
                                'Order \nPlaced',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center, // Align the text within the center
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Background color
                                  shape: BoxShape.circle, // Make it round
                                ),
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black, // Text color
                                  ),
                                ),
                              ),
                            SizedBox(height: 35,)
                          ],
                        ),
                        Container(
                          width: 30,
                          height: 4,
                          color: Colors.black, // Line color
                        ),
                        Column(
                          children: [
                            SizedBox(height: 35,),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.black, // Background color
                                shape: BoxShape.circle, // Make it round
                              ),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Text color
                                ),
                              ),
                            ),
                            Text('Order Ready \nfor Collection',
                              style: TextStyle(
                                fontSize: 13, // Adjust the font size as needed
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Container(
                          width: 30,
                          height: 4,
                          color: Colors.black, // Line color
                        ),
                        Column(
                          children: [
                            Text('Order \nDispatched',
                              style: TextStyle(
                                fontSize: 13, // Adjust the font size as needed
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white, // Background color
                                shape: BoxShape.circle, // Make it round
                              ),
                              child: Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Text color
                                ),
                              ),
                            ),
                            SizedBox(height: 35,)
                          ],
                        ),
                        Container(
                          width: 30,
                          height: 4,
                          color: Colors.black, // Line color
                        ),
                        Column(
                          children: [
                            SizedBox(height: 35,),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.black, // Background color
                                shape: BoxShape.circle, // Make it round
                              ),
                              child: Text(
                                '4',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Text color
                                ),
                              ),
                            ),
                            Text('Order \nComplete',
                              style: TextStyle(
                                fontSize: 13, // Adjust the font size as needed
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 160,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashBoard(),
                  ),
                );
              },// Add your icon here
              child: Text(
                'Back',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffebd9b4), // Change button color to black
              ),
            ),
          ),
        ],
      ),
    );
  }
}
