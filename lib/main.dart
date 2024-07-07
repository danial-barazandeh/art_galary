import 'package:art_galary/page/post/postController.dart';
import 'package:art_galary/page/user/userViewController.dart';
import 'package:art_galary/services/MyColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';

import 'app_pages.dart';
import 'components/drawer/CustomDrawerController.dart';
import 'firebase_options.dart';

Future<void> main() async {
  Get.put(MyColors());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(CustomDrawerController());
  Get.put(PostController());
  Get.put(UserViewController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});





  @override
  Widget build(BuildContext context) {
    MyColors myColors = Get.find<MyColors>();

    return GetMaterialApp(
      title: 'Lets date',
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.ltr,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: myColors.firstBackground,
          textTheme: TextTheme(
            labelSmall: TextStyle(color: myColors.textColor),
            labelMedium: TextStyle(color: myColors.textColor),
            labelLarge: TextStyle(color: myColors.textColor),
            displayLarge: TextStyle(color: myColors.textColor),
            displayMedium: TextStyle(color: myColors.textColor),
            displaySmall: TextStyle(color: myColors.textColor),
            bodySmall: TextStyle(color: myColors.textColor),
            bodyMedium: TextStyle(color: myColors.textColor),
            bodyLarge: TextStyle(color: myColors.textColor),
            titleSmall: TextStyle(color: myColors.textColor),
            titleMedium: TextStyle(color: myColors.textColor),
            titleLarge: TextStyle(color: myColors.textColor),
            headlineLarge: TextStyle(color: myColors.textColor),
            headlineMedium: TextStyle(color: myColors.textColor),
            headlineSmall: TextStyle(color: myColors.textColor),

          ),
          inputDecorationTheme: InputDecorationTheme(
            iconColor: myColors.textColor,
            helperStyle: TextStyle(color: myColors.textColor),
            suffixStyle: TextStyle(color: myColors.textColor),
            prefixStyle: TextStyle(color: myColors.textColor),
            fillColor: Colors.red
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: myColors.firstBackground,
            titleTextStyle: TextStyle(color: myColors.textColor),
            iconTheme: IconThemeData(color: myColors.textColor),
            toolbarTextStyle: TextStyle(color: myColors.textColor),
          )),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
