import 'package:craftroots/dashboard_admin/vendor_report_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widget/product_card.dart';
import '../widget/product_description_page.dart';
import '../widget/user_card.dart';

class VendorSelectionPage extends StatefulWidget {
  const VendorSelectionPage({super.key});

  @override
  State<VendorSelectionPage> createState() => _VendorSelectionPageState();
}

class _VendorSelectionPageState extends State<VendorSelectionPage> {
  List<String> names = ['Vendor 1', 'Vendor 2', 'Vendor 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Vendor'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
            return UserCard(
              index: index,
              name: names[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VendorReportPage(name: names[index],)), // Replace NextPage with the name of your next page widget
                );
              },
            );
        },
      )
    );
  }
}
