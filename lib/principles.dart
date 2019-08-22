import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:legalpedia/classes/principleClass.dart';
import 'classes/principleserv.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:legalpedia/relatedcases.dart';

class Principle extends StatefulWidget{
  final int subId;
  Principle(this.subId);
  @override
  _Principle createState()=> _Principle(this.subId);

}

class Debouncer{
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.milliseconds});

  run(VoidCallback action){
    if (null != _timer){
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

}
class _Principle extends State<Principle>{
  final int subId;
  _Principle(this.subId);

  final _debouncer = Debouncer(milliseconds: 500);

  List<PrincipleList> principles = List();
  List<PrincipleList> filteredprinciples = List();

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
      Services.getPrinciple(subId).then((principlesFromServer) {
        setState(() {
          principles = principlesFromServer;
          filteredprinciples = principles;
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
          title: Text('Principles(Actions)', style: TextStyle(
              fontWeight:  FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'Monseratti',
              color: Colors.white

          ),),
          actions: <Widget>[

            new IconButton(icon: new Icon(Icons.refresh),onPressed: null,),

          ],
          backgroundColor: Colors.red,

        ),
        body:
        Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Search Principles...'
              ),
              onChanged: (string){
                _debouncer.run((){
                  setState(() {
                    filteredprinciples = principles.where((u)=>
                    (u.name.toLowerCase().contains(string.toLowerCase()))).toList();
                  });
                });

              },
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredprinciples.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      splashColor: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return RelatedCases(filteredprinciples[index].id);
                          }));
                        });
                      },

                      child:  Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(filteredprinciples[index].name, style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Monseratti'

                              ),),

                            ],
                          ),
                        ),
                      )
                      ,
                    );

                  }),
            )
          ],
        )
    );
  }


}


