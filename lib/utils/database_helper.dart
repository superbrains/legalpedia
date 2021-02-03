
import 'package:flutter/services.dart';
import 'package:legalpedia/classes/summaryclass.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:legalpedia/globals.dart' as globals;

import 'package:legalpedia/models/areamodel.dart';
import 'package:legalpedia/models/coramsmodel.dart';
import 'package:legalpedia/models/ratiosmodel.dart';
import 'package:legalpedia/models/summarymodel.dart';

import 'package:path/path.dart' as p;

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String areaTable = 'tblareasoflaw';
  String coramsTable = 'tblcorams';
  String ratiosTable = 'tblratios';
  String summaryTable = 'tblsummaries';

  String colId = "id";
String colsuitno = "suitNo";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //Get path of the directory for android and iOS.
    
    // Construct the path to the app's writable database file:
    var dbDir = await getDatabasesPath();
    print("Directory is $dbDir");
    var dbPath = p.join(dbDir, "dbase.db");

    if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load("assets/legalpediadb.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
    }
// Delete any existing database:
    // await deleteDatabase(dbPath);

// Create the writable database file from the bundled demo database file:

    var db = await openDatabase(dbPath);

    print("Path is $dbPath");
    return db;
  }

/*  void _createDb(Database db, int newversion) async {
    await db.execute(
        'CREATE TABLE $visitorsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colname TEXT, $colPhone TEXT, $colAdress TEXT, $colPurpose TEXT, $colTagno TEXT, $coldatein TEXT, $colTimein TEXT,$coldateout TEXT, $colTimeout TEXT)');
  } */

  Future<List<Map<String, dynamic>>> getSummaryMapList() async {
    Database db = await this.database;
    var result =
        await db.rawQuery('SELECT * FROM $summaryTable order by $colId DESC');
    //var result = await db.query(visitorsTable, orderBy: '$colId DESC' );
    return result;
  }

  Future<List<Map<String, dynamic>>> getRatioMapList() async {
    Database db = await this.database;
    var result =
        await db.rawQuery('SELECT * FROM $ratiosTable order by $colId DESC');
    //var result = await db.query(visitorsTable, orderBy: '$colId DESC' );
    return result;
  }

  Future<List<Map<String, dynamic>>> getCoramMapList() async {
    Database db = await this.database;
    var result =
        await db.rawQuery('SELECT * FROM $coramsTable order by $colId DESC');
    //var result = await db.query(visitorsTable, orderBy: '$colId DESC' );
    return result;
  }

  Future<List<Map<String, dynamic>>> getAreasOfLawMapList() async {
    Database db = await this.database;
    var result =
        await db.rawQuery('SELECT * FROM $areaTable order by $colId DESC');
    //var result = await db.query(visitorsTable, orderBy: '$colId DESC' );
    return result;
  }

  /*Future<List<Map<String, dynamic>>> getTodayVisitorsMapList(String str) async {
    Database db = await this.database;
   // var result =        await db.rawQuery('SELECT * FROM $visitorsTable order by $colId DESC');
    var result = await db.query(visitorsTable, where: '$coldatein =?',whereArgs: [str], orderBy: '$colId DESC' );
    return result;
  }*/

    Future<String> insertSummary( List<SummaryList> summary) async {
    Database db = await this.database;
    var result;
    
                  var updatecnt;
                 updatecnt = summary.length-1;

                  var cnt =globals.summary.length + 23456;
                  int corCount;
                  Future<int> fuCorCount = getCoramcount().then((value) =>(
                  corCount =value

                  ));
                  
                  corCount = corCount + 23456;

                  int ratioCount;
                  Future<int> fuRatioCount = getRatiocount().then((value) =>(
                  ratioCount =value

                  ));
                  ratioCount = ratioCount + 23456;

                  for( var i = 0 ; i <= updatecnt; i++ ) { 
                      cnt++;
                      //Implement Update Here
                   SummaryModel summaryModel = new SummaryModel.withId(cnt, summary[i].suitNo, 
                   summary[i].title,summary[i].summaryOfFacts, summary[i].held, 
                   summary[i].issues, summary[i].casesCited, summary[i].statusCited,
                   summary[i].legalpediaCitation, summary[i].judgementDate, summary[i].otherCitations,
                   summary[i].court, summary[i].category, summary[i].counsels,
                   summary[i].holdenAt, summary[i].partyAType, summary[i].partyBType,
                   summary[i].partiesA, summary[i].partiesB);
                    
                     List<CoramModel> coramModels = new List<CoramModel>();

                     summary[i].corams.forEach((item) {
                        CoramModel coramModel = new CoramModel.withId(corCount, summary[i].suitNo, item);
                        coramModels.add(coramModel);
                        corCount++;

                     });
                   
                    List<RatioModel> ratioModels = new List<RatioModel>();

                     summary[i].ratios.forEach((item) {
                        RatioModel ratioModel = new RatioModel(ratioCount, summary[i].suitNo, item.heading, item.coram, item.body, item.summary);
                        ratioModels.add(ratioModel);
                        ratioCount++;
                     });


                  if(globals.summary.where((element) => element.suitNo==summary[i].suitNo).length>0){
                    
                      var result = await db.update(summaryTable, summaryModel.toMap(),
                      where: '$colsuitno = ?', whereArgs: [summaryModel.suitNo]);

                                           print("Updated " + i.toString());

                  }else{

                      globals.summary.add(summaryModel);
                      
                  result  = await db.insert(summaryTable, summaryModel.toMap());
                 
                  coramModels.forEach((element) async{
                     result  = await db.insert(coramsTable, element.toMap());
                  });

                  ratioModels.forEach((element) async{
                     result  = await db.insert(coramsTable, element.toMap());
                  });


                  print("inserted " + i.toString() );

                  }
                   
                  }

    return result.toString();
  }

  Future<int> insertRatio(RatioModel ratio) async {
    Database db = await this.database;
    var result = await db.insert(ratiosTable, ratio.toMap());

    return result;
  }

  Future<int> insertCoram(CoramModel coram) async {
    Database db = await this.database;
    var result = await db.insert(coramsTable, coram.toMap());

    return result;
  }

  Future<int> insertAreas(AreaModel area) async {
    Database db = await this.database;
    var result = await db.insert(areaTable, area.toMap());

    return result;
  }

  Future<int> updateSummary(SummaryModel summary) async {
    Database db = await this.database;
    var result = await db.update(summaryTable, summary.toMap(),
        where: '$colsuitno = ?', whereArgs: [summary.suitNo]);

    return result;
  }

  Future<int> updateRatio(RatioModel ratio) async {
    Database db = await this.database;
    var result = await db.update(ratiosTable, ratio.toMap(),
        where: '$colId = ?', whereArgs: [ratio.id]);

    return result;
  }

  Future<int> updateCoram(CoramModel coram) async {
    Database db = await this.database;
    var result = await db.update(coramsTable, coram.toMap(),
        where: '$colId = ?', whereArgs: [coram.id]);

    return result;
  }

  Future<int> updateAreasOfLaw(AreaModel area) async {
    Database db = await this.database;
    var result = await db.update(areaTable, area.toMap(),
        where: '$colId = ?', whereArgs: [area.id]);

    return result;
  }

  Future<int> deleteSummary(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $summaryTable WHERE $colId = $id');

    return result;
  }

  Future<int> deleteRatio(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $ratiosTable WHERE $colId = $id');

    return result;
  }

  Future<int> deleteCoram(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $coramsTable WHERE $colId = $id');

    return result;
  }

  Future<int> deleteAreaOfLaw(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $areaTable WHERE $colId = $id');

    return result;
  }

  Future<int> getSummaryCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM $summaryTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getRatiocount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM $ratiosTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCoramcount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM $coramsTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getAreaCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM $areaTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<SummaryModel>> getSummaryList() async {
    var summaryMapList = await getSummaryMapList();
    int count = summaryMapList.length;

    List<SummaryModel> summaryList = List<SummaryModel>();

    for (int i = 0; i < count; i++) {
      summaryList.add(SummaryModel.fromMapObject(summaryMapList[i]));
    }

    return summaryList;
  }

  Future<List<RatioModel>> getRatioList() async {
    var ratioMapList = await getRatioMapList();
    int count = ratioMapList.length;

    List<RatioModel> ratioList = List<RatioModel>();

    for (int i = 0; i < count; i++) {
      ratioList.add(RatioModel.fromMapObject(ratioMapList[i]));
    }

    return ratioList;
  }

  Future<List<CoramModel>> getCoramList() async {
    var coramMapList = await getCoramMapList();
    int count = coramMapList.length;

    List<CoramModel> coramList = List<CoramModel>();

    for (int i = 0; i < count; i++) {
      coramList.add(CoramModel.fromMapObject(coramMapList[i]));
    }

    return coramList;
  }

  Future<List<AreaModel>> getAreaList() async {
    var areaMapList = await getAreasOfLawMapList();
    int count = areaMapList.length;

    List<AreaModel> areaList = List<AreaModel>();

    for (int i = 0; i < count; i++) {
      areaList.add(AreaModel.fromMapObject(areaMapList[i]));
    }

    return areaList;
  }
}
