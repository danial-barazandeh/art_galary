import 'dart:ffi';

import 'package:art_galary/page/home/homeBinding.dart';
import 'package:art_galary/page/home/homeView.dart';
import 'package:art_galary/page/login/homeBinding.dart';
import 'package:art_galary/page/login/loginView.dart';
import 'package:art_galary/page/main/mainBinding.dart';
import 'package:art_galary/page/main/mainView.dart';
import 'package:art_galary/page/post/postBinding.dart';
import 'package:art_galary/page/post/postView.dart';
import 'package:art_galary/page/posting/postingBinding.dart';
import 'package:art_galary/page/posting/postingView.dart';
import 'package:art_galary/page/profile/profile.dart';
import 'package:art_galary/page/profile/profileBinding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {

  AppPages._();


  static String INITIAL = (FirebaseAuth.instance.currentUser != null &&
      FirebaseAuth.instance.currentUser!.emailVerified)
      ? Routes.HOME
      : Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.POSTING,
      page: () => const PostingView(),
      binding: PostingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),

  ];
}