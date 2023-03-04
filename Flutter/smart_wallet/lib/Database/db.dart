
import 'dart:io';

import 'package:smart_wallet/Models/Estimate.dart';
import 'package:smart_wallet/Models/Market.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/Details.dart';

class WalletDatabase{
  static final WalletDatabase instance = WalletDatabase._init();
  static Database? _database;
  WalletDatabase._init();

  Future<Database> get database async {
    if(_database == null){
      _database = await _initDB('wallet.db');
    }
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final Path = join(dbPath, filePath);
    
    return await openDatabase(Path, version:  1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $dtableName(
        ${DetailsFields.id} $idType,
        ${DetailsFields.short} $textType,
        ${DetailsFields.long} $textType,
        ${DetailsFields.important} $integerType
      )
''');

    await db.execute('''
      CREATE TABLE $mtableName(
        ${MarketFields.id} $idType,
        ${MarketFields.name} $textType,
        ${MarketFields.creatingTime} $textType
      )
''');

    await db.execute('''
      CREATE TABLE $etableName(
        ${EstimateFields.id} $idType,
        ${EstimateFields.type} $textType,
        ${EstimateFields.time} $textType,
        ${EstimateFields.amount} $integerType,
        ${EstimateFields.description} $textType,
        ${EstimateFields.market_id} $integerType
      )
''');
    print('Database created.-------------');
  }

Future<Details> createDetails(Details details) async {
    final db = await instance.database;

    final id = await db.insert(dtableName, details.toJson());
    return details.copy(id: id);
  }

  Future<Details> readDetails(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      dtableName,
      columns: DetailsFields.values,
      where: '${DetailsFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return Details.fromJson(maps.first);
    } else {
      throw Exception('Details Id $id not found');
    }
  }

  Future<List<Details>> readAllDetails() async {
    final db = await instance.database;
    final orderBy = '${DetailsFields.important} DESC';
    final result = await db.query(
      mtableName,
      orderBy: orderBy,
    );
    if(result.isNotEmpty){
      return result.map((json) => Details.fromJson(json)).toList();
    }else{
      throw Exception('Database is empty.');
    }
  }
  Future<Market> createMarket(Market market) async {
    final db = await instance.database;

    final id = await db.insert(mtableName, market.toJson());
    return market.copy(id: id);
  }

  Future<Market> readMarket(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      mtableName,
      columns: MarketFields.values,
      where: '${MarketFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return Market.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Market>> readAllMarket() async {
    final db = await instance.database;

    final orderBy = '${MarketFields.creatingTime} ASC';

    final result = await db.query(
      mtableName,
      orderBy: orderBy,
    );
    if(result.isNotEmpty){
      return result.map((json) => Market.fromJson(json)).toList();
    }else{
      throw Exception('Database is empty.');
    }
  }
  
  Future<Estimate> createEstimate(Estimate estimate) async {
    final db = await instance.database;

    final id = await db.insert(etableName, estimate.toJson());
    return estimate.copy(id: id);
  }

  Future<Estimate> readEstimate(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      etableName,
      columns: EstimateFields.values,
      where: '${EstimateFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return Estimate.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Estimate>> readAllEstimate() async {
    final db = await instance.database;
    print('Read all est called----------');

    final orderBy = '${EstimateFields.time} DESC';

    final result = await db.query(
      etableName,
      orderBy: orderBy,
    );
    if(result.isNotEmpty){
      return result.map((json) => Estimate.fromJson(json)).toList();
    }else{
      //throw Exception('Estimate is empty.');
      return [];
    }
  }
  

}