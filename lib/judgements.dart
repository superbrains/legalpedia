import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';

class Judgment extends StatefulWidget{
  @override
  _Judgment createState()=> _Judgment();

}

class _Judgment extends State<Judgment>{

  Map data;
  List summaries;

  Future<bool> loader(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText("Loading..."),
        ));
  }

  Future getData() async {
    var url = 'http://35.231.129.160/api/services/app/summaries/getall';
    var response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 20, 'SkipCount': 0}));
    data = json.decode(response.body);
    setState(() {
      summaries = data["result"]["items"];

    });

  }


  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      loader();

      getData().then((rulesFromServer) {
        setState(() {
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
      title: Text('Judgements', style: TextStyle(
        fontWeight:  FontWeight.bold,
          fontSize: 16.0,
          fontFamily: 'Monseratti',
        color: Colors.white

      ),),
      actions: <Widget>[

        new IconButton(icon: new Icon(Icons.refresh),onPressed: null,),
        new IconButton(icon: new Icon(Icons.home),onPressed: null,),
      ],
      backgroundColor: Colors.red,

    ),
    body:
     Column(
       children: <Widget>[
         TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            hintText: 'Search by Any Keyword (Suit Case, Date etc)'
          ),

         ),
         Expanded(
           child: ListView.builder(
               padding: EdgeInsets.all(10.0),
               itemCount: summaries==null?0: summaries.length,
               itemBuilder: (BuildContext context, int index){
                 return Card(
                   child: Padding(
                     padding: EdgeInsets.all(10.0),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text(summaries[index]['title']==null ||  summaries[index]['title'].toString().toUpperCase()=='NIL|'? 'None': summaries[index]['title'], style: TextStyle(
                           fontSize: 15.0,
                           fontFamily: 'Monseratti'

                         ),),
                         SizedBox(height: 10.0),
                         Text(summaries[index]['suitNo']==null ||  summaries[index]['suitNo'].toString().toUpperCase()=='NIL|'? 'None': summaries[index]['suitNo'], style: TextStyle(
                             fontSize: 10.0,
                             fontFamily: 'Monseratti',
                            color: Colors.grey

                         ),),
                       ],
                     ),
                   ),
                 );
               }),
         )
       ],
     )
  );
  }


}



