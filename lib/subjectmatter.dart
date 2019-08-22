import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:legalpedia/principles.dart';
import 'package:legalpedia/classes/SubjectMatter.dart';
import 'classes/Services.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SubjectMatter extends StatefulWidget{
  @override
  _SubjectMatter createState()=> _SubjectMatter();

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
class _SubjectMatter extends State<SubjectMatter>{

  final _debouncer = Debouncer(milliseconds: 500);

  List<SubjectMatters> subMatters = List();
  List<SubjectMatters> filteredsubMatters = List();

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
      Services.getSubjectMatters().then((subMattersFromServer) {
        setState(() {
          subMatters = subMattersFromServer;
          filteredsubMatters = subMatters;
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
        title: Text('Subject Matter Index', style: TextStyle(
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
                  hintText: 'Search Subject Matters...'
              ),
              onChanged: (string){
                _debouncer.run((){
                  setState(() {
                    filteredsubMatters = subMatters.where((u)=>
                    (u.submatter.toLowerCase().contains(string.toLowerCase()))).toList();
                  });
                });

              },
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredsubMatters.length,
                  itemBuilder: (BuildContext context, int index){
                   return InkWell(
                     splashColor: Colors.redAccent,
                     borderRadius: BorderRadius.circular(10.0),
                     onTap: (){
                       setState(() {
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                           return  Principle(filteredsubMatters[index].id);
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
                              Text(filteredsubMatters[index].submatter, style: TextStyle(
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


