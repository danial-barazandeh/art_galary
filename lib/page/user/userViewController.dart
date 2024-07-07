import 'package:art_galary/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/post.dart';

class UserViewController extends GetxController {

  var posts = <Post>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }


  getProfileUrl(AppUser user) {
    if (user.image.toString() == "null")
      return "https://www.shutterstock.com/image-vector/blank-avatar-photo-place-holder-600nw-1095249842.jpg";
    else
      return user.image;
  }

  Future<void> getPosts( AppUser user) async{
    posts.clear();

    print("***: "+user.toJson().toString());

    FirebaseFirestore.instance
        .collection('posts')
        .where("userId", isEqualTo: user.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("***");
        Post post = Post.fromJson(doc.data() as Map<String, dynamic>);
        posts.add(post);
        print("***");
      });
    });
  }
}
