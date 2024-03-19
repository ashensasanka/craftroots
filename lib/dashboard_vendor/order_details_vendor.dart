import 'package:flutter/material.dart';

import '../dashboard_learner/get_inspired_page.dart';
import '../dashboard_learner/view_com_achive_page.dart';
import '../pages/dashboard_vendor.dart';

class OrderDetailsVendor extends StatefulWidget {
  final String orderNumber;
  const OrderDetailsVendor({super.key, required this.orderNumber});

  @override
  State<OrderDetailsVendor> createState() => _OrderDetailsVendorState();
}

class _OrderDetailsVendorState extends State<OrderDetailsVendor> {
  bool _isReadyForCollectionPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
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
              height: 480,
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
                            Text('Raw Material',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 40,),
                            Text('Yarn',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 40,),
                            Text('Crocheting Needle',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                            SizedBox(height: 40,),
                            Text(''),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40,30,0,0),
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Text('Quantity',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 40,),
                            Text('3',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 40,),
                            Text('2',
                              style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 40,),
                            if (!_isReadyForCollectionPressed) // Render this text only if not ready for collection
                              Text('Order Total: LKR.1900.00',
                                style: TextStyle(
                                    fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),),
                            if (_isReadyForCollectionPressed)
                              Text('                                  '),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isReadyForCollectionPressed = true;
                      });
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => GetInspiredPage(),
                      //   ),
                      // );
                    },
                    child: Text(
                      '  Ready for Collection  ',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isReadyForCollectionPressed ? Colors.green : Color(0xffebd9b4), // Change button color when pressed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Add border radius here
                      ),
                    ),
                  ),
                  if (!_isReadyForCollectionPressed) // Render this text only if not ready for collection
                    Text(' '),
                  if (_isReadyForCollectionPressed)
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashBoardVendor(),
                          ),
                        );
                      },
                      child: Text(
                        'Cancel Request',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(height: 40,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashBoardVendor(),
                ),
              );
            },

            child: Text(
              '      Back      ',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffebd9b4),
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
