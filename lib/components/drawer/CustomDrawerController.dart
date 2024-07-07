import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../firebase_options.dart';
import '../../model/user.dart';

class CustomDrawerController extends GetxController {
  var user = AppUser(id: "0").obs;
  var url = "https://www.shutterstock.com/image-vector/blank-avatar-photo-place-holder-600nw-1095249842.jpg".obs;

  @override
  Future<void> onInit() async {
    getUser();
    super.onInit();
  }

  getProfileUrl(){
    if(url.value.toString()=="null")
      return "https://www.shutterstock.com/image-vector/blank-avatar-photo-place-holder-600nw-1095249842.jpg";
    else
      return url.value;
  }

  Future<void> getUser() async {
    print("---");
    await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        user.value = AppUser.fromJson(doc.data() as Map<String, dynamic>);
        if(user.value.image != null)
          url.value = user.value.image;
        print("***:"+user.value.toJson().toString());
      });
    });
  }
}
