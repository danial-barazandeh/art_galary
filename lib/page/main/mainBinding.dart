import 'package:get/get.dart';

import 'mainController.dart';


class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
          () => MainController(),
    );
  }
}