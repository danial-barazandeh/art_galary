import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../components/drawer/CustomDrawer.dart';
import '../post/postView.dart';
import 'homeController.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: CustomDrawer(),
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: Obx(() => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                ),
                padding: const EdgeInsets.all(8.0), // padding around the grid
                itemCount: controller.posts.length, // total number of items
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.to(()=>PostView(controller.posts[index]));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image.network(controller.posts[index].image)
                    ),
                  );
                })
            )
        )
    );
  }
}
