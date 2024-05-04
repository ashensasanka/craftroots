import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/shop_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const CartPage({Key? key, required this.data}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int quantity1 = 0;
  int quantity2 = 0;
  int quantity3 = 0;
  int quantity4 = 0;
  int quantity5 = 0;
  int quantity6 = 0;
  int pageno=0;
  List<String> nameParts = [];
  String firstPart = '';
  String secondPart = '';
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    List<String> nameParts = widget.data['item2name'].split(',');
    String firstPart = nameParts[0].trim();
    String secondPart = nameParts.length > 1 ? nameParts[1].trim() : '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Stack(
        children: [
          if (pageno==0)
          Positioned(
            bottom: 180,
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
                    // Add button in the top left corner
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 10, 0, 0),
                      child: SizedBox(
                          width: 193, // Set the desired width
                          height: 33, // Set the desired height
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShopPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ), // Add your icon here
                            label: Text(
                              'Continue Shopping',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffebd9b4), // Change button color to black
                            ),
                          ),
                        ),
                    ),
                    const SizedBox(height: 10), // Add spacing between button and text
                    const Text(
                        '                   Item     Price   Quantity   Subtotal',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const Divider(thickness: 2,),
                    Center(
                      child: Text(
                        widget.data['name'],
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(height: 15), // Add spacing to align with text
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                          child: Container(
                            width: 70, // Adjust width as needed
                            height: 50, // Adjust height as needed
                            child: Image.network(
                              widget.data['imageUrl'], // Replace with your image URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(
                          'Video \nTutorial',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(
                          'LKR ${widget.data['price']}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(
                          'This isn\'t a \nchoice',
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          'LKR ${widget.data['price']}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                          child: Container(
                            width: 70, // Adjust width as needed
                            height: 50, // Adjust height as needed
                            child: Image.network(
                              widget.data['item1Url'], // Replace with your image URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(
                          widget.data['item1name'],
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(
                          'LKR ${widget.data['item1Price']}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 7,),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity1 > 0) {
                                quantity1--;
                              }
                            });
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey, // Set the background color here
                            borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adjust padding as needed
                          child: Text(
                            '$quantity1', // Display the current quantity
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white, // Set text color
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity1++;
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                        Text(
                          'LKR ${quantity1 * widget.data['item1Price']}', // Display the quantity multiplied by 100 with the currency symbol
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ), // Add spacing between image and text
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                          child: Container(
                            width: 70, // Adjust width as needed
                            height: 50, // Adjust height as needed
                            child: Image.network(
                              widget.data['item2Url'], // Replace with your image URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          children: [
                            Text(
                              firstPart,
                              style: TextStyle(
                                fontSize: 11
                              ),
                            ),
                            if (secondPart.isNotEmpty)
                              Text(
                                secondPart,
                              ),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Text(
                          'LKR ${widget.data['item2Price']}',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 7,),
                        SizedBox(
                          width: 30, // Set the desired width of the button
                          height: 33, // Set the desired height of the button
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity2 > 0) {
                                    quantity2--;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove),
                              iconSize: 18, // Set the desired icon size
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey, // Set the background color here
                            borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adjust padding as needed
                          child: Text(
                            '$quantity2', // Display the current quantity
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white, // Set text color
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30, // Set the desired width of the button
                          height: 40,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity2++;
                                });
                              },
                              icon: Icon(Icons.add,size: 20,),
                            ),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          'LKR ${quantity2 * widget.data['item2Price']}', // Display the quantity multiplied by 100 with the currency symbol
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80,),
                    Row(
                      children: [
                        SizedBox(width: 150,),
                        Column(
                          children: [
                            Text('Order Subtotal: '),
                            Text('Delivery Charges(fixed): '),
                            Text('Order Total: '),
                          ],
                        ),
                        Column(
                          children: [
                            Text('${widget.data['price']+quantity2 * widget.data['item2Price']+quantity1 * widget.data['item1Price']}'),
                            Text('${widget.data['Dcharges']}'),
                            Text('${widget.data['Dcharges']+widget.data['price']+quantity2 * widget.data['item2Price']+quantity1 * widget.data['item1Price']}'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Conditionally render the second SizedBox
          if (pageno==1)
            Positioned(
              bottom: 180,
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
                      // Add button in the top left corner
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 10, 0, 0),
                        child: SizedBox(
                          width: 193, // Set the desired width
                          height: 33, // Set the desired height
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShopPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ), // Add your icon here
                            label: Text(
                              'Continue Shopping',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffebd9b4), // Change button color to black
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing between button and text
                      Text(
                        '                   Item     Price   Quantity   Subtotal',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(thickness: 2,),
                      Center(
                        child: Text(
                          'Knitting and Crocheting  (Beginner)',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 15), // Add spacing to align with text
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            child: Container(
                              width: 70, // Adjust width as needed
                              height: 50, // Adjust height as needed
                              child: Image.network(
                                'https://www.thebestideasforkids.com/wp-content/uploads/2021/01/Crafts-for-Kids-Kits.jpg', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'Video \nTutorial',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'LKR ${widget.data['price']}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'This isn\'t a \nchoice',
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          SizedBox(width: 20,),
                          Text(
                            'LKR ${widget.data['price']}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            child: Container(
                              width: 70, // Adjust width as needed
                              height: 50, // Adjust height as needed
                              child: Image.network(
                                'https://m.media-amazon.com/images/I/61MVB+6MIwL.jpg', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'Tjanting \nTool',
                            style: TextStyle(
                                fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'LKR ${widget.data['item1Price']}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 7,),
                          SizedBox(
                            width: 30, // Set the desired width of the button
                            height: 33, // Set the desired height of the button
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity3 > 0) {
                                      quantity3--;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                                iconSize: 18, // Set the desired icon size
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey, // Set the background color here
                              borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adjust padding as needed
                            child: Text(
                              '$quantity3', // Display the current quantity
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white, // Set text color
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30, // Set the desired width of the button
                            height: 40,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity3++;
                                });
                              },
                              icon: Icon(Icons.add,size: 20,),
                            ),
                          ),
                          Text(
                            'LKR ${quantity3 * widget.data['item1Price']}', // Display the quantity multiplied by 100 with the currency symbol
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ), // Add spacing between image and text
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            child: Container(
                              width: 70, // Adjust width as needed
                              height: 50, // Adjust height as needed
                              child: Image.network(
                                'https://www.waxmeltingtools.com/wp-content/uploads/2018/06/Batik-pen-sq.jpg', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'Crocheting\n Needle',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'LKR ${widget.data['item2Price']}',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 7,),
                          SizedBox(
                            width: 30, // Set the desired width of the button
                            height: 33, // Set the desired height of the button
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity4 > 0) {
                                      quantity4--;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                                iconSize: 18, // Set the desired icon size
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey, // Set the background color here
                              borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adjust padding as needed
                            child: Text(
                              '$quantity4', // Display the current quantity
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white, // Set text color
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30, // Set the desired width of the button
                            height: 40,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity4++;
                                });
                              },
                              icon: Icon(Icons.add,size: 20,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'LKR ${quantity4 * widget.data['item2Price']}', // Display the quantity multiplied by 100 with the currency symbol
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 80,),
                      Row(
                        children: [
                          SizedBox(width: 150,),
                          Column(
                            children: [
                              Text('Order Subtotal: '),
                              Text('Delivery Charges(fixed):: '),
                              Text('Order Total: '),
                            ],
                          ),
                          Column(
                            children: [
                              Text('${widget.data['price']+quantity4 * widget.data['item2Price']+quantity3 * widget.data['item1Price']}'),
                              Text('${widget.data['Dcharges']}'),
                              Text('${widget.data['Dcharges']+widget.data['price']+quantity4 * widget.data['item2Price']+quantity3 * widget.data['item1Price']}'),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 130,),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (pageno > 0) {
                                  pageno--;
                                }
                              });
                            },
                            icon: Icon(Icons.arrow_back),
                            iconSize: 18, // Set the desired icon size
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                pageno++;
                              });
                            },
                            icon: Icon(Icons.arrow_forward_outlined),
                            iconSize: 18, // Set the desired icon size
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (pageno==2)
            Positioned(
              bottom: 180,
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
                      // Add button in the top left corner
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 10, 0, 0),
                        child: SizedBox(
                          width: 193, // Set the desired width
                          height: 33, // Set the desired height
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShopPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ), // Add your icon here
                            label: Text(
                              'Continue Shopping',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffebd9b4), // Change button color to black
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing between button and text
                      Text(
                        '                   Item     Price   Quantity   Subtotal',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(thickness: 2,),
                      Center(
                        child: Text(
                          'Jewellery (Advanced)',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 15), // Add spacing to align with text
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            child: Container(
                              width: 70, // Adjust width as needed
                              height: 50, // Adjust height as needed
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/craftroots-e578e.appspot.com/o/shop%2Fimage%205.jpg?alt=media&token=f2b9168f-1d8d-4536-898d-803e85505fde', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'Video \nTutorial',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'LKR ${widget.data['price']}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'This isn\'t a \nchoice',
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          SizedBox(width: 20,),
                          Text(
                            'LKR ${widget.data['price']}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            child: Container(
                              width: 70, // Adjust width as needed
                              height: 50, // Adjust height as needed
                              child: Image.network(
                                'https://m.media-amazon.com/images/I/81zl7WwZuYL._AC_UF1000,1000_QL80_.jpg', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'Pliers',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'LKR ${widget.data['item1Price']}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 7,),
                          SizedBox(
                            width: 30, // Set the desired width of the button
                            height: 33, // Set the desired height of the button
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity5 > 0) {
                                      quantity5--;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                                iconSize: 18, // Set the desired icon size
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey, // Set the background color here
                              borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adjust padding as needed
                            child: Text(
                              '$quantity5', // Display the current quantity
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white, // Set text color
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30, // Set the desired width of the button
                            height: 40,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity5++;
                                });
                              },
                              icon: Icon(Icons.add,size: 20,),
                            ),
                          ),
                          Text(
                            'LKR ${quantity5 * widget.data['item1Price']}', // Display the quantity multiplied by 100 with the currency symbol
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ), // Add spacing between image and text
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            child: Container(
                              width: 70, // Adjust width as needed
                              height: 50, // Adjust height as needed
                              child: Image.network(
                                'https://lucywalkerjewellery.com/wp-content/uploads/2021/07/1-5-1024x1024.jpg', // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'Gem \nCutter',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            'LKR ${widget.data['item2Price']}',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 7,),
                          SizedBox(
                            width: 30, // Set the desired width of the button
                            height: 33, // Set the desired height of the button
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity6 > 0) {
                                      quantity6--;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                                iconSize: 18, // Set the desired icon size
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey, // Set the background color here
                              borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adjust padding as needed
                            child: Text(
                              '$quantity6', // Display the current quantity
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white, // Set text color
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30, // Set the desired width of the button
                            height: 40,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity6++;
                                });
                              },
                              icon: Icon(Icons.add,size: 20,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'LKR ${quantity6 * widget.data['item2Price']}', // Display the quantity multiplied by 100 with the currency symbol
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 80,),
                      Row(
                        children: [
                          SizedBox(width: 160,),
                          Column(
                            children: [
                              Text('Order Subtotal: '),
                              Text('Delivery Charges(fixed): '),
                              Text('Order Total: '),
                            ],
                          ),
                          Column(
                            children: [
                              Text('${widget.data['price']+quantity6 * widget.data['item2Price']+quantity5 * widget.data['item1Price']}'),
                              Text('${widget.data['Dcharges']}'),
                              Text('${widget.data['Dcharges']+widget.data['price']+quantity6 * widget.data['item2Price']+quantity5 * widget.data['item1Price']}'),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 130,),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (pageno > 0) {
                                  pageno--;
                                }
                              });
                            },
                            icon: Icon(Icons.arrow_back),
                            iconSize: 18, // Set the desired icon size
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (pageno >= 2) {
                                  pageno = 0;
                                } else {
                                  pageno++;
                                }
                              });
                            },
                            icon: Icon(Icons.arrow_forward_outlined),
                            iconSize: 18, // Set the desired icon size
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 100,
            left: 110,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  CollectionReference cartCollection =
                  FirebaseFirestore.instance.collection('active_order${user?.uid}');
                  Map<String, dynamic> dataWithDate = {
                    ...widget.data,
                    'date': FieldValue.serverTimestamp(),
                  };
                  await cartCollection.add(dataWithDate);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(data: widget.data),
                    ),
                  );
                } catch (e) {
                  print('Error adding document to Firestore: $e');
                }
              },// Add your icon here
              child: Text(
                'Continue to Checkout',
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
