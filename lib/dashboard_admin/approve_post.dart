import 'package:craftroots/widget/approve_post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/home_controller.dart';
import '../widget/product_card.dart';
import '../widget/product_description_page.dart';

class ApprovePostPage extends StatefulWidget {
  const ApprovePostPage({super.key});

  @override
  State<ApprovePostPage> createState() => _ApprovePostPageState();
}

class _ApprovePostPageState extends State<ApprovePostPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async{
          ctrl.fetchPostsList();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Admin_Approve_Post'),
          ),
          body: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemCount: ctrl.postShowUi.length,
                      itemBuilder: (context, index) {
                        return ApprovePostCard(
                          index: index,
                          name: ctrl.postShowUi[index].achive_name ?? 'No name',
                          imageUrl: ctrl.postShowUi[index].image ?? 'url'
                          );
                      }),
                )
              ],
            ),
        ),
      );
    });
  }
}
