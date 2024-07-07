import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../app_pages.dart';
import '../../page/login/homeBinding.dart';
import '../../services/MyColors.dart';
import 'CustomDrawerController.dart';

class CustomDrawer extends GetView<CustomDrawerController> {
  @override
  MyColors myColors = MyColors();

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width*0.75,
      margin: const EdgeInsets.symmetric(vertical: 64),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: myColors.firstBackground,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(()=> Container(
            width: 150,
            height: 150,
            child: ClipOval(
              child: Padding(padding: EdgeInsets.all(0),
                  child: Image.network(controller.getProfileUrl(), fit: BoxFit.cover,)),
            ),
          ),
          ),
          SizedBox(
            width: 16,
            height: 16,
          ),
          GestureDetector(
            onTap: () async {
              Get.toNamed(Routes.PROFILE);
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.white30),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.person, color: Colors.white70, size: 32),
                    SizedBox(
                      width: 8,
                      height: 8,
                    ),
                    Text('Profile', style: TextStyle(color: Colors.white70, fontSize: 16))
                  ],
                )),
          ),
          SizedBox(
            width: 16,
            height: 16,
          ),
          GestureDetector(
            onTap: () async {
              Get.toNamed(Routes.POSTING);
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.white30),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.post_add, color: Colors.white70, size: 32),
                    SizedBox(
                      width: 8,
                      height: 8,
                    ),
                    Text('New Post', style: TextStyle(color: Colors.white70, fontSize: 16))
                  ],
                )),
          ),

          SizedBox(height: 16,),

          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Get.to(Routes.LOGIN, binding: LoginBinding());
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.white30),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.logout, color: Colors.white70, size: 32),
                    SizedBox(
                      width: 8,
                      height: 8,
                    ),
                    Text('Logout', style: TextStyle(color: Colors.white70, fontSize: 16))
                  ],
                )),
          ),
          SizedBox(
            width: 8,
            height: 8,
          ),

          ElevatedButton(onPressed: (){
            print(controller.user.value.toJson().toString());
            controller.getUser();
          }, child: Text("Print"))
        ],
      ),
    );
  }

}
