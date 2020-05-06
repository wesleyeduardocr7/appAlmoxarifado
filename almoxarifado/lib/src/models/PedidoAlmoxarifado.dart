
class PedidoAlmoxarifado{

  int id;
  String tipoPedido;
  String nomeSolicitante;
  String nomePeca;

  PedidoAlmoxarifado(this.id,this.tipoPedido,this.nomeSolicitante,this.nomePeca);

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      'id' : id,
      'tipoPedido' : tipoPedido,
      'nomeSolicitante' : nomeSolicitante,
      'nomePeca' : nomePeca,
    };

    return map;
  }

  PedidoAlmoxarifado.fromMap(Map<String,dynamic> map){

    id = map['id'];
    tipoPedido = map['tipoPedido'];
    nomeSolicitante = map['nomeSolicitante'];
    nomePeca = map['nomePeca'];
  }

  @override
  String toString() {
    return "Contato => (id: $id, tipoPedido: $tipoPedido, nomeSolicitante: $nomeSolicitante, nomePeca: $nomePeca";
  }

}