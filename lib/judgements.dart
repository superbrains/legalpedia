import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:async';

import 'package:progress_indicators/progress_indicators.dart';

import 'package:legalpedia/courtspages/courtofappeal.dart' as appealcourt;
import 'package:legalpedia/courtspages/fedcourt.dart' as fedcourt;
import 'package:legalpedia/courtspages/industrialcourt.dart' as industcourt;
import 'package:legalpedia/courtspages/investmentandsecurity.dart' as investcourt;
import 'package:legalpedia/courtspages/shariacourt.dart' as shariacourt;
import 'package:legalpedia/courtspages/supremecourt.dart' as supremecourt;


import 'package:sqflite/sqflite.dart';
import 'package:legalpedia/models/summarymodel.dart';
import 'package:legalpedia/utils/database_helper.dart';


class Judgment extends StatefulWidget{
  final List<SummaryModel> summary;
  Judgment(this.summary);
  @override
  _Judgment createState()=> _Judgment(this.summary);

}

class _Judgment extends State<Judgment> with SingleTickerProviderStateMixin{

   final List<SummaryModel> summary;
  _Judgment(this.summary);

  List<SummaryModel> filteredsummary = List();


   DatabaseHelper databaseHelper = DatabaseHelper();

  int count = 0;

  TabController controller;



 /*  updateListview() async{
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<SummaryModel>> summaryListFuture =
          databaseHelper.getSummaryList();
      summaryListFuture.then((summaryList) {
        setState(() {
         
        
        });
      });
    });
  }*/


  Future<bool> loader(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText("Loading..."),
        ));
  }



  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 6);
    setState(() {
        this.filteredsummary = summary;
         this.count = filteredsummary.length; 
    });
    /*new Future.delayed(Duration.zero, () {
      loader();
      updateListview().then((str){
                
                setState(() {
         

          Navigator.pop(context);
          controller.animateTo(1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );


        });
      });
     
    });*/
  }

/*getCsv() async {

 //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.


 List<List<dynamic>> rows = List<List<dynamic>>();
   List<dynamic> row = List();
    row.add('suitNo');
     row.add('title');
     row.add('summaryOfFacts');
    row.add('held');
    row.add('issues');
    row.add('casesCited');
    row.add('statusCited');
    row.add('legalpediaCitation');
row.add('judgementDate');
row.add('otherCitations');
row.add('court');
row.add('category');
row.add('counsels');
row.add('holdenAt');
row.add('partyAType');
row.add('partyBType');
row.add('partiesA');
row.add('partiesB');
 rows.add(row);



  for (int i = 0; i <filteredsummary.length;i++) {

//row refer to each column of a row in csv file and rows refer to each row in a file
    List<dynamic> row = List();
    row.add(filteredsummary[i].suitNo);
    row.add(filteredsummary[i].title);
    row.add(filteredsummary[i].summaryOfFacts);
    row.add(filteredsummary[i].held);
    row.add(filteredsummary[i].issues);
    row.add(filteredsummary[i].casesCited);
    row.add(filteredsummary[i].statusCited);
    row.add(filteredsummary[i].legalpediaCitation);
    row.add(filteredsummary[i].judgementDate);
    row.add(filteredsummary[i].otherCitations);
    row.add(filteredsummary[i].court);
    row.add(filteredsummary[i].category);
    row.add(filteredsummary[i].counsels);
    row.add(filteredsummary[i].holdenAt);
    row.add(filteredsummary[i].partyAType);
    row.add(filteredsummary[i].partyBType);
    row.add(filteredsummary[i].partiesA);
    row.add(filteredsummary[i].partiesB);

    rows.add(row);
  }

 await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
  bool checkPermission=await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
  if(checkPermission) {

//store file in documents folder

    String dir = (await getExternalStorageDirectory()).absolute.path + "/download";
    var file = "$dir";
    print(file);
    File f = new File(file+"summary1.csv");

// convert rows to String and write as csv file

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);

    print('Saving Summary Completed');
  }


}

getCsvRatio() async {

 //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.


 List<List<dynamic>> rows = List<List<dynamic>>();
   List<dynamic> row = List();
    row.add('suitNo');
     row.add('heading');
     row.add('coram');
    row.add('body');
    row.add('summary');
    row.add('id');
   
 rows.add(row);



  for (int i = 0; i <filteredsummary.length;i++) {

//row refer to each column of a row in csv file and rows refer to each row in a file
   
    
    
    for(int j=0; j<filteredsummary[i].ratios.length; j++){
       List<dynamic> row = List();
     // row.add(filteredsummary[i].suitNo);
       row.add(filteredsummary[i].ratios[j].suitNo);
        row.add(filteredsummary[i].ratios[j].heading);
        row.add(filteredsummary[i].ratios[j].coram);
        row.add(filteredsummary[i].ratios[j].body);
         row.add(filteredsummary[i].ratios[j].summary);
          row.add(filteredsummary[i].ratios[j].id);

           rows.add(row);
    }

   
  }

 await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
  bool checkPermission=await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
  if(checkPermission) {

//store file in documents folder

    String dir = (await getExternalStorageDirectory()).absolute.path + "/download";
    var file = "$dir";
    print(file);
    File f = new File(file+"ratio1.csv");

// convert rows to String and write as csv file

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);

    print('Saving Ratio Completed');
  }


}

getCsvCoram() async {

 //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.


 List<List<dynamic>> rows = List<List<dynamic>>();
   List<dynamic> row = List();
    row.add('suitNo');
    
     row.add('coram');
   
   
 rows.add(row);



  for (int i = 0; i <filteredsummary.length;i++) {

//row refer to each column of a row in csv file and rows refer to each row in a file
  
    
    
    for(int j=0; j<filteredsummary[i].corams.length; j++){
        List<dynamic> row = List();
      row.add(filteredsummary[i].suitNo);
       row.add(filteredsummary[i].corams[j].toString());
        rows.add(row);
       
    }

   
  }

 await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
  bool checkPermission=await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
  if(checkPermission) {

//store file in documents folder

    String dir = (await getExternalStorageDirectory()).absolute.path + "/download";
    var file = "$dir";
    print(file);
    File f = new File(file+"corams1.csv");

// convert rows to String and write as csv file

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);

    print('Saving Corams Completed');
  }


}

getCsvArea() async {

 //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.


 List<List<dynamic>> rows = List<List<dynamic>>();
   List<dynamic> row = List();
    row.add('suitNo');
    
     row.add('coram');
   
   
 rows.add(row);



  for (int i = 0; i <filteredsummary.length;i++) {

//row refer to each column of a row in csv file and rows refer to each row in a file
   
    
    
    for(int j=0; j<filteredsummary[i].areasOfLaw.length; j++){
       List<dynamic> row = List();
      row.add(filteredsummary[i].suitNo);
       row.add(filteredsummary[i].areasOfLaw[j].toString());
         rows.add(row);
    }

  
  }

 await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
  bool checkPermission=await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
  if(checkPermission) {

//store file in documents folder

    String dir = (await getExternalStorageDirectory()).absolute.path + "/download";
    var file = "$dir";
    print(file);
    File f = new File(file+"areas1.csv");

// convert rows to String and write as csv file

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);

    print('Saving Areas Completed');
  }


}*/


  @override
  void dispose() {
  
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
   
  return new Scaffold(
    appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
      elevation: 7.0,
      actionsIconTheme: new IconThemeData(color:  Colors.white),
      title: Text('Judgements by Court', style: TextStyle(
        fontWeight:  FontWeight.bold,
          fontSize: 14.0,
          fontFamily: 'Monseratti',
        color: Colors.white

      ),),
      bottom: new TabBar(
        controller: controller,
        isScrollable: true,

        tabs: <Widget>[
          new Tab(text: 'Supreme'),
          new Tab(text: 'Appeal' ),
      
          new Tab(text: 'High'),
           new Tab(text: 'Sharia'),
          new Tab(text: 'Industrial'),
          new Tab(text: 'Tribunal'),
         

        ],
      ),
      actions: <Widget>[

        new IconButton(icon: new Icon(Icons.refresh),onPressed: null,),
        new IconButton(icon: new Icon(Icons.home),onPressed: null,),
      ],
      backgroundColor: Colors.red,

    ),
    body:
    new TabBarView(
      controller: controller,
      children: <Widget>[
         new supremecourt.SupremeCourt(summary),
        new appealcourt.CourtofAppeal(summary),
     
        new fedcourt.FederalCourt(summary),
         new shariacourt.ShariaCourt(summary),
        new industcourt.IndustrialCourt(summary),
        new investcourt.InvestmentCourt(summary),
       

      ],
    )
  );
  }


}



