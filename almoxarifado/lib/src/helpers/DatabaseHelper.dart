import 'dart:async';
import 'dart:io';

import 'package:almoxarifado/src/models/PedidoAlmoxarifado.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper{

  String almoxarifadoTable = 'almoxarifado';
  String colId = 'id';
  String colTipoPedido = 'tipoPedido';
  String colNomeSolicitante = 'nomeSolicitante';
  String colNomePeca = 'nomePeca';

  static DatabaseHelper _databaseHelper;

  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){

    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }



  Future<Database> get database async{


    if(_database == null){
      _database = await initializeDatabase();
    }

    return _database;

  }

  Future<Database> initializeDatabase() async{


    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'almoxarifado.db';

    var almoxarifadoDatabase = await openDatabase(path,version: 1, onCreate: _createDb);

    return almoxarifadoDatabase;

  }

  void _createDb(Database db , int newVersion) async{

    await db.execute('CREATE TABLE $almoxarifadoTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTipoPedido TEXT, $colNomeSolicitante TEXT, $colNomePeca TEXT)');

  }

  Future<int> insertAlmoxarifado(PedidoAlmoxarifado almoxarifado) async{


    Database db = await this.database;

    var resultado = await db.insert(almoxarifadoTable, almoxarifado.toMap());

    return resultado;

  }


  Future<PedidoAlmoxarifado> getPedidoAlmoxarifado(int id) async{

    Database db = await this.database;

    List<Map> maps = await db.query(almoxarifadoTable,
        columns: [colId, colTipoPedido, colNomeSolicitante, colNomePeca],
        where: "$colId = ?",
        whereArgs: [id]);

    if(maps.length > 0){

      return PedidoAlmoxarifado.fromMap(maps.first);
    }else{

      return null;

    }

  }

  Future<List<PedidoAlmoxarifado>> getPedidosAlmoxarifado() async{

    Database db = await this.database;

    var resultado = await db.query(almoxarifadoTable);

    List<PedidoAlmoxarifado> lista = resultado.isNotEmpty ? resultado.map(

            (c) => PedidoAlmoxarifado.fromMap(c)).toList() : [];

    return lista;

  }


  Future<int> updatePedidoAlmoxarifado(PedidoAlmoxarifado pedidoAlmoxarifado) async{

    Database db = await this.database;

    var resultado = await db.update(almoxarifadoTable, pedidoAlmoxarifado.toMap(),
        where: "$colId = ?",
        whereArgs: [pedidoAlmoxarifado.id]);

    return resultado;

  }


  Future<int> deletePedidoAlmoxarifado(int id) async{

    Database db = await this.database;

    var resultado = await db.delete(almoxarifadoTable,
        where: "$colId = ?",
        whereArgs: [id]);

    return resultado;

  }


  Future close() async{
    Database db = await this.database;
    db.close();
  }

}