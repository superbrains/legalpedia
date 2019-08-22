import 'package:flutter/material.dart';
import 'package:legalpedia/classes/relatedCaseClass.dart';
import 'package:legalpedia/classes/relatedCaseServ.dart';
import 'package:legalpedia/judgementdetails.dart';
import 'package:legalpedia/judgementdetails2.dart' as prefix0;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:legalpedia/judgementdetails2.dart';

class RelatedCases extends StatefulWidget{

  final int principleID;
  List<RelatedCaseList> summary = List();
  List<RelatedCaseList> filteredsummary = List();

  RelatedCases(this.principleID);


  @override
  _RelatedCases createState()=> _RelatedCases(this.principleID);

}

class _RelatedCases extends State<RelatedCases>{

  final int principleID;
  List<RelatedCaseList> summary = List();
  List<RelatedCaseList> filteredsummary = List();

  _RelatedCases(this.principleID);

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
    new Future.delayed(Duration.zero, () {
      loader();
      Services.getSummary(principleID).then((summaryFromServer) {
        setState(() {
          summary = summaryFromServer;
          filteredsummary = summary;
          Navigator.pop(context);
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Judgement Details', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 14.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),

          actions: <Widget>[


            new IconButton(icon: new Icon(Icons.email),onPressed: null,),
          ],
          backgroundColor: Colors.red,

        ),
        body:
        Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Search Judgements...'
              ),
              onChanged: (string){
                setState(() {
                  filteredsummary = summary.where((u)=>
                  (u.title.toLowerCase().contains(string.toLowerCase()) ||
                      u.judgementDate.toLowerCase().contains(string.toLowerCase()) ||
                      u.suitNo.toLowerCase().contains(string.toLowerCase()))).toList();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredsummary.length,
                  itemBuilder: (BuildContext context, int index){

                    return InkWell(
                        splashColor: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: (){
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return prefix0.JudgementDetail(filteredsummary, filteredsummary[index].suitNo);
                            }));
                          });
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(filteredsummary[index].title==null ||  filteredsummary[index].title.toString().toUpperCase()=='NIL|'? 'None': filteredsummary[index].title, style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Monseratti'

                                ),),
                                SizedBox(height: 10.0),
                                Text(filteredsummary[index].judgementDate==null ||  filteredsummary[index].judgementDate.toString().toUpperCase()=='NIL|'? 'None': filteredsummary[index].judgementDate, style: TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'Monseratti',
                                    color: Colors.grey

                                ),),
                              ],
                            ),
                          ),
                        ));
                  }),
            )
          ],
        )
    );
  }


}