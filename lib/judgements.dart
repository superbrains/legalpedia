import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:async';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:legalpedia/classes/summaryclass.dart';
import 'package:legalpedia/classes/summaryserv.dart';
import 'package:legalpedia/courtspages/courtofappeal.dart' as appealcourt;
import 'package:legalpedia/courtspages/fedcourt.dart' as fedcourt;
import 'package:legalpedia/courtspages/industrialcourt.dart' as industcourt;
import 'package:legalpedia/courtspages/investmentandsecurity.dart' as investcourt;
import 'package:legalpedia/courtspages/shariacourt.dart' as shariacourt;
import 'package:legalpedia/courtspages/supremecourt.dart' as supremecourt;


class Judgment extends StatefulWidget{
  @override
  _Judgment createState()=> _Judgment();

}

class _Judgment extends State<Judgment> with SingleTickerProviderStateMixin{

  List<SummaryList> summary = List();
  List<SummaryList> filteredsummary = List();
  TabController controller;

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
    new Future.delayed(Duration.zero, () {
      loader();
      Services.getSummary().then((summaryFromServer) {
        setState(() {
          summary = summaryFromServer;
          filteredsummary = summary;
          Navigator.pop(context);
          controller.animateTo(1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );


        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

          new Tab(text: 'Appeal' ),
        new Tab(text: 'Supreme'),
          new Tab(text: 'High'),
          new Tab(text: 'Industrial'),
          new Tab(text: 'Tribunal'),
          new Tab(text: 'Sharia'),

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
        new appealcourt.CourtofAppeal(summary),
      new supremecourt.SupremeCourt(summary),
        new fedcourt.FederalCourt(summary),
        new industcourt.IndustrialCourt(summary),
        new investcourt.InvestmentCourt(summary),
        new shariacourt.ShariaCourt(summary),

      ],
    )
  );
  }


}



