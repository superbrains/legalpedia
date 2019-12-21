import 'package:flutter/material.dart';

import 'package:legalpedia/judgementdetails.dart';
import 'package:legalpedia/models/summarymodel.dart';
import 'package:legalpedia/models/ratiosmodel.dart';
import 'package:intl/intl.dart';

class LatestJudgements extends StatefulWidget{

  final List<SummaryModel> summary;
   final List<RatioModel> ratio;
  List<SummaryModel> summary2 = List();
 List<SummaryModel> filteredsummary = List();

  LatestJudgements(this.summary, this.ratio);


  @override
  _LatestJudgements createState()=> _LatestJudgements(this.summary, this.ratio);

}

class _LatestJudgements extends State<LatestJudgements>{

 final List<SummaryModel> summary;
  final List<RatioModel> ratio;
  List<SummaryModel> summary2 = List();
 List<SummaryModel> filteredsummary = List();

  _LatestJudgements(this.summary, this.ratio);

 @override
 void initState() {
   super.initState();

       setState(() {

       //  summary2 = summary.where((u)=>
        // (u.court.toLowerCase().contains('In the Court of Appeal'.toLowerCase()))).toList();
           summary.sort((a, b) => b.judgementDate.compareTo(a.judgementDate));
           
         filteredsummary = summary.take(100).toList();
       });


 }

String getDate(str){

    try{
    var parsedDate = DateTime.parse(str);

    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(parsedDate);

    return formatted;
    } 
    catch(e){
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
  appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Latest 100 Judgements', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),

          backgroundColor: Colors.red,

        ),
        body:
        Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Filter by title, year or suit number'
              ),
              onChanged: (string){
                setState(() {
                  filteredsummary = summary2.where((u)=>
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
                              return JudgementDetail(filteredsummary, filteredsummary[index].suitNo, ratio);
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(filteredsummary[index].judgementDate==null ||  filteredsummary[index].judgementDate.toString().toUpperCase()=='NIL|'? 'None Available':getDate(filteredsummary[index].judgementDate.toString()) , style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'Monseratti',
                                color: Colors.grey

                            ),),
                             Text(filteredsummary[index].court==null ||  filteredsummary[index].court.toString().toUpperCase()=='NIL|'? 'None Available':filteredsummary[index].court.toString() , style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'Monseratti',
                                color: Colors.blue

                            ),),
                            ],),
                           
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