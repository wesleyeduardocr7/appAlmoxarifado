
import 'package:almoxarifado/src/models/PedidoAlmoxarifado.dart';
import 'package:flutter/material.dart';

class PedidoPage extends StatefulWidget {

  final PedidoAlmoxarifado pedidoAlmoxarifado;
  PedidoPage({this.pedidoAlmoxarifado});

  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {

  final _tipoPedidoController = TextEditingController();
  final _nomeSolicitanteController = TextEditingController();
  final _nomePecaController = TextEditingController();
  final _nomeFocus = FocusNode();

  bool editado= false;
  PedidoAlmoxarifado _editaPedidoAlmoxarifado;

  @override
  void initState(){
    super.initState();

    if(widget.pedidoAlmoxarifado == null){
      _editaPedidoAlmoxarifado = PedidoAlmoxarifado(0,'','','');
    }else{
      _editaPedidoAlmoxarifado = PedidoAlmoxarifado.fromMap(widget.pedidoAlmoxarifado.toMap());

      _tipoPedidoController.text = _editaPedidoAlmoxarifado.tipoPedido;
      _nomeSolicitanteController.text = _editaPedidoAlmoxarifado.nomeSolicitante;
      _nomePecaController.text = _editaPedidoAlmoxarifado.nomePeca;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(_editaPedidoAlmoxarifado.tipoPedido == '' ? "Novo Pedido" :
        _editaPedidoAlmoxarifado.tipoPedido ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          if(_editaPedidoAlmoxarifado.tipoPedido != null && _editaPedidoAlmoxarifado.tipoPedido.isNotEmpty)
          {
            Navigator.pop(context, _editaPedidoAlmoxarifado);
          }else{
            _exibeAviso();
            FocusScope.of(context).requestFocus(_nomeFocus);
          }

        },
        child: Icon(Icons.save),
        backgroundColor: Colors.indigo,
      ),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
            child: Column(
            children: <Widget>[

              TextField(
                controller: _tipoPedidoController,
                focusNode: _nomeFocus,
                decoration: InputDecoration(labelText: "Tipo Pedido"),
                onChanged: (text){
                  editado = true;
                  setState(() {
                    _editaPedidoAlmoxarifado.tipoPedido = text;
                  });
                },
              ),

              TextField(
                controller: _nomeSolicitanteController,
                decoration: InputDecoration(labelText: "Nome Solicitante"),
                onChanged: (text){
                  editado = true;
                  setState(() {
                    _editaPedidoAlmoxarifado.nomeSolicitante = text;
                  });
                },
              ),

              TextField(
                controller: _nomePecaController,
                decoration: InputDecoration(labelText: "Nome Peça"),
                onChanged: (text){
                  editado = true;
                  setState(() {
                    _editaPedidoAlmoxarifado.nomePeca = text;
                  });
                },
              ),


            ]
        )
        )
    );

  }

  void _exibeAviso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Tipo de Pedido"),
          content: new Text("Informe o Tipo do Pedido"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
