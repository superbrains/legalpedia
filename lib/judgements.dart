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

      title: Text('Judgements', style: TextStyle(
        fontWeight:  FontWeight.bold,
        fontSize: 15.0,
        color: Colors.white

      ),),
      backgroundColor: Colors.red,

    ),
    body: Container(

    ),
  );
  }


}


