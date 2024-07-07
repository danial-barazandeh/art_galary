import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../services/MyColors.dart';
import 'mainController.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {

    MyColors myColors = Get.find<MyColors>();

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("Main"),
      ),
        );
  }
}

