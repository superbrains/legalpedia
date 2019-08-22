import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalpedia/classes/ruledetailsClass.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';

class Rules extends StatefulWidget{


  final String  ruleType;
  final String  state;
  final String  section;

  Rules(this.ruleType, this.state, this.section);


  @override
  _Rules createState()=> _Rules(this.ruleType, this.state, this.section);

}

class _Rules extends State<Rules>{

  final String  ruleType;
  final String  state;
  final String  section;
  RuleDetails filteredrules;
  _Rules(this.ruleType, this.state, this.section);

  Future<bool> loader(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText("Loading..."),
        ));
  }

  Future<String> getDemoResponse() async{
    String url;
    if(ruleType=='States'){
      url=   'http://35.231.129.160/api/services/app/rulesofcourt/State';
    }else{
      url=   'http://35.231.129.160/api/services/app/rulesofcourt/other';
    }


    final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 20, 'SkipCount': 0, 'StateName': state, 'Section': section}));
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
          title: Text('Rule Details', style: TextStyle(
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
                    filteredrules = RuleDetails.fromJson(snapshot.data);

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
    /*   TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            hintText: 'Search By Title'
                        ),
                        onChanged: (string){

                          setState(() {
                          filteredrules = filteredrules.result.items.where((u)=>
                            (u.title.toLowerCase().contains(string.toLowerCase()) ||
                                u.lawDate.toLowerCase().contains(string.toLowerCase()))).toList();
                          });


                        },
                      ),*/
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.all(5.0),
                            itemCount:filteredrules.result.items.length,
                            itemBuilder: (BuildContext context, int index){
                              return  Card(
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(height: 10.0),
                                      Text('STATE NAME', textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          fontFamily: 'Monseratti',
                                          color: Colors.red

                                      ),),
                                      SizedBox(height: 10.0),
                                      Text(filteredrules.result.items[index].name==null?'Not Available': filteredrules.result.items[index].name, textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          fontFamily: 'Monseratti'

                                      ),),
                                      SizedBox(height: 30.0),
                                      Text('TITLE', textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          fontFamily: 'Monseratti',
                                          color: Colors.red

                                      ),),
                                      SizedBox(height: 10.0),
                                      Text(filteredrules.result.items[index].title==null?'Not Available': filteredrules.result.items[index].title, textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          fontFamily: 'Monseratti'

                                      ),),
                                      SizedBox(height: 30.0),
                                      Text('SECTION', textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          fontFamily: 'Monseratti',
                                          color: Colors.red

                                      ),),
                                      SizedBox(height: 10.0),
                                      Text(filteredrules.result.items[index].section==null?'Not Available': filteredrules.result.items[index].section, textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          fontFamily: 'Monseratti'

                                      ),),
                                      SizedBox(height: 30.0),
                                      Text('RULE TYPE', textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          fontFamily: 'Monseratti',
                                          color: Colors.red

                                      ),),
                                      SizedBox(height: 10.0),
                                      Text(filteredrules.result.items[index].type==null?'Not Available': filteredrules.result.items[index].type, textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          fontFamily: 'Monseratti'

                                      ),),
                                      SizedBox(height: 30.0),
                                      Text('CONTENT', textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          fontFamily: 'Monseratti',
                                          color: Colors.red

                                      ),),
                                      Html(
                                        data: filteredrules.result.items[index].content==null?'Not Available':filteredrules.result.items[index].content ,
                                        customTextAlign: (dom.Node node) {
                                          if (node is dom.Element) {
                                            switch (node.localName) {
                                              case "p":
                                                return TextAlign.center;
                                            }
                                          }
                                          return null;
                                        },
                                        customTextStyle: (dom.Node node, TextStyle baseStyle) {
                                          if (node is dom.Element) {
                                            switch (node.localName) {
                                              case "p":
                                                return baseStyle.merge(TextStyle(height: 2, fontSize: 14, fontFamily: 'Monseratti'));
                                            }
                                          }
                                          return baseStyle;
                                        },

                                        /*customRender: (node, children) {
                                  if (node is dom.Element) {
                                    switch (node.localName) {
                                      case "custom_tag":
                                        return Column(children: children);
                                    }
                                  }
                                  return null;
                                },*/
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