import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalpedia/classes/lawdetailClassTwo.dart';

import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class LawofFederationDetail extends StatefulWidget{


  final int  id;

  LawofFederationDetail(this.id);


  @override
  _LawofFederationDetail createState()=> _LawofFederationDetail(this.id);

}

class _LawofFederationDetail extends State<LawofFederationDetail>{

  final int id;
  LawDetailList filteredlaws;
  _LawofFederationDetail(this.id);

  Future<bool> loader(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText("Loading..."),
        ));
  }

  Future<String> getDemoResponse() async{
    String url =   'http://35.231.129.160/api/services/app/lawsoffederation/detail';

    final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'id': id}));
    return response.body;
  }

  @override
  void initState() {
    super.initState();

  }

  String getDate(str){

    var parsedDate = str;

    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(parsedDate);

    return formatted;
  }

  double getHeight(height){

    String ht = height.toString();
    double ht2 = double.parse(ht);
    return ht2 * 25.0;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Laws of Federation Details', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),

          actions: <Widget>[


            new IconButton(icon: new Icon(Icons.email),onPressed: null,),
          ],
          backgroundColor: Colors.red,

        ),
body:    Center(
      child: new FutureBuilder<String>(
      future: getDemoResponse(), // async work
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return CircularProgressIndicator();
          //return new Text('Loading....');
        default:
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          else
            filteredlaws = LawDetailList.fromJson(snapshot.data);

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(5.0),
                      itemCount:1,
                      itemBuilder: (BuildContext context, int index){
                        return  Card(
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(filteredlaws.result.title==null?'Not Available': filteredlaws.result.title, textAlign: TextAlign.center, style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    fontFamily: 'Monseratti'

                                ),),
                                SizedBox(height: 20.0),
                                Text(filteredlaws.result.lawNo ==null?'None':filteredlaws.result.lawNo , textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green
                                ),),

                                SizedBox(height: 20.0),

                                Text( filteredlaws.result.lawDate==null?'Not Available': getDate(filteredlaws.result.lawDate).toString() , textAlign: TextAlign.center, style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Monseratti',


                                ),),
                                SizedBox(height: 40.0),
                                Text('DESCRIPTION', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                SizedBox(height: 10.0),
                                Text(filteredlaws.result.descr==null?'Not Available:':filteredlaws.result.descr, textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Monseratti'

                                ),),
                                SizedBox(height: 30.0),
                                Text('SCHEDULES', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),

                                Column(
                                  children: <Widget>[
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: filteredlaws.result.schedules.length,
                                        itemBuilder: (BuildContext context, int count){
                                          return Column(
                                            children: <Widget>[
                                              Text(filteredlaws.result.schedules[count].schedHeader==null?'Not Available':filteredlaws.result.schedules[count].schedHeader, style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontFamily: 'Monseratti',
                                                  fontWeight: FontWeight.bold

                                              ),
                                              ),
                                              SizedBox(height: 5.0,),
                                              Text(filteredlaws.result.schedules[count].schedBody==null?'Not Available':filteredlaws.result.schedules[count].schedBody, style: TextStyle(
                                                fontSize: 12.0,
                                                fontFamily: 'Monseratti',

                                              ),

                                              ),
                                              SizedBox(height: 10.0,),
                                            ],
                                          )  ;

                                        }

                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0,),

                                Text('PARTS', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Monseratti',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent

                                ),),
                                Column(
                                  children: <Widget>[
                                    Container(

                                      child:  ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: filteredlaws.result.parts.length,
                                          itemBuilder: (BuildContext context, int count){
                                            return Column(
                                              children: <Widget>[
                                                Text(filteredlaws.result.parts[count].partHeader==null?'Not Available':filteredlaws.result.parts[count].partHeader, style: TextStyle(
                                                    fontSize: 13.0,
                                                    fontFamily: 'Monseratti',
                                                    fontWeight: FontWeight.bold,
                                                      color: Colors.green
                                                ),
                                                ),

                                                SizedBox(height: 10.0,),

                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: filteredlaws.result.parts[count].sections.length,
                                                    itemBuilder: (BuildContext context, int count2){
                                                      return Column(
                                                        children: <Widget>[
                                                          Text(filteredlaws.result.parts[count].sections[count2].sectionHeader==null?'Not Available':filteredlaws.result.parts[count].sections[count2].sectionHeader, style: TextStyle(
                                                              fontSize: 13.0,
                                                              fontFamily: 'Monseratti',
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.red
                                                          ),
                                                          ),

                                                          SizedBox(height: 10.0,),
                                                          Text(filteredlaws.result.parts[count].sections[count2].sectionBody==null?'Not Available':filteredlaws.result.parts[count].sections[count2].sectionBody, style: TextStyle(
                                                              fontSize: 13.0,
                                                              fontFamily: 'Monseratti',


                                                          ),
                                                          ),

                                                          SizedBox(height: 10.0,),
                                                        ],
                                                      )  ;

                                                    }

                                                ),

                                              ],
                                            )  ;

                                          }

                                      ),

                                    ),
                                  ],
                                ),

                                SizedBox(height: 50,)
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
      }
    },
  ),
)
    );
  }


}