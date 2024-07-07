import 'package:art_galary/page/post/postController.dart';
import 'package:art_galary/page/profile/profileController.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}