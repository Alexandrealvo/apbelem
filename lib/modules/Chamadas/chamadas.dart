import 'package:apbelem/modules/Chamadas/api_chamadas.dart';
import 'package:apbelem/modules/Chamadas/chamadas_controller.dart';
import 'package:apbelem/modules/Chamadas/visualizar_chamadas_controller.dart';
import 'package:apbelem/utils/alert_button_pressed.dart';
import 'package:apbelem/utils/box_search.dart';
import 'package:apbelem/utils/circular_progress_indicator.dart';
import 'package:apbelem/utils/edge_alert.dart';
import 'package:apbelem/utils/edge_alert_danger.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class Chamadas extends StatefulWidget {
  @override
  _ChamadasState createState() => _ChamadasState();
}

class _ChamadasState extends State<Chamadas> {
  VisualizarChamadasController visualizarChamadasController =
      Get.put(VisualizarChamadasController());

  ChamadasController chamadasController = Get.put(ChamadasController());

  @override
  void initState() {
    super.initState();
    chamadasController.getChamadas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chamadas',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return chamadasController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : Column(
                    children: [
                      boxSearch(
                          context,
                          visualizarChamadasController.search.value,
                          visualizarChamadasController.onSearchTextChanged,
                          "Pesquise as Chamadas..."),
                      Expanded(
                        child: _listachamadas(),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String cel) async {
    var celular = cel
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "")
        .replaceAll(" ", "");

    var celFinal = "tel:$celular";

    if (await canLaunch(celFinal)) {
      await launch(celFinal);
    } else {
      EdgeAlert.show(context,
          title: 'Erro! Não foi possível ligar para este celular.',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.red,
          icon: Icons.highlight_off);
    }
  }

  void _configurandoModalBottomSheet(
      context,
      String nomecliente,
      String endereco,
      String tel,
      String cel,
      String whatsapp,
      String whatresp,
      String responsavel,
      String status,
      String idchamada) {
    print(idchamada);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(
                      Icons.business,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      size: 30,
                    ),
                    title: Text(
                      nomecliente,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: Text(
                      "$endereco \nResponsável: $responsavel",
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        size: 20,
                      ),
                    )),
                Divider(
                  height: 20,
                  color: Colors.blueGrey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => tel == ""
                                    ? edgeAlertWidgetDanger(
                                        context, 'Telefone Vazio!')
                                    : setState(() {
                                        _makePhoneCall(tel);
                                      }),
                                child: Card(
                                  color: Theme.of(context).buttonColor,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.phone,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Telefone',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => cel == ""
                                    ? edgeAlertWidgetDanger(
                                        context, 'Celular Vazio!')
                                    : setState(() {
                                        _makePhoneCall(cel);
                                      }),
                                child: Card(
                                  color: Theme.of(context).buttonColor,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.phone_iphone,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Celular',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => whatsapp == ""
                                    ? edgeAlertWidgetDanger(
                                        context, 'Número do Whatsapp Vazio!')
                                    : FlutterOpenWhatsapp.sendSingleMessage(
                                        whatsapp.length == 11
                                            ? '55$whatsapp'
                                            : whatsapp,
                                        '',
                                      ),
                                child: Card(
                                  color: Theme.of(context).buttonColor,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              FontAwesome.whatsapp,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Whatsapp',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => cel == ""
                                    ? edgeAlertWidgetDanger(
                                        context, 'Endereço Vazio!')
                                    : print('mostrar mapa'),
                                child: Card(
                                  color: Theme.of(context).buttonColor,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.map,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Localização',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                status == "Pendente"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ApiChamadas.getAceitar(idchamada, "Recusado")
                                      .then((value) {
                                    if (value == 1) {
                                      edgeAlertWidget(
                                        context,
                                        'Cliente Recusado com Sucesso!',
                                      );
                                      // Preciso atualizar a pagina aqui como fazer///
                                      visualizarChamadasController.onRefresh();
                                    } else {
                                      onAlertButtonPressed(
                                          context,
                                          'Algo deu errado\n Tente novamente',
                                          null);
                                    }
                                  });
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10)),
                                child: Text(
                                  "Recusar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                color: Colors.red,
                              ),
                            ),
                            Divider(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ApiChamadas.getAceitar(idchamada, "Aceito")
                                      .then((value) {
                                    if (value == 1) {
                                      edgeAlertWidget(
                                        context,
                                        'Cliente Aceito com Sucesso!',
                                      );
                                    } else {
                                      onAlertButtonPressed(
                                          context,
                                          'Algo deu errado\n Tente novamente',
                                          null);
                                    }
                                  });
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10)),
                                child: Text(
                                  "Aceitar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        });
  }

  _listachamadas() {
    if (chamadasController.chamadas.length == 0) {
      return Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'images/semregistro.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 80),
                  //child: Icon(Icons.block, size: 34, color: Colors.red[900]),
                ),
                Text(
                  'Sem Registros de Chamadas',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return SmartRefresher(
          controller: visualizarChamadasController.refreshController,
          onRefresh: visualizarChamadasController.onRefresh,
          onLoading: visualizarChamadasController.onLoading,
          child: visualizarChamadasController.searchResult.isNotEmpty ||
                  visualizarChamadasController.search.value.text.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(8),
                  child: ListView(
                    children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: visualizarChamadasController
                                  .searchResult.length,
                              itemBuilder: (context, index) {
                                var search = visualizarChamadasController
                                    .searchResult[index];

                                return GestureDetector(
                                  onTap: () {
                                    _configurandoModalBottomSheet(
                                      context,
                                      chamadasController.nomecliente.value,
                                      chamadasController.endereco.value,
                                      chamadasController.tel.value,
                                      chamadasController.cel.value,
                                      chamadasController.whatsapp.value,
                                      chamadasController.whatresp.value,
                                      chamadasController.responsavel.value,
                                      chamadasController.status.value,
                                      chamadasController.idchamada.value,
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: search.status == 'Pendente'
                                        ? Theme.of(context).buttonColor
                                        : search.status == 'Aceito'
                                            ? Colors.green
                                            : Colors.red,
                                    child: ListTile(
                                        leading: RichText(
                                          text: TextSpan(
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: search.status == 'Pendente'
                                                  ? Colors.black
                                                  : Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      search.datacreate + "  ",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        title: Container(
                                          child: Center(
                                            child: Text(
                                              search.nomecliente,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: search.status ==
                                                          'Pendente'
                                                      ? Colors.black
                                                      : Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_right,
                                          color: search.status == 'Pendente'
                                              ? Colors.black
                                              : Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                          size: 30,
                                        )),
                                  ),
                                );
                              }))
                    ],
                  ))
              : _containerList());
    }
  }

  _containerList() {
    return Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: chamadasController.chamadas.length,
                    itemBuilder: (context, index) {
                      var chamadas = chamadasController.chamadas[index];
                      return GestureDetector(
                        onTap: () {
                          _configurandoModalBottomSheet(
                            context,
                            chamadas.nomecliente,
                            chamadas.endereco,
                            chamadas.tel,
                            chamadas.cel,
                            chamadas.whatsapp,
                            chamadas.whatresp,
                            chamadas.responsavel,
                            chamadas.status,
                            chamadas.idchamada,
                          );
                          print(chamadas.responsavel);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: chamadas.status == 'Pendente'
                              ? Theme.of(context).buttonColor
                              : chamadas.status == 'Aceito'
                                  ? Colors.green
                                  : Colors.red,
                          child: ListTile(
                              leading: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: chamadas.status == 'Pendente'
                                        ? Colors.black
                                        : Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: chamadas.datacreate + "  ",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              title: Container(
                                child: Center(
                                  child: Text(
                                    chamadas.nomecliente,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: chamadas.status == 'Pendente'
                                            ? Colors.black
                                            : Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                color: chamadas.status == 'Pendente'
                                    ? Colors.black
                                    : Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                size: 30,
                              )),
                        ),
                      );
                    }))
          ],
        ));
  }
}
