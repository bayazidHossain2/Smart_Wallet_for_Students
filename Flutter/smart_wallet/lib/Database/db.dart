
import 'dart:io';

import 'package:smart_wallet/Models/Estimate.dart';
import 'package:smart_wallet/Models/Market.dart';
import 'package:smart_wallet/common.dart';
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
    
    return await openDatabase(Path, version:  3, onCreate: _createDB);
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
      dtableName,
      orderBy: orderBy,
    );
    if(result.isNotEmpty){
      return result.map((json) => Details.fromJson(json)).toList();
    }else{
      //throw Exception('Database is empty.');
      return [];
    }
  }

  Future<int> updateDetails(Details details) async {
    final db = await instance.database;
    print('------updating ${details.id}');
    return db.update(
      dtableName,
      details.toJson(),
      where: '${DetailsFields.id} = ?',
      whereArgs: [details.id],
    );
  }

  Future<int> deleteDetails(int id) async {
    final db = await instance.database;

    return await db.delete(
      dtableName,
      where: '${DetailsFields.id} = ?',
      whereArgs: [id],
    );
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
      //throw Exception('Database is empty.');
      return [];
    }
  }

  Future<int> deleteMarket(int id) async {
    final db = await instance.database;

    db.delete(
      etableName,
      where: '${EstimateFields.market_id} = ?',
      whereArgs: [id],
    );

    return await db.delete(
      mtableName,
      where: '${MarketFields.id} = ?',
      whereArgs: [id],
    );
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

  Future<List<Estimate>> readAllEstimateByMarketId(int marketid) async {
    final db = await instance.database;
    print('Read all est called----------');

    final orderBy = '${EstimateFields.time} DESC';

    final result = await db.query(
      etableName,
      where: '${EstimateFields.market_id} = ?',
      whereArgs: [marketid],
      orderBy: orderBy,
    );
    if(result.isNotEmpty){
      return result.map((json) => Estimate.fromJson(json)).toList();
    }else{
      //throw Exception('Estimate is empty.');
      return [];
    }
  }

  Future<int> deleteEstimate(int id) async {
    final db = await instance.database;

    return await db.delete(
      etableName,
      where: '${EstimateFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<List<int>> readBalance(int marketId) async {
    int deposit = 0, spend = 0, save = 0;
    final db = await instance.database;
    final dresult = await db.query(
      etableName,
      where: '${EstimateFields.market_id} = ? AND ${EstimateFields.type} = ?',
      whereArgs: [marketId,upperText[1]],
    );
    final dlist = dresult.map((json) => Estimate.fromJson(json)).toList();
    for(int i=0;i<dlist.length;i++){
      deposit += dlist[i].amount;
    }
    print('---------Deposit list size '+dlist.length.toString());
    print('Total deposit : '+deposit.toString());
    final spresult = await db.query(
      etableName,
      where: '${EstimateFields.market_id} = ? AND ${EstimateFields.type} = ?',
      whereArgs: [marketId,upperText[0]],
    );
    final splist = spresult.map((json) => Estimate.fromJson(json)).toList();
    for(int i=0;i<splist.length;i++){
      spend += splist[i].amount;
    }
    print('---------Spend list size '+splist.length.toString());
    print('Total spend : '+spend.toString());
    final saresult = await db.query(
      etableName,
      where: '${EstimateFields.market_id} = ? AND ${EstimateFields.type} = ?',
      whereArgs: [marketId,upperText[2]],
    );
    final salist = saresult.map((json) => Estimate.fromJson(json)).toList();
    for(int i=0;i<salist.length;i++){
      save += salist[i].amount;
    }
    print('---------Save list size '+salist.length.toString());
    print('Total save : '+save.toString());

    return [(deposit-spend-save),spend,deposit,save];
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

}