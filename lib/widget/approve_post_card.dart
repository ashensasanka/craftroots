import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/home_controller.dart';

class ApprovePostCard extends StatelessWidget {
  final int index;
  final String name;
  final String imageUrl;

  const ApprovePostCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> nameParts = name.split(',');
    String firstPart = nameParts[0].trim();
    String secondPart = nameParts.length > 1 ? nameParts[1].trim() : '';
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 120,
              ),
              const SizedBox(height: 9),
              Text(
                firstPart,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (secondPart.isNotEmpty)
                Text(
                  secondPart,
                ),
              SizedBox(height: 10,),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      ctrl.addCart(index);
                      ctrl.deleteProduct(ctrl.postdetails[index].id ?? '');
                    },
                    child: Text('Approve')
                  ),
                  SizedBox(width: 65,),
                  InkWell(
                      onTap: () {
                        ctrl.deleteProduct(ctrl.postdetails[index].id ?? '');
                      },
                      child: const Flexible(
                        child: Icon(
                          Icons.delete,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                  ),
                ],
              )

            ],
          ),
        ),
      );
    });
  }
}
