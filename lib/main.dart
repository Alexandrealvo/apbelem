import 'package:apbelem/modules/Home/home_page.dart';
import 'package:apbelem/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/Login/login_page.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    theme: admin,
    getPages: [
      GetPage(name: '/', page: () => LoginPage(),),
      GetPage(name: '/home', page: () => HomePage(),),
    ],
  ));
}
