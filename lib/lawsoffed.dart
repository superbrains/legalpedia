import 'package:flutter/material.dart';
import 'package:legalpedia/classes/lawclass.dart';
import 'classes/lawserv.dart';

import 'package:progress_indicators/progress_indicators.dart';


class LawsOfFederation extends StatefulWidget{
  @override
  _LawsOfFederation createState()=> _LawsOfFederation();

}

class _LawsOfFederation extends State<LawsOfFederation>{

  List<LawList> laws = List();
  List<LawList> filteredlaws = List();

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
      Services.getLaws().then((lawsFromServer) {
        setState(() {
          laws = lawsFromServer;
          filteredlaws = laws;
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
        title: Text('Laws of the Federation', style: TextStyle(
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
                hintText: 'Search Laws...'
            ),
            onChanged: (string){

              setState(() {
                filteredlaws = laws.where((u)=>
                (u.title.toLowerCase().contains(string.toLowerCase()) ||
                    u.lawDate.toLowerCase().contains(string.toLowerCase()))).toList();
              });


            },
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount:  filteredlaws.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    splashColor: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: (){
                      setState(() {

                      });
                    },

                    child:  Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(filteredlaws[index].title, style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Monseratti',


                            ),),
                            SizedBox(height: 15.0),

                            Text(filteredlaws[index].lawDate, style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Monseratti',

                                color: Colors.grey


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
      ),
    );
  }


}


