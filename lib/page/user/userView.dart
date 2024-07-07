import 'package:art_galary/model/user.dart';
import 'package:art_galary/page/user/Components/postWidget.dart';
import 'package:art_galary/page/user/userViewController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../services/MyColors.dart';

class UserView extends GetView<UserViewController> {
  const UserView(this.user, {super.key});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    MyColors myColors = Get.find<MyColors>();

    controller.getPosts(user);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: ClipOval(
                    child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Image.network(
                          controller.getProfileUrl(user),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 20,
                ),
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name + " " + user.familyName),
                      Text(
                        user.username,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Container(
              height: (MediaQuery.of(context).size.height)-(50)-(64)-32,
              child: Obx(
                    ()=> ListView.builder(
                    itemCount: controller.posts.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return PostWidget(controller.posts[index]);
                    }),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
