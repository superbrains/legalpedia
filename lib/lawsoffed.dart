import 'package:flutter/material.dart';

class LawsOfFederation extends StatefulWidget{
  @override
  _LawsOfFederation createState()=> _LawsOfFederation();

}

class _LawsOfFederation extends State<LawsOfFederation>{
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
      body: Container(

      ),
    );
  }


}


