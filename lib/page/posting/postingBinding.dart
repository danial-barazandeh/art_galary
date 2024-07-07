import 'package:get/get.dart';

import 'postingController.dart';


class PostingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
          () => MainController(),
    );
  }
}