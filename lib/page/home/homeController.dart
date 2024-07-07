import 'dart:convert';

import 'package:art_galary/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
class HomeController extends GetxController {


  var posts = <Post>[].obs;

  @override
  Future<void> onInit() async {
    getPosts();
  }

  Future<void> getPosts() async{
    FirebaseFirestore.instance
        .collection('posts')
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
