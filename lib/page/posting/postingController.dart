import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:art_galary/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../services/MyColors.dart';

class MainController extends GetxController {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController promptTextEditingController = TextEditingController();
  TextEditingController tagTextEditingController = TextEditingController();
  List<String> engineList = <String>['DALL·E 3', 'Midjourney', 'Stable Diffusion', 'Firefly', 'Getty'];

  var dropdownValue = "DALL·E 3".obs;

  var tags = [].obs;

  XFile? image;

  var isImageLoaded = false.obs;

  MyColors myColors = Get.find<MyColors>();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void setTags(String data) {
    var temp = data.split(',');
    temp.removeWhere((item) => item.length < 1);
    tags.value = temp;
  }

  Future<String> uploadFile() async {
    final _photo = File(image!.path);
    if (_photo == null) return ("error");
    final fileName = basename(_photo!.path);
    final destination = 'files/posts';
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination).child(fileName);
      await ref.putFile(_photo!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('error occured');
    }
    return ('error');
  }

  Future<void> uploadPost() async {
    super.onInit();

    String image = await uploadFile();

    if (image != "error") {
      var db = FirebaseFirestore.instance;
      DateTime now = DateTime.now();

      await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          AppUser appUser = AppUser.fromJson(doc.data() as Map<String, dynamic>);
          appUser.id = doc.id;

          await db
              .collection("posts")
              .add({
                'title': titleTextEditingController.text,
                'description': descriptionTextEditingController.text,
                'userId': appUser.id,
                "engine": dropdownValue.value,
                "prompt": promptTextEditingController.text,
                "creationTime": now,
                "tags": tags,
                "image": image
              })
              .then((value) async => {
                    Get.defaultDialog(
                        backgroundColor: myColors.secondBackground,
                        radius: 16,
                        title: "Your post is hear",
                        content: Text(
                          "Your post is uploaded",
                          style: TextStyle(color: myColors.textColor),
                        ))
                  })
              .catchError((error) => print("Failed to add ping: $error"));
        });
      });
    }
  }
}
