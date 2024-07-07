import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../app_pages.dart';
import 'loginController.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Who are you? introduce yourself!'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                await signInWithGoogle();

                Get.toNamed(Routes.HOME);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Text("Sign in with google"),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> signInWithGoogle() async {
    print("signInWithGoogle()");
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      print("signInWithGoogle() + Check userList");

      var tempList = [];
      await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: googleUser!.email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          tempList.add(doc.data());
        });
      });

      print("Email to check:  "+googleUser!.email);
      print("signInWithGoogle() + Check userList");
      print("signInWithGoogle() + " + tempList.length.toString());
      print("signInWithGoogle() + " + tempList.toString());

      if (tempList.length == 0) {
        FirebaseFirestore.instance
            .collection('users')
            .add({"email": googleUser?.email}).catchError((error) => print("Failed to create user: $error"));
      }

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }
}
