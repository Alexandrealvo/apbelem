import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var idusu = ''.obs;
  var nome = ''.obs;
  var imgperfil = ''.obs;
  var tipousu = ''.obs;
  var phone = ''.obs;
  var birthdate = ''.obs;
  var genero = ''.obs;
  var celular = ''.obs;

  var isLoading = false.obs;

  Future<void> launched;
  
  login() async {
    isLoading(true);

    final response = await http.post(
        Uri.https("admautopecasbelem.com.br", '/login/flutter/login.php'),
        body: {
          "email": email.value.text,
          "senha": password.value.text,
        });
    isLoading(false);

    var dadosUsuario = json.decode(response.body);

    print(dadosUsuario);

    if (dadosUsuario['valida'] == 1) {
      return dadosUsuario;
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
