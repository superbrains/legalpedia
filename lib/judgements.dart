import 'package:flutter/material.dart';

class Judgment extends StatefulWidget{
  @override
  _Judgment createState()=> _Judgment();

}

class _Judgment extends State<Judgment>{
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
    body: Container(

    ),
  );
  }


}


