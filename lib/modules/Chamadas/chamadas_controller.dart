import 'dart:convert';
import 'package:apbelem/modules/Chamadas/api_chamadas.dart';
import 'package:apbelem/modules/Chamadas/mapa_chamadas.dart';
import 'package:get/get.dart';

class ChamadasController extends GetxController {
  List<Dadoschamadas> chamadas;
  var idchamada = ''.obs;
  var nomecliente = ''.obs;
  var datacliente = ''.obs;
  var endereco = ''.obs;
  var tel = ''.obs;
  var cel = ''.obs;
  var whatsapp = ''.obs;
  var responsavel = ''.obs;
  var whatresp = ''.obs;
  var status = ''.obs;
  var isLoading = true.obs;

  void getChamadas() {
    ApiChamadas.getChamadas().then((response) {
      Iterable lista = json.decode(response.body);
      chamadas = lista.map((model) => Dadoschamadas.fromJson(model)).toList();
      isLoading(false);
    });
  }
}