import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:legalpedia/classes/judgementbodyclass.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:share/share.dart';

class JudegementBody extends StatefulWidget{


 
  final String id;
  
  JudegementBody(this.id);


  @override
  _JudegementBody createState()=> _JudegementBody(this.id);

}

class _JudegementBody extends State<JudegementBody>{

 //
  final String id;
  JudgementFullBody filteredJudgement;
    String jBody;
    String jTitle;
  _JudegementBody(this.id);

  Future<bool> loader(){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=> AlertDialog(
          title: ScalingText("Loading..."),
        ));
  }

  Future<String> getDemoResponse() async{
    String url;
   
      url=   'https://resources.legalpediaresources.com/api/services/app/summaries/details';
   


    final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'id': id}));
    return response.body;
  }

  @override
  void initState() {
    super.initState();

  }


  void shareText(){
    Share.share(jTitle +'\n\n' + jBody, subject: jTitle);
  }
  
  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
        appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
          elevation: 7.0,
          actionsIconTheme: new IconThemeData(color:  Colors.white),
          title: Text('Judement Body', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),

          actions: <Widget>[


            new IconButton(icon: new Icon(Icons.share),onPressed: shareText,),
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
                    filteredJudgement = JudgementFullBody.fromJson(snapshot.data);
                    jBody = filteredJudgement.result.judgementBody;
                    jTitle  =filteredJudgement.result.title;
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
                                      Text(filteredJudgement.result.title, textAlign: TextAlign.center, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          fontFamily: 'Monseratti',
                                          color: Colors.red

                                      ),),
                                      SizedBox(height: 20.0),
                                      Text(filteredJudgement.result.judgementBody, textAlign: TextAlign.left, style: TextStyle(
                                         
                                          fontSize: 16.0,
                                          fontFamily: 'Monseratti'

                                      ),),
                                      
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