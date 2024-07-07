import 'package:art_galary/page/post/postController.dart';
import 'package:get/get.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(
          () => PostController(),
    );
  }
}