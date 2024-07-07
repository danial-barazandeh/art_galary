import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_chips_input/simple_chips_input.dart';
import '../../services/MyColors.dart';
import 'postingController.dart';

class PostingView extends GetView<MainController> {
  const PostingView({super.key});

  @override
  Widget build(BuildContext context) {
    MyColors myColors = Get.find<MyColors>();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: ListView(
          children: [
            Obx(
              () => Container(
                child: controller.isImageLoaded.value
                    ? GestureDetector(
                        onTap: () async {
                          controller.isImageLoaded(false);
                          final ImagePicker picker = ImagePicker();
                          controller.image = await picker.pickImage(source: ImageSource.gallery);
                          controller.isImageLoaded(true);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.file(File(controller.image!.path),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.5,
                              fit: BoxFit.fill),
                        ))
                    : GestureDetector(
                        onTap: () async {
                          controller.isImageLoaded(false);
                          final ImagePicker picker = ImagePicker();
                          controller.image = await picker.pickImage(source: ImageSource.gallery);
                          controller.isImageLoaded(true);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: myColors.primary,
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: myColors.primary),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Text("Title:"),
            TextField(
              controller: controller.titleTextEditingController,
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Text("Description:"),
            TextField(
              controller: controller.descriptionTextEditingController,
              minLines: 1,
              maxLines: 5,
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Text("Prompt:"),
            TextField(
              controller: controller.promptTextEditingController,
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Obx(
              () => DropdownButton<String>(
                value: controller.dropdownValue.value,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  controller.dropdownValue.value = value!;
                },
                items: controller.engineList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(value)),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            Text("Tags:"),
            SizedBox(
              height: 16,
              width: 16,
            ),
            SimpleChipsInput(
              separatorCharacter: ",",
              controller: controller.tagTextEditingController,
              onSubmitted: (p0) {
                controller.setTags(p0);
              },
              chipTextStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              deleteIcon: const Icon(
                Icons.cancel_outlined,
                size: 14.0,
                color: Colors.grey,
              ),
              widgetContainerDecoration: BoxDecoration(
                // color: Colors.blue[100]!,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: myColors.primary),
              ),
              chipContainerDecoration: BoxDecoration(
                color: myColors.secondBackground,
                borderRadius: BorderRadius.circular(50),
              ),
              placeChipsSectionAbove: false,
            ),
            SizedBox(
              height: 32,
              width: 16,
            ),
            TextButton(
                onPressed: () {
                  controller.uploadPost();
                },
                child: Text("Upload"))
          ],
        ),
      ),
    );
  }
}
