class Dadoschamadas {
  String idchamada;
  String nomecliente;
  String datacreate;
  String endereco;
  String tel;
  String cel;
  String whatsapp;
  String responsavel;
  String whatresp;
  String status;

  Dadoschamadas(
      String idchamada,
      String nomecliente,
      String datacreate,
      String endereco,
      String tel,
      String cel,
      String whatsapp,
      String responsavel,
      String whatresp,
      String status) {
    this.idchamada = idchamada;
    this.nomecliente = nomecliente;
    this.datacreate = datacreate;
    this.endereco = endereco;
    this.tel = tel;
    this.cel = cel;
    this.whatsapp = whatsapp;
    this.responsavel = responsavel;
    this.whatresp = whatresp;
    this.status = status;
  }

  Dadoschamadas.fromJson(Map json) {
    idchamada = json['idchamada'];
    nomecliente = json['nomecliente'];
    datacreate = json['datacreate'];
    endereco = json['endereco'];
    tel = json['tel'];
    cel = json['cel'];
    whatsapp = json['whatsapp'];
    responsavel = json['responsavel'];
    whatresp = json['whatresp'];
    status = json['status'];
  }
}
