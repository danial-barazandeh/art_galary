import 'package:art_galary/model/post.dart';
import 'package:art_galary/page/post/postView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(
    this.post, {
    super.key,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PostView(post));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Container(
                child: Image.network(
                  post.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    post.title,
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
