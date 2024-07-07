import 'dart:io';

import 'package:art_galary/page/profile/profileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../services/MyColors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    MyColors myColors = Get.find<MyColors>();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: ListView(
          children: [
            Obx(
              ()=> Container(
                child: controller.isImageLoaded.value
                    ? GestureDetector(
                        onTap: () async {
                          controller.isImageLoaded(false);
                          final ImagePicker picker = ImagePicker();
                          controller.image = await picker.pickImage(source: ImageSource.gallery);
                          controller.isImageLoaded(true);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.file(File(controller.image!.path),
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 75,
                                color: Colors.green.shade200,
                                child: GestureDetector(
                                  onTap: (){
                                    controller.uploadFile();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.upload,color: Colors.green),
                                      SizedBox(
                                        height: 16,
                                        width: 16,
                                      ),
                                      Text("Save and Upload",style: TextStyle(color: Colors.green)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    : Obx(
                      ()=> GestureDetector(
                          onTap: () async {
                            controller.isImageLoaded(false);
                            final ImagePicker picker = ImagePicker();
                            controller.image = await picker.pickImage(source: ImageSource.gallery);
                            controller.isImageLoaded(true);
                          },
                          child: controller.imgUrl.value=="null"?Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: myColors.primary,
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: myColors.primary),
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                          ):ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(controller.imgUrl.value,
                                width: MediaQuery.of(context).size.width * 0.9,
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover),
                          )
                        ),
                    ),
              ),
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Text("Name:"),
            TextField(
              controller: controller.nameTextEditingController,
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Text("Family name:"),
            TextField(
              controller: controller.familyNameTextEditingController,
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Text("Username:"),
            TextField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[!@#$%^&*(), .?":{}|<>]'))],
              controller: controller.usernameTextEditingController,
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Text("Email:"),
            TextField(
              enabled: false,
              controller: controller.emailTextEditingController,
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Obx(() {
              return controller.isLoading.value
                  ? LoadingAnimationWidget.dotsTriangle(
                      size: 50,
                      color: myColors.secondary,
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(myColors.primary),
                      ),
                      onPressed: () {
                        controller.updateUser();
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(color: myColors.textColor),
                      ));
            })
          ],
        ),
      ),
    );
  }
}
