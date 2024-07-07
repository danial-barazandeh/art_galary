import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/user.dart';

class PostController extends GetxController {
  var shouldLoadUser = true.obs;
  var user = AppUser(id: "0", email: "", name: "", username: "", familyName: "").obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> getUser(String userId) async {
    print("zzz");
    // if (shouldLoadUser.value) {
      print(("Loading"));
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
          print("***");
          print(userId);
          print(documentSnapshot.data().toString());
          user.value = AppUser.fromJson(documentSnapshot.data() as Map<String, dynamic>);
          user.value.id = documentSnapshot.id;
          print("***");
      });
      // shouldLoadUser(false);
    // }
  }
}
