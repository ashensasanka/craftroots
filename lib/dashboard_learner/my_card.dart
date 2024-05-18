import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../controller/home_controller.dart';


class MyCard extends StatefulWidget {
  final int index;
  final String type;
  final String name;
  final String imageUrl;
  final Function onTap;
  final String plant_date;
  final String harvest_date;

  const MyCard(
      {super.key,
        required this.name,
        required this.imageUrl,
        required this.onTap,
        required this.index,
        required this.type,
        required this.plant_date,
        required this.harvest_date});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  final userCollection = FirebaseFirestore.instance.collection("farmer");


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return InkWell(
        onTap: (){
          widget.onTap();
        },
        child: Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,10, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // or MainAxisAlignment.spaceBetween
                  children: [
                    SizedBox(width: 5,),
                    Image.network(
                        widget.imageUrl,
                        // fit: BoxFit.cover,
                        width: 140,
                        height: 110,
                      ),

                    const SizedBox(width: 10), // Add a SizedBox with the desired width between the Expanded widgets
                    Padding(
                        padding: const EdgeInsets.only(left: 0, bottom: 30,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${widget.type}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8,),
                            Text(
                              'Hi, I learned Bathik........',
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
