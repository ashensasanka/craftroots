import 'package:craftroots/dashboard_learner/cart_page.dart';
import 'package:craftroots/dashboard_learner/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../widget/drop_down_btn.dart';
import '../widget/multi_select_drop_down.dart';
import '../widget/product_card.dart';
import '../widget/product_description_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late TextEditingController _searchController;


  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async{
          ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Shop',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.person,size: 30,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/shop_back.jpg"), // Replace "assets/background_image.jpg" with your actual image asset path
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                //Search Box
                Container(
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {}); // Refresh the UI when the text changes
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.productCategories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            ctrl.filterByCategory(ctrl.productCategories[index].name ?? '');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Chip(label: Text(ctrl.productCategories[index].name ?? 'Error'),),
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    Flexible(
                      child: DropDownBtn(
                          items: const ['Rs:Low to High', 'Rs:High to Low'],
                          selectedItemText: 'Sort by Price',
                          onSelected: (selected) {
                            ctrl.sortByPrice( ascending: selected == 'Rs:Low to High' ? true:false,);
                          }
                      ),
                    ),
                    Flexible(
                        child: MultiSelectDropDown(
                          items: const ['Beginner', 'Intermediate', 'Advanced'],
                          onSelectionChanged: (selectedItems) {
                            ctrl.filterByBrand(selectedItems);
                          },
                        ))
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('shop')
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
                          crossAxisCount: 2,
                          childAspectRatio: 0.995,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _searchController.text.isNotEmpty ? documents.length : ctrl.productShowInUi.length,
                        itemBuilder: (context, index) {
                          if (_searchController.text.isNotEmpty) {
                            final Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                            return ProductCard(
                              index: index,
                              name: data['name'] ?? '',
                              imageUrl: data['imageUrl'] ?? '',
                              onTap: () {
                                Get.to(const ProductDescriptionPage(), arguments: {'data': documents[index]});
                              },
                            );
                          } else {
                            return ProductCard(
                              index: index,
                              name: ctrl.productShowInUi[index].name ?? '',
                              imageUrl: ctrl.productShowInUi[index].imageUrl ?? '',
                              onTap: () {
                                Get.to(const ProductDescriptionPage(), arguments: {'data': documents[index]});
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    });

  }
}
