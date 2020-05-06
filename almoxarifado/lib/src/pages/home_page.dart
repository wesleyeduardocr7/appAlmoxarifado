import 'dart:io';

import 'package:almoxarifado/src/helpers/DatabaseHelper.dart';
import 'package:almoxarifado/src/models/PedidoAlmoxarifado.dart';
import 'package:almoxarifado/src/pages/pedido_almoxarifado_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  DatabaseHelper db = DatabaseHelper();

  List<PedidoAlmoxarifado> pedidosAlmoxarifado = List<PedidoAlmoxarifado>();

  @override
  void initState() {
    super.initState();

    _exibeTodosPedidos();
  }

  void _exibeTodosPedidos() {
    db.getPedidosAlmoxarifado().then((lista) {
      setState(() {
        pedidosAlmoxarifado = lista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Pedido Almoxarifado"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: <Widget>[],
      ),

      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibePedidoPage();
        },
        child: Icon(Icons.add),
      ),

      body: ListView.builder(

          padding: EdgeInsets.all(10.0),
          itemCount: pedidosAlmoxarifado.length,
          itemBuilder: (context, index) {
            return _listaPedidosAlmoxarifado(context, index);
          }

      ),

    );
  }

  _listaPedidosAlmoxarifado(BuildContext context, int index) {
    return GestureDetector(

      child: Card(
        child: Padding(padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text("Solicitante: " +
                        pedidosAlmoxarifado[index].nomeSolicitante ?? "",
                        style: TextStyle(fontSize: 20)
                    ),

                    Text("Tipo de Pedido: " +
                        pedidosAlmoxarifado[index].tipoPedido ?? "",
                        style: TextStyle(fontSize: 20)
                    ),

                    Text("Peça: " + pedidosAlmoxarifado[index].nomePeca ?? "",
                        style: TextStyle(fontSize: 20)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _exibePedidoPage(pedidoAlmoxarifado: pedidosAlmoxarifado[index]);
      },
    );
  }

  void _exibePedidoPage({PedidoAlmoxarifado pedidoAlmoxarifado}) async {
    final pedidoRecebido = await Navigator.push(context,

      MaterialPageRoute(
          builder: (context) =>
              PedidoPage(pedidoAlmoxarifado: pedidoAlmoxarifado)
      ),
    );

    if (pedidoRecebido != null) {
      if (pedidoAlmoxarifado != null) {
        await db.updatePedidoAlmoxarifado(pedidoRecebido);
      } else {
        await db.insertAlmoxarifado(pedidoRecebido);
      }
      _exibeTodosPedidos();
    }
  }

}
