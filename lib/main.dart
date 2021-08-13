import 'package:apbelem/modules/Home/home_page.dart';
import 'package:apbelem/modules/Perfil/perfil.dart';
import 'package:apbelem/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/Login/login_page.dart';


void main() {

  
  runApp(GetMaterialApp(
    initialRoute: '/login',
    theme: admin,
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
      ),
      GetPage(name: '/home', page: () => HomePage(),),
       GetPage(
        name: '/perfil',
        page: () => Perfil(),
      ),
    ],
  ));
}
