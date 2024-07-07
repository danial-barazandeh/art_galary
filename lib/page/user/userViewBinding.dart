import 'package:art_galary/page/user/userViewController.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class UserViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserViewController>(
          () => UserViewController(),
    );
  }
}