import 'package:flutter/material.dart';
import 'package:legalpedia/classes/maximclass.dart';
import 'classes/maximserv.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:connectivity/connectivity.dart';

import 'package:legalpedia/globals.dart' as globals;

class FormsContent extends StatefulWidget{

  @override
  _FormsContent createState()=> _FormsContent();

}

class _FormsContent extends State<FormsContent>{

  List<MaximList> maxim = List();
  List<MaximList> filteredmaxims = List();

  Future<bool> loader(){
    return showDialog(context: context,
    barrierDismissible: false,
    builder: (context)=> AlertDialog(
      title: ScalingText("Loading..."),
    ));
  }
  
  Future<String> checkconnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return 'Connected';
    } else {
       return 'Not Connected';
    }
  }

Future<bool> dialog(str){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> AlertDialog(
        title:Text('Connection Error') ,
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(str, style: TextStyle(
          fontSize: 14,
          color: Colors.red

        ),),
        SizedBox(height: 10.0,),
        Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.red,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){
                             Navigator.pop(context);
                              Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              'Back to home screen',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontSerrat'
                              ),
                            ),
                          ),
                        )
                    ),

                  ),
        ],) 
        
      ));
}


  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(iconTheme: new IconThemeData(color: Colors.white),
        elevation: 7.0,
        actionsIconTheme: new IconThemeData(color:  Colors.white),
        title: Text('Forms Content', style: TextStyle(
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
      ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[

          SizedBox(height: 20,),
          Text(globals.selectedFormTitle, style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontFamily: 'Monseratti',
            fontWeight: FontWeight.bold
          ),),

           SizedBox(height: 20,),
          Html(
                              data: globals.selectedFormContent,
                              customTextAlign: (dom.Node node) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "p":
                                      return TextAlign.left;
                                  }
                                }
                                return null;
                              },
                              customTextStyle: (dom.Node node, TextStyle baseStyle) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "p":
                                      return baseStyle.merge(TextStyle(height: 2, fontSize: 16, fontFamily: 'Monseratti'));
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
        ],
      ),
    );
  }


}


