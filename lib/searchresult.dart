import 'package:flutter/material.dart';

import 'package:legalpedia/judgementdetails.dart';
import 'package:legalpedia/models/summarymodel.dart';
import 'package:legalpedia/models/ratiosmodel.dart';

class SearchResult extends StatefulWidget{

  
  final List<RatioModel> ratio;
  final List<SummaryModel> summary;

 
  List<RatioModel> filteredRatio = List();
final String searchText;

  SearchResult(this.ratio, this.searchText, this.summary);


  @override
  _SearchResult createState()=> _SearchResult(this.ratio, this.searchText, this.summary);

}

class _SearchResult extends State<SearchResult>{

  
  final List<RatioModel> ratio;
final String searchText;
  
  List<RatioModel> filteredRatio = List();
  List<SummaryModel> summary = List();

  _SearchResult(this.ratio, this.searchText, this.summary);

  @override
  void initState() {
    super.initState();

    setState(() {

    /*  summary2 = summary.where((u)=>
      (u.court.toLowerCase().contains('In the Supreme Court of Nigeria'.toLowerCase()))).toList();*/

      filteredRatio =ratio;
    });


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
      elevation: 7.0,
      actionsIconTheme: new IconThemeData(color:  Colors.white),
      title: Text('Search Result', style: TextStyle(
        fontWeight:  FontWeight.bold,
          fontSize: 14.0,
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
                  hintText: 'Search ....'
              ),
              onChanged: (string){
                setState(() {
                  filteredRatio = ratio.where((u)=>
                  (u.heading.toLowerCase().contains(string.toLowerCase()) ||
                      u.body.toLowerCase().contains(string.toLowerCase()) ||
                      u.suitNo.toLowerCase().contains(string.toLowerCase()))).toList();
                });
              },
            ),
            SizedBox(height: 15,),
            Text(filteredRatio.length.toString() +' Record(s) found of '+ searchText, style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.red,

            ),),
             SizedBox(height: 5,),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredRatio.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                        splashColor: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10.0),
                    onTap: (){
                   setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return JudgementDetail(summary, filteredRatio[index].suitNo, ratio);
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
                            Text(filteredRatio[index].heading==null ||  filteredRatio[index].heading.toString().toUpperCase()=='NIL|'? 'None': filteredRatio[index].heading, style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Monseratti',
                                color: Colors.blue,
                                fontWeight: FontWeight.bold

                            ),),
                            SizedBox(height: 10.0),
                            Text(filteredRatio[index].body==null ||  filteredRatio[index].body.toString().toUpperCase()=='NIL|'? 'None': filteredRatio[index].body, style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti',
                                color: Colors.green

                            ),),
                             SizedBox(height: 10.0),
                              Text('----------------------------------------------------'),
                              SizedBox(height: 10.0),
                            Text(filteredRatio[index].suitNo==null ||  filteredRatio[index].suitNo.toString().toUpperCase()=='NIL|'? 'None': filteredRatio[index].suitNo, style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti',
                                color: Colors.red

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