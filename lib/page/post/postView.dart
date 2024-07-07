import 'package:art_galary/model/post.dart';
import 'package:art_galary/page/post/postController.dart';
import 'package:art_galary/page/user/userView.dart';
import 'package:art_galary/page/user/userViewController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../services/MyColors.dart';

class PostView extends GetView<PostController> {
  const PostView(this.post, {super.key});
  final Post post;
  @override
  Widget build(BuildContext context) {
    MyColors myColors = Get.find<MyColors>();

    controller.getUser(post.userId);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left:32, right: 32, top: 16, bottom: 32),
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=>UserView(controller.user.value));
                },
                child: Row(
                  children: [
                    Obx(
                      ()=> ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(99999)),
                        child: Container(
                          width: 75,
                          height: 75,
                          child: Image.network(controller.user.value.image??"https://www.shutterstock.com/image-vector/blank-avatar-photo-place-holder-600nw-1095249842.jpg", fit: BoxFit.fill,),
                        ),
                      ),
                    ),
                    SizedBox(width: 16,height: 10,),
                    Obx(
                      ()=> Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.user.value.name + " " +controller.user.value.familyName),
                          Text(controller.user.value.username, style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.4,
                child: Image.network(post.image, fit: BoxFit.fill,),
              ),
            ),
            SizedBox(height: 16,width: 8,),
            Text(post.title, style: TextStyle(fontSize: 22),),
            SizedBox(height: 8,width: 8,),
            Text(post.description, style: TextStyle(color: Colors.white70)),
            SizedBox(height: 16,width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Prompt:", style: TextStyle(color: myColors.primary)),
                Text(post.prompt, style: TextStyle(color: Colors.white70)),
              ],
            ),
            SizedBox(height: 8,width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Engine:", style: TextStyle(color: myColors.primary)),
                Text(post.engine, style: TextStyle(color: Colors.white70)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}