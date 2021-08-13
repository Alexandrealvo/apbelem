import 'package:apbelem/modules/Home/home_page.dart';
import 'package:apbelem/modules/Perfil/perfil.dart';
import 'package:apbelem/modules/Senha/senha.dart';
import 'package:apbelem/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'modules/Login/login_page.dart';



void main() {

  
  runApp(GetMaterialApp(
     localizationsDelegates: [
      RefreshLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [Locale('pt')],
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
        name: '/senha',
        page: () => Senha(),
      ),
      GetPage(
        name: '/perfil',
        page: () => Perfil(),
      ),
    ],
  ));
}
