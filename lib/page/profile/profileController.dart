import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../model/user.dart';
import '../../services/MyColors.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class ProfileController extends GetxController {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController familyNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController usernameTextEditingController = TextEditingController();

  var user = AppUser(id: "0").obs;
  var isLoading = false.obs;
  var imgUrl = "null".obs;

  XFile? image;
  var isImageLoaded = false.obs;

  MyColors myColors = Get.find<MyColors>();

  @override
  Future<void> onInit() async {
    super.onInit();
    emailTextEditingController.text = FirebaseAuth.instance.currentUser!.email!;
    getUser();
  }

  Future<void> updateUser() async {
    isLoading.value = true;
    print(user.value.toJson().toString());
    await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      FirebaseFirestore.instance.doc("users/" + querySnapshot.docs.first.id).update({
        "name": nameTextEditingController.value.text,
        "familyName": familyNameTextEditingController.value.text,
        "username": usernameTextEditingController.value.text
      }).then((onValue) => Get.defaultDialog(
          backgroundColor: myColors.secondBackground,
          radius: 16,
          title: "User Information",
        content: Text("Your user information is now updated",style: TextStyle(color: myColors.textColor),)
      ));
    }).catchError((error) => print("Failed to update user: $error"));
    isLoading.value = false;
  }

  Future<void> getUser() async {
    FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        user.value = AppUser.fromJson(doc.data() as Map<String, dynamic>);
        print("XXX: data:" + doc.data().toString());
        print("XXX: model:" + user.value.toJson().toString());
        if (user.value.image != "null") imgUrl.value = user.value.image;
        if (user.value.name != "null") nameTextEditingController.text = user.value.name;
        if (user.value.familyName != "null") familyNameTextEditingController.text = user.value.familyName;
        if (user.value.username != "null") usernameTextEditingController.text = user.value.username;
      });
    });
  }

  Future<String> uploadFile() async {
    final _photo = File(image!.path);
    if (_photo == null) return("error");
    final fileName = basename(_photo!.path);
    final destination = 'files/users';
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(fileName);
      await ref.putFile(_photo!);
      String url = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        FirebaseFirestore.instance.doc("users/" + querySnapshot.docs.first.id).update({
          "image": url,
        }).then((onValue) => Get.defaultDialog(
            backgroundColor: myColors.secondBackground,
            radius: 16,
            title: "User Information",
            content: Text("Your profile photo is now updated",style: TextStyle(color: myColors.textColor),)
        ));
      }).catchError((error) => print("Failed to update user: $error"));
      return url;

    } catch (e) {
      print('error occured');
    }
    return('error');
  }

}
