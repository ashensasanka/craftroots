import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craftroots/dashboard_learner/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDescriptionPage extends StatefulWidget {
  const ProductDescriptionPage({super.key});

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  List<bool> starPressedState = [false, false, false, false, false];
  void updateStarColors(int index) {
    setState(() {
      for (int i = 0; i <= index; i++) {
        starPressedState[i] = true;
      }
      for (int i = index + 1; i < starPressedState.length; i++) {
        starPressedState[i] = false;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments['data'].data() as Map<String, dynamic>;
    // documents[index].data() as Map<String, dynamic>;
    // Product product = Get.arguments['data'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shop', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data['imageUrl'],
                fit: BoxFit.contain,
                width: double.infinity,
                height: 250,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              // product.name ?? '',
              data['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                for (int i = 0; i < 5; i++)
                  Icon(
                    Icons.star,
                    color: i < data['rate'] ? Colors.yellow : Colors.grey.withOpacity(0.5),
                    size: 24,
                  ),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    // product.description ?? '',
                    data['description'],
                    style: const TextStyle(
                        fontSize: 16,
                        height: 1.5
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 180,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffebd9b4)
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  onPressed: () async {
                    try {
                      // Get a reference to the Firestore cart collection
                      CollectionReference cartCollection =
                      FirebaseFirestore.instance.collection('cart');

                      // Add a new document to the cart collection with the data
                      await cartCollection.add(data);

                      // Navigate to the CartPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage(data: data,)),
                      );
                    } catch (e) {
                      print('Error adding to cart: $e');
                      // Handle error
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Rate this page'),
            Row(
              children: [
                for (int i = 0; i < starPressedState.length; i++)
                  GestureDetector(
                    onTap: () {
                      updateStarColors(i);
                    },
                    child: Icon(
                      Icons.star,
                      color: starPressedState[i] ? Colors.yellow : Colors.grey.withOpacity(0.5),
                      size: 24,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Set your desired background color here
                borderRadius: BorderRadius.circular(10), // Set the desired radius here
              ),
              child: SizedBox(
                width: double.infinity, // Set your desired width here
                height: 200, // Set your desired height here
                child: Column(
                  children: [
                    Text(
                      'Have you ever heard the following facts about traditional knitting and crochet?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat incididunt ut labore.'),
                  ],
                ), // Replace 'data' with the widget you want to place inside SizedBox
              ),
            )
          ],
        ),
      ),
    );
  }
}
