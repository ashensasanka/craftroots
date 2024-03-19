import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widget/lmaterial_card.dart';
import '../widget/lmaterial_play_page.dart';
import '../widget/product_card.dart';
import '../widget/product_description_page.dart';

class LMaterialPage extends StatefulWidget {
  const LMaterialPage({super.key});

  @override
  State<LMaterialPage> createState() => _LMaterialPageState();
}

class _LMaterialPageState extends State<LMaterialPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: const Text('Learning Material',
            style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {}); // Refresh the UI when the text changes
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey, // Change the color to blue
            height: 20, // Change the height to 20
            thickness: 2, // Optional: Set the thickness of the Divider
            indent: 20, // Optional: Set the left indentation
            endIndent: 20, // Optional: Set the right indentation
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('learning_material')
                  .where('name', isGreaterThanOrEqualTo: _searchController.text)
                  .where('name', isLessThan: _searchController.text + 'z')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2.4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> data =
                    documents[index].data() as Map<String, dynamic>;
                    return MaterialCard(
                      index: index,
                      name: data['name'],
                      videoUrl: data['videoUrl'],
                      onTap: () {
                        // Navigate to the product description page
                        Get.to(const LmaterialPlayPage(), arguments: {'data':documents[index]});
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
