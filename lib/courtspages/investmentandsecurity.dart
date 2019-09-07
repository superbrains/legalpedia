import 'package:flutter/material.dart';

import 'package:legalpedia/judgementdetails.dart';
import 'package:legalpedia/models/summarymodel.dart';
import 'package:legalpedia/models/ratiosmodel.dart';

class InvestmentCourt extends StatefulWidget{

  final List<SummaryModel> summary;
  final List<RatioModel> ratio;

  List<SummaryModel> summary2 = List();
  List<SummaryModel> filteredsummary = List();

  InvestmentCourt(this.summary, this.ratio);


  @override
  _InvestmentCourt createState()=> _InvestmentCourt(this.summary, this.ratio);

}

class _InvestmentCourt extends State<InvestmentCourt>{

  final List<SummaryModel> summary;
    final List<RatioModel> ratio;

  List<SummaryModel> summary2 = List();
  List<SummaryModel> filteredsummary = List();

  _InvestmentCourt(this.summary, this.ratio);

  @override
  void initState() {
    super.initState();

    setState(() {

      summary2 = summary.where((u)=>
      (u.court.toLowerCase().contains('In the Investments and Securities Tribunal'.toLowerCase()))).toList();

      filteredsummary = summary2;

    });


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

        body:
        Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Search Judgements (Investment and Securities Tribunal Court)'
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
                            Text(filteredsummary[index].suitNo==null ||  filteredsummary[index].suitNo.toString().toUpperCase()=='NIL|'? 'None': filteredsummary[index].suitNo, style: TextStyle(
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