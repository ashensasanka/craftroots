import 'package:craftroots/dashboard_learner/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LmaterialPlayPage extends StatefulWidget {
  const LmaterialPlayPage({super.key});

  @override
  State<LmaterialPlayPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<LmaterialPlayPage> {

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments['data'].data() as Map<String, dynamic>;
    // documents[index].data() as Map<String, dynamic>;
    // Product product = Get.arguments['data'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Play Video', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data['videoUrl'],
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
                Icon(
                  Icons.star,
                  color: Colors.yellow, // Set the color of the star icon
                  size: 24, // Set the size of the star icon
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow, // Set the color of the star icon
                  size: 24, // Set the size of the star icon
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow, // Set the color of the star icon
                  size: 24, // Set the size of the star icon
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow, // Set the color of the star icon
                  size: 24, // Set the size of the star icon
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey.withOpacity(0.5), // Set the color of the star icon
                  size: 24, // Set the size of the star icon
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
          ],
        ),
      ),
    );
  }
}
